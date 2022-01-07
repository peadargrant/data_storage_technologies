---
title: 'Network Attached Storage (NAS)'
---

Network Attached Storage
========================

NAS allows storage to be shared over a LAN at the filesystem level. This
contrasts to SAN where block level storage is provided. It is assumed in
a NAS environment that any number of clients can simultaneously connect
to the share.

Protocols
---------

summarises the NAS protocols commonly encountered.

<span>1.0</span>\[htbp\]<span>l l l X</span> **Protocol** &   & **Port**
& **Remarks**\
Server Message Block & SMB & 135,137-139,445 & Windows-centric but
cross-platform. Samba and CIFSd for Linux.\
Common Internet File System & CIFS &   & Attempted re-name of SMB by
Microsoft\
Network File System & NFS &   & UNIX centric but cross-platform.
Multiple versions, currently NFSv4. NFS client on Windows.\
Apple Filing Protocol & AFP & 548 & Developed from earlier AppleShare
protocol. Not often encountered.\
Netware Core Protocol & NCP & 524 & Like SMB has support for print and
other sharing as well.\

Points to note:

1.  Some protocols like SMB/CIFS and NCP were designed for more than
    file sharing. Print sharing, domain and interprocess communication
    were also facilitated. We won’t be dealing with these uses here.

2.  Most NAS protocols run over TCP/IP. Historically other transports
    were used like NetBIOS for SMB and IPX for NCP. Some
    idiosyncrancies remain.

3.  Although technically routable over WAN links, NAS protocols tended
    to be designed with LAN usage in mind. Often had poor/no security.

4.  If they need to be used off-site, best to use a VPN link. Tuning the
    configuration can help performance greatly when used over WAN or
    VPN links.

Access pattern
--------------

Network attached storage is normally utilised via a virtual filesystem.
This allows the network filesystem to be mounted (Unix) / mapped as a
drive letter (Windows): Points to note:

-   Client sees filesystem of the NAS protocol (SMB, NFS).

-   Client is unaware of the underlying filesystem (NTFS, ext4, etc) on
    the server. Also unaware of what block device (local, SAN etc) the
    filesystem resides on.

-   Share may be mounted read-only or read-write.

-   Permissions are a complex compound of:

    1.  Server filesystem permissions

    2.  Permissions defined within the share server

    3.  Client-side permissions

    Often issues when a Linux/UNIX client connects to an SMB share and
    multiple users on the UNIX client attempt to use the shared drive.
    Configuration can become very tricky!

As an alternative there are tools that can connect directly to the
shares like an FTP client, such as `smbclient` for Linux. Mobile apps
tend to work similarly.

Provisioning
============

General-purpose server
----------------------

General-purpose servers running standard operating systems have server
software installed for most common protocols. General arrangement:

1.  One or more shares configured. Each share points to a directory on
    the server’s filesystem.

2.  Server software configured to start on boot.

3.  Shares on UNIX-like OS are normally configured in the appropriate
    configuration file for the server program. Common examples:

    1.  `/etc/exports` file defines NFS exports (shares)

    2.  `exportfs` command can be used to manage NFS exports

    3.  `/etc/smb.conf` or similar Samba configuration file sets up SMB
        shares

4.  Windows OS allows configuration of shares from file explorer view
    or PowerShell.

5.  Storage may be provisioned on a local disk or may be on a LUN from
    a SAN.

Storage appliance
-----------------

A number of vendors supply NAS devices that can, as a minimum provide
SMB and/or NFS services. Often support many other services. Key vendors:
Synology, QNAP. Points to note:

-   Often 2 and 4-bay disk setup with RAID and/or LVM.

-   Usually built on Linux or FreeBSD internally with a custom web-based
    management application on top.

-   Some NAS-type devices also contain iSCSI Target Servers allowing
    SAN-type LUNs to be configured. These are normally backed either by
    LVM volumes or disk images.

-   May be possible to connect to a LUN as if it were an internal disk.

-   Low-power, quiet and useful in domestic (music, backup,
    video sharing) and light-commercial settings.

NAS gateway
-----------

A NAS gateway / NAS head / protocol converter delivers NAS shares from
SAN volumes. High-performance embedded dedicated storage appliance that
may have hardware acceleration.

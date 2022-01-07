% ISCSI SAN

SAN
===

A storage area network provides **hosts** (servers, desktops,
workstations) with access to consolidated **block-level storage** by
means of a **fabric**.

Layers
------

SANs are traditionally broken up into conceptual layers, .

Host layer:

:   consisting of the servers / computers that access storage
    provisioned through the SAN.

Fabric layer:

:   containing the networking cabling and hardware: hubs, switching,
    routing, protocol converters.

Storage layer:

:   consisting of storage appliances such as disk arrays, tape drives.

SCSI
----

Small Computer Systems Interface (SCSI) is a protocol used to connect
(mainly) storage devices to a host.

Parallel SCSI

:   using 50-pin and similar connectors

Serially-Attached SCSI (SAS)

:   drives are often seen as direct-attached storage in servers.

Because the protocol is well standardised, it often forms the basis of
SAN as it’s easy to encapsulate across a network.

SAN types
---------

Fibre Channel

:   encapsulates SCSI commands in Fibre-Channel Protocol (FCP) normally
    carried on optical fibre. Also Fibre-Channel Over Ethernet (FCoE)
    and Fibre-Channel over IP.

iSCSI

:   encapsulates SCSI commands in iSCSI protocol on TCP/IP carried over
    standard IP network.

Multiheaded-SAS

:   

Key concepts
------------

-   Storage appliances (like disk arrays) are set up with
    logical volumes. Due to historical SCSI terminology, these are
    called Logical Unit Numbers (LUNs).

-   A storage device exposes a **target** that has one or more logical
    block devices LUNs associated with it.

    -   Nowadays, most storage appliances can expose more than
        one target. Helps later with access control.

-   To access block storage over a SAN, a host’s **initiator** connects
    to a specific LUN on a specific target:

    -   The initiator is normally a Host-Bus Adapter. Like HBAs for DAS,
        HBA must match host’s bus type and the type of SAN being used.

    -   Can also have software-initiators for iSCSI and FCOIP.

    -   Although iSCSI and FCOIP are IP-based, HBA is separate to host’s
        normal networking.

    -   The NIC and HBA can be combined on a single card known as a
        Converged Networking Adapter (CNA).

Usage points
------------

-   Normally, a LUN can be attached to only one host at a time.

-   As a block device, the host OS is entirely in control of the
    LUN (e.g. formatting).

-   With a SAN HBA, the host OS is unaware that the disk is not a
    locally-attached disk:

    -   Boot-from-SAN possible with no local hard disk.

    -   SAN can be transparently used on mission-critical legacy systems
        (like Xenix, OS/2).

-   SAN can feature in backup configurations.

Non-shared storage
------------------

iSCSI conceptually just extends the physical disk drive cable over a
network. Just as we can’t normally connect a hard disk to two computers
at the same time, we can’t *normally* have two initiators logged into
the same LUN at the same time.

-   There is no problem detaching a LUN from a host and attaching it
    to another.

-   LUNs that are read-only can be attached to multiple machines at the
    same time.

-   There are so-called clustered filesystems available that permit
    multiple machines access to the same LUN at the same time. Used only
    in certain specific applications.

Some targets will permit only a single connection to a LUN. Others will
permit multiple connections, and data corruption is bound to occur if
this happens.

SAN vs NAS
----------

A SAN is distinct from NAS in one key respect:

**SAN $\ne$ NAS**

the SAN provisions a remote block level storage device for a host,
whilst the NAS provides a remote file system. SAN and NAS are
*complementary* technologies that address *different* use cases.

iSCSI
=====

IP SAN refers to SAN configurations that run over a standard IP network.
[^1] The most common type of IP SAN is iSCSI:

-   iSCSI allows hosts to attach themselves to remote block devices
    called LUNs.[^2] Once attached, they are no different to a physical
    hard disk, partition or logical volume.

-   iSCSI is very easy to get started using. It works over standard IP
    networking and can obviously co-exist with other network usage. Key
    software components are free and/or built-in to modern host OSes.

Components
----------

A **host** uses an **initiator** to attach to a specified **target**, .
The target may present as one or more **LUNs**.

![iSCSI initiator and target<span
data-label="fig:iscsi-initiator-and-target"></span>](iscsi_initiator_target){width="0.6\linewidth"}

Initiator
---------

-   Once attached, the host is entirely responsible for creating /
    managing filesystems on the LUN. *This is the key difference to
    Network Attached Storage (NAS).*

-   Initiator can be either:

    Software-based:

    :   part of the host OS (usually kernel-level driver)

    Hardware-based:

    :   controller card or built-in to chipset on host. Has *separate*
        IP configuration to host. Usually separate physical port. Can be
        *converged network adapter (CNA)* where both host networking and
        storage networking are on same physical port with different
        IP addresses.

![iSCSI offloading<span
data-label="fig:iscsi-offload"></span>](iscsi_offload){width="0.5\linewidth"}

Encapsulation
-------------

iSCSI carries SCSI commands over a standard TCP/IP network, .

![iSCSI stack<span
data-label="fig:iscsi-stack"></span>](iscsi_stack){width="0.6\linewidth"}

Protocol data units (PDUs)
--------------------------

iSCSI encapsulates SCSI commands within iSCSI protocol data units
(PDUs), .

![iSCSI encapsulation (EMC)<span
data-label="fig:iscsi-encapsulation"></span>](iscsi_encapsulation){width="0.6\linewidth"}

The encapsulation can be seen also in terms of how commands are
processed, .

![iSCSI write<span
data-label="fig:iscsi-write"></span>](iscsi_write){width="0.6\linewidth"}

Targets
=======

A **target** presents one or more **LUNs** to an initiator: Targets can
be provided in a number of ways: software target on a normal server OS,
specialised SAN appliance. Some cheaper NAS units have iSCSI target
capability also. iSCSI initiators connect to targets that present one or
more LUNs.

Target hardware
---------------

Dedicated storage appliances

:   for iSCSI storage:

    -   Often contain multiple drive holders.

    -   Can set up one or more RAID sets in multiple levels, possibly
        with hot spares.

    -   Can provision logical volumes on RAID sets (thin or
        thick provisioned)

    -   Presents as one or more targets, each with one or more LUNs.

    -   Tightly integrated hardware and custom OS (often
        Linux/Unix underneath).

    -   Designed for high availability, hot swap dual PSUs, redundant
        net interfaces.

    -   Often has management features like lights-out management card,
        SNMP support, web and CLI management.

General-purpose servers

:   using iSCSI target software:

    -   iSCSI target daemon can have one or more targets with one or
        more LUNS set up.

    -   LUNS can point to:

        Physical partition

        :   or any other block device

        Logical volume

        :   (since it’s just a block device)

        Disk image file

        :   in a number of possible formats

NAS units

:   primarily designed for file sharing often offer some iSCSI
    capabilities:

    -   Older units tended to use disk image files. More recent units
        tend to use LVM-like setup with iSCSI LUN provisioned as a
        logical volume.

    -   Cheap and easy way to experiment with iSCSI before committing to
        financial outlay.

Remember that as a network, an iSCSI storage scheme could encompass
multiple servers drawn from all of the above.

Connection
----------

To connect to a LUN we need to know:

-   The IP address or DNS name of the machine / device providing the
    target service.

-   The name of the target that is presenting the LUN we want. (Can
    query list of available targets from server)

The connection is made at the target level. Once made, all LUNs are
visible to the initiator as block devices.

Target naming (IQNs)
--------------------

iSCSI targets are named in a systematic way that can seem confusing at
first. Each target has an iSCSI Qualified Name, or IQN. IQNs have 4
parts:

iqn

:   literal string to denote this as an IQN.

naming authority

:   usually the reversed domain name of the company (sometimes storage
    appliance vendor)

date

:   when the naming authority assumed the name

target name string

:   defined by the naming authority (the format of these vary across
    different target server systems)

An example of an IQN might be:

-   `iqn.2019-12.ie.dkit.staffstorage` is an IQN for a target
    `staffstorage` by the `dkit.ie` naming authority who assumed control
    on `2019-12`.

In practice, the naming authority has nothing to do with DNS names other
than by convention. For simple applications, once you know the DNS name
/ IP of the server and the name of the target, you can normally discover
the IQN automatically.

Put simply, just accept that IQNs are strange-looking. As long as you
distinguish one target from another you will not have difficulty.

Username / passwords
--------------------

iSCSI provides basic username/password authentication using the
Challenge-Handshake Authentication Protocol (CHAP). CHAP secures a
target rather than individual LUNs. CHAP is not particularly secure.
Still on smaller networks, and to prevent mistakes, it’s useful to
require a username/password to connect to a target.

Storage appliances and software target servers normally have the CHAP
authentication as an option that can be enabled on a particular target.

You can also set up the initiator to require a username/password from
the target, known as mutual authentication. Having a server authenticate
to a client can seem odd, but it makes sure you’ve got the right disk
connected and that sensitive data isn’t written to an incorrect
location.

LUN masking
-----------

LUN masking is where a target presents only a subset of its LUNs
depending on what initiator is connecting. The LUNs that are masked from
a particular initiator do not appear to exist at all.

Support for LUN masking varies amongst target servers and storage
appliances.

iSCSI initiator operations
==========================

We will walk through the process of connecting to a LUN from the
point-of-view of the initiator. We will not worry about how the LUN is
provisioned at this point.

Scenario: a target is provisioned on a storage server with IP address
`192.168.1.4`. Naming authority is `storage.com` starting from December
2019 (`2019-12`). Target is named `stuff`. There are two LUNs in this
target.

Linux software initiator
------------------------

There are two parts to iSCSI on Linux: the kernel driver itself and the
surrounding software to administer iSCSI connections. Most linux
distributions nowadays use the open-iscsi package. Other UNIX variants
like FreeBSD have similar functionality.

1.  Host installs the `open-iscsi` package which provides the `iscsiadm`
    command. All `iscsiadm` commands need to be run as root (using sudo,
    omitted from steps below).

2.  Host runs **discovery** on the server to see available targets:

    ``` {.bash}
    iscsiadm --mode discovery --type sendtargets --portal 192.168.1.4
      
    ```

    Note you can abbreviate mode, type and portal switches as `m, t, p`
    as per the man page. The available targets will appear (this has
    just one):

        192.168.1.4:3260,1 iqn.2019-12.com.storage:stuff

    May see a second line for each target if the server is running both
    IPv4 and IPv6.

3.  Host **logs in** to the target:

    ``` {.bash}
    iscsiadm -m node -T iqn.2019-12.com.storage:stuff -p 192.168.1.4 --login
    # note here we use the short m, p switches
    ```

    Assuming the login step is successful, the LUNs on the target will
    appear as locally attached SCSI disks. So they will appear in `/dev`
    directory as `/dev/sd?` where ? is the drive letter.

4.  The host then can partition and format these disks as if they were
    locally attached physical devices. Usually GPT/MBR single partition.

5.  Host can disconnect by **logging out**:

    ``` {.bash}
    iscsiadm -m node -T iqn.2019-12.com.storage:stuff -p 192.168.1.4 --logout
    ```

    This is like plugging out a disk. Therefore the filesystems need to
    be unmounted (ejected) before issuing the logout command.

6.  Normally we would enable automatic login and ensure the iscsi
    service is set to start at boot-up.

Windows software initiator
--------------------------

Windows has a software initiator for iSCSI built-in to the operating
system. This can be accessed graphically or via PowerShell. Once
attached to a target, the LUN(s) appear in the Logical Disk Management
display and can be partitioned and formatted etc as normal.

Hardware HBA
------------

Hardware HBA allows attachment to iSCSI target without the knowledge of
the host OS.

-   Hardware HBA has its own independent connection to the network,
    separate to the host OS. It is a separate interface, with separate
    IP address etc.

-   HBA normally appears to the host OS as a SCSI disk controller card.

-   Some HBAs have a side-channel to the host OS (often appearing as a
    serial port) for management purposes. Some also include
    configuration tools / software.

Target provisioning operations
==============================

iSCSI provision requires the `tgt` server program. The iSCSI `tgt`
server can expose physical block devices, partitions, logical volumes
(basically anything with an entry in `/dev`) as a LUN. It can also
expose a disk image file on the filesystem as a LUN.

`tgt` can be installed on Ubuntu/Debian using:

``` {.bash}
  apt-get install -y tgt
```

Imagine our server has LVM set up with a volume group called `vg_main`
(possibly amongst others) on it. This VG contains a number of logical
volumes, including `lv_data`. We want to expose `lv_data` as a LUN on an
iSCSI target. Obviously the `lv_data` volume should not be mounted on
the host.

Basic target and LUN
--------------------

The `tgt` server program is controlled from the file `iscsi.conf`
located in the `/etc/tgt/conf.d` folder. The `iscsi.conf` is almost
XML-like and defines one or more targets with one or more LUNs. Each
target section defines one or more LUNs.

This example shows a target `iqn.2020-03.ie.peadargrant` containing one
LUN backed by the logical volume `/dev/vg_main/lv_data`:

    <target iqn.2020-03.ie.peadargrant>
        backing-store /dev/vg_main/lv_data
    </target>

The iSCSI target server needs to be restarted to pick up any changes:

    sudo systemctl restart tgt

We can use the `tgtadm` command to print out information about the
running tgt server:

    tgtadm --mode target --op show

Output looks like:

We can then connect to the running tgt server from another machine using
any iSCSI initiator. It doesn’t matter whether it’s a hardware HBA or
CNA or a software initiator, or what OS is involved.

CHAP authentication
-------------------

Our example above could require for example, `student` and `1Password`
as follows:

    <target iqn.2020-03.ie.peadargrant>
        backing-store /dev/vg_main/lv_data
        incominguser student 1Password
    </target>

If you want mutual authentication, the `outgoinguser` parameter works in
the same way as `incominguser` to handle this. Obviously the initiator
will need to be set up correctly too.

[^1]: We don’t think about non-IP uses of Ethernet very often. Later on,
    we’ll see how a different type of SAN works over ethernet without
    IP. Other specialised protocols exist too: many entertainment venues
    use the Dante protocol to provide low-latency audio connections over
    ethernet.

[^2]: LUNs are logical unit numbers, a carry-over from SCSI

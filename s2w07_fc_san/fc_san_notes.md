---
title: 'Fibre Channel (FC) SAN'
---

Fibre Channel
=============

Fibre Channel (FC) SAN normally involves the use of Fibre Channel
Protocol (FCP) over an optical fibre network.

Comparison to IP SAN
--------------------

-   FC SAN shares most of the ideas of iSCSI - block devices exposed as
    LUNs on targets that initiators connect to.

-   FC normally encapsulates SCSI commands, same as iSCSI. *This is
    important later on, as we can bridge the two if needs be.*

-   iSCSI runs over TCP/IP. FCP does not run natively over IP, and has
    its own addressing schemes etc.

-   IP SAN often mixes SAN and non-SAN traffic on one LAN. FC normally
    is dedicated for storage.

-   FC normally uses hardware HBA rather than software-based initiators.

-   Generally FC is more costly than iSCSI, but performance and
    reliability are higher.

Components
----------

Host-Bus Adapter (HBA):

:   normally appears as a standard disk controller to the operating
    system and has the appropriate fibre channel network connections.
    Note that the fibre channel network is entirely separate from the
    host’s LAN connection.

Fabric components:

:   such as hubs, switches, etc. Specific to Fibre Channel!

Connections
-----------

As its name suggests, Fibre Channel usually involves optical fibre
transmission:

-   Both multi-mode (MMF) OM1, OM2, OM3 types and single-mode used.
    Multi-mode used within data centre / suite. Single-mode used for
    longer distances.

-   The standard SC, LC, ST connectors are often seen.

-   Confusingly, fibre channel can also be carried over copper.

Fabric types
============

Point-to-Point
--------------

The simplest fabric is a point-to-point where a single host node
connects to a single storage node. Both the host and storage nodes ports
are N\_ports (node ports).

![Point-To-Point (Wikipedia, adapted)<span
data-label="fig:fc-point-to-point"></span>](fc_point_to_point){width="0.5\linewidth"}

These are sometimes seen where a single storage appliance has multiple N
ports, each of which is connected to an N port on a host.

Switched fabric
---------------

Most SAN implementations involve a switched fabric, .

![FC switched fabric (Wikipedia, adapted)<span
data-label="fig:fc-switched-fabric"></span>](fc_switched_fabric){width="0.6\linewidth"}

Within a switched fabric, ports are designated as different types. Main
types are:

N\_port (node port)

:   connects either to another N\_port as in this example or to an F
    port on a switch.

F\_port (fabric port)

:   on a switch connects to an N\_port on node.

E\_port (expansion port)

:   on a switch connects to an E\_port on another switch.

    -   Link between two switches is called an **inter-switch
        link** (ISL).

G\_port

:   can act as either an $F$ or $G$ port.

We say that a fabric has a number of **tiers** with an $n$-tier fabric
requiring traffic to pass through up to $n$ switches.

Layers
======

Fibre Channel is conceptually divided into 5 layers, .

![Fibre Channel Layers
(<http://hsi.web.cern.ch/HSI/fcs/spec/overview.htm>)<span
data-label="fig:fc-layers"></span>](fc_layers){width="0.6\linewidth"}

FC-0 is the physical layer and FC-4 is the application layer.

Encapsulation
=============

FC SAN encapsulates SCSI data in FC frames, .

![FC frame (<http://hsi.web.cern.ch/HSI/fcs/spec/overview.htm>)<span
data-label="fig:fc-frame"></span>](fc_frame){width="0.6\linewidth"}

4-bytes start-of-frame

:   

24-byte frame header

:   including source and destination addresses (specific to FC)

2112-byte data field

:   consisting of:

    64-byte header (optional)

    :   

    2048-byte data payload

    :   containing SCSI commands (just as with iSCSI in IP SAN)

4-byte CRC error check

:   

4-byte end-of-frame

:   

Addressing
==========

As we can see from the FC frames, we need addresses to identify the
source and destination of FC traffic. Like IP over Ethernet, FC has two
different types of addresses:

FC address
----------

FC addresses are 24-bit dynamically assigned addresses, .

![FC address (EMC ISM book)<span
data-label="fig:fc-address"></span>](fc_address){width="0.8\linewidth"}

Domain ID (8-bit)

:   is a unique number assigned to each switch in fabric. Only 239
    addresses available as some reserved for fabric management services.

Area ID (8-bit)

:   denotes a group of ports on one switch (such as a single card)

Port ID (8-bit)

:   port within the area ID within the domain ID.

Maximum number of nodes in switched fabric: $$\begin{aligned}
  \mbox{239 domains} \times \mbox{256 areas} \times \mbox{256 ports} & = 15663104\end{aligned}$$
FC address is automatically assigned when an $N$ port logs on to the
fabric. Like DHCP-assigned IP address but deterministic.

WWN
---

WorldWide Names (WWNs) are FC equivalent of MAC addresses, . They are
considered fixed and normally set/burned in in factory.

![FC world wide name (WWN) (EMC ISM book)<span
data-label="fig:fc-wwn"></span>](fc_wwn){width="0.8\linewidth"}

WWNs are mapped to FC addresses using the Name Server. Opposite to IP
networking, we often want to find devices using WWNs which are resolved
to FC addresses.

Fabric services
===============

Each switch provides a number of services at fixed FC addresses (drawn
from the reserved range), .

![FC fabric services (EMC ISM book)<span
data-label="fig:fc-fabric-services"></span>](fc_fabric_services){width="0.6\linewidth"}

Fabric Login Server (FFFFFE)

:   used for node login (connection) to the fabric.

Name Server (FFFFFC)

:   tracks FC address to WWN associations. Like ARP in IP networking.

    -   Synchronises automatically with name servers in other switches
        in fabric.

    -   *Formerly called Distributed Name Service but was ambiguous
        since DNS abbreviation means Domain Name Service which is
        entirely different.*

Fabric Controller (FFFFFD)

:   updates nodes and other switches when changes in the fabric occur,
    like a device or link being added or removed. When changes occur it
    distributes:

    Registered State Change Notifications (RSCNs)

    :   to nodes attached to its own ports.

    Switch Registered State Change Notifications (SW-RSCNs)

    :   to other switches in the fabric. This causes the name servers
        to update.

Management Server (FFFFFA)

:   allows managment software to monitor and control the operation of
    the fabric.

Login types
-----------

Fabric Login (FLOG)

:   when an $N$ port (on a host / storage device) connects to an $F$
    port (on a switch):

    -   During FLOG, WWN of node and port are passed to login
        server (FFFFFE).

    -   Login server returns FC address to node.

    -   Login server registers WWN with FC address so node can be found
        by WWN.

Port login (PLOG)

:   when an $N$ port on an initiator makes a connection to the $N$ port
    on a target through the fabric. (Must have completed FLOG first.)

Process Login (PRLI)

:   which establishes the Upper Layer Protocol (ULP) (such as SCSI)
    between two $N$ ports.

Zoning
======

Zoning is where ports in the fabric are logically grouped together, .
Zoning can provide security benefit, avoid accidental mis-configuration
and increase performance. Conceptually like ethernet VLAN.

![FC zoning (EMC ISM book)<span
data-label="fig:fc-zoning"></span>](fc_zoning){width="0.4\linewidth"}

-   When zoning is used, a port may be a member of one or more zones.
    Nodes only see other nodes that are same zone as themselves. A zone
    can span multiple switches in the fabric.

-   Without zoning, all nodes get all RSCNs. In zoned FC, RSCNs get sent
    only to nodes in zone. Cuts down on the amount of fabric managament
    traffic if done correctly.

-   Zone set comprises multiple zones. Can be activated / deactivated as
    single unit within fabric. Only one zone can be active at one time.

Zone types
----------

Port zoning

:   where switch ports are grouped into zone(s). (Easy replacement of
    failed devices.)

WWN zoning

:   where WWNs are grouped into zones. (Allows physical movement.)

Mixed zoning

:   combining both. E.g. host WWN and storage port or vice-versa.

Single HBA zoning

:   each HBA has own zone created and relevant storage added to it.

![FC Zone types (EMC ISM book)<span
data-label="fig:fc-zone-types"></span>](fc_zone_types){width="0.5\linewidth"}

Topologies
==========

Single-switch
-------------

Single switch topologies are now very common:

-   Most FC deployments are in data centre environments where overall
    distance is low.

-   Increasing number of ports per switch.

-   Cheap and easy to administer. No ISLs, simple fabric.

Mesh fabric
-----------

A mesh fabric involves multiple switches connected such that each is
connected redundantly to other switches, .

![Mesh topologies (EMC ISM book)<span
data-label="fig:fc-mesh-topologies"></span>](fc_mesh_topologies){width="0.5\linewidth"}

Full mesh

:   where any switch in the fabric is linked to all others directly.

Partial mesh

:   where crossing multiple ISLs are necessary to get to some switches.

Core-Edge Fabric
----------------

Core-edge fabrics involve a core tier that connects storage device to
edge switches that connect to host devices, . Many variations on this
theme.

![Single-core topology (EMC ISM book)<span
data-label="fig:fc-single-core-topology"></span>](fc_single_core_topology){width="0.5\linewidth"}

Need for integration
====================

FC SAN primarily is a highly reliable, high-perforamance,
data-centre-centric solution that comes at considerable cost. The FCP is
non-routable, and is therefored confined spatially. Often we want to
broaden access to our existing FC SAN by means of integration
technologies.

Generally, we shouldn’t start out building a SAN that needs to use these
primarily. Like WiFi-extenders, poorly thought-out SAN integration can
do more harm than good!

Fibre Channel over Ethernet (FCoE)
==================================

FCoE is where FCP runs over existing ethernet infrastructure, usually on
CAT5/6 cabling. It can coexist with LAN traffic. Normally its used to
connect ethernet-attached hosts to an existing FC SAN fabric.

Layers 1 and 2 are the same we are familiar with from IP networking. The
key difference occurs at Layer 3: FCP is encapsulated in ethernet
frames.

FCoE frame format
-----------------

shows the format of a FCoE frame. The Ethertype denotes the frame as
FCoE (as opposed to IP).

![FCoE frame (Wikipedia)<span
data-label="fig:fcoe-frame"></span>](fcoe_frame){width="0.4\linewidth"}

FCoE fabric
-----------

FC natively has a lossless transport. Protocols such as IP running over
ethernet normally are tolerant of frames being dropped when congestion
is high. FCoE requires extensions to the ethernet protocol to guarantee
lossless transmission, called Priority Flow Control.

In practical terms, we need to use a FCoE-aware switch.

FCoE-FC gateway
---------------

A FCoE gateway will connect FCoE devices to an existing FC network, .
The gateway acts as a so-called fibre channel forwarder to bridge the
FCoE to the FC. Additionally it provides the normal fabric services.

![FCoE gateway<span
data-label="fig:fcoe-gateway"></span>](fcoe_gateway){width="0.9\linewidth"}

This is actually quite a complex process under the hood, as mapping is
required from WWNs to MAC addresses. The gateway device is often a FC
switch/director with an FCoE card fitted.

FCoE host hardware
------------------

Hosts traditionally use a FCoE HBA to connect to the FCoE-provided
fabric. Software initiators are theoretically possible, like `open-fcoe`
but are unusual to see in use.

Since FCoE and IP LAN traffic run over ethernet, we can converge the two
using a FCoE Converged Networking Adapter. This is similar to the CNA we
discussed for iSCSI, in that it includes the SAN HBA and NIC on one
card. shows a CNA handling both sets of traffic which split at a
FCoE-aware switch.

![FCoE converged networking (Wikipedia)<span
data-label="fig:fcoe-cna"></span>](fcoe_cna){width="0.9\linewidth"}

It is generally recommended that VLANs are used to separate FCoE and IP
traffic where they co-exist.

Application Areas
-----------------

FCoE’s primary purpose is to extend FC SAN by re-using CAT-6 cabling
and/or existing ethernet networking. It would be highly unusual to build
an entire SAN primarily around FCoE.

Although converged networking is beneficial in many applications, FCoE
would not be a primary means of doing so.

FCoE requires gateways, FCoE-aware switches and other expensive
hardware. It is normally not cost effective compared to IP SAN.

FCoE is not routable, and can’t cross Layer-2 boundaries. Therefore it’s
primarily seen within a data centre or single-building environment.

**In summary, FCoE is best used to connect hosts to an existing FC SAN
over CAT5/6-carried ethernet where it is impractical to extend the FC
SAN directly to them.**

Fibre Channel over IP (FCIP)
============================

Fibre Channel over IP (FCIP) encapsulates fibre channel within IP
packets on an existing IP network. FCIP is normally used to tunnel
directly between two remote FC networks, , and is not used by individual
hosts.

![FC san extended using FCIP (TechTarget)<span
data-label="fig:fcip-network"></span>](fcip_network){width="1.0\linewidth"}

Configuration is generally needed of the two bridges and the network
between them. The encapsulation process does lower performance compared
to native FC or FCoE.

Application areas
-----------------

**Generally FCIP is appropriate where we need to bridge two physically
remote FC networks into one fabric across a routed IP or WAN link.** It
is our only option when the link involves a WAN or having to cross
Layer-2 boundaries.

If the two FC networks can be connected directly CAT5/6 then FCoE may be
more suitable than FCIP.

Given that the FCIP link is slower than other links in the FC fabric, it
works best where there is comparatively little traffic on the bridged
link. FCIP is therefore good for scenarios like offsite backup,
replication and accessing archival storage.

FC-iSCSI integration
====================

FC and iSCSI both encapsulate SCSI commands, so conceptally they can be
bridged. This is normally done using a FC to iSCSI gateway, . As iSCSI
runs over TCP/IP it is routable across Layer-2 boundaries.

![iSCSI hosts accessing FC storage via gateway (Cisco)<span
data-label="fig:fc-iscsi-gateway"></span>](fc_iscsi_bridge){width="0.7\linewidth"}

Application areas
-----------------

-   Leveraging existing FC SAN for lower-traffic hosts at minimal cost
    using software initiators or inbuilt HBAs.

-   Allowing iSCSI-capable workstations to directly access
    FC-SAN storage.

-   Giving access to FC SAN for servers that need to be located distant
    from the FC SAN.

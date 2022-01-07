---
title: 'Direct-attached storage'
---

Direct-Attached Storage
=======================

Direct Attached Storage is where a storage device connects 1:1 with host
without a network:

Host

:   is name given to computer system using storage. (Laptop PC, server
    or mainframe.)

    -   Host normally has an internal bus. (PC-based systems: PCI bus).

Storage device:

:   magnetic disk, solid state drive, tape drive, multi-host
    storage appliance.

Host Bus Adapter (HBA)

:   connects host to storage device. The HBA ...

    -   ... needs driver support from the host operating system,
        although many use one of a few generic drivers.

    -   ... must match interface on the disk side AND the host’s
        expansion bus (PCI, ISA, others).

    -   ... nowadays often integrated on the host’s motherboard.

Interface

:   defines electrical and communication characteristics between the HBA
    and the storage device.

    -   Common interfaces ATA/IDE/PATA, SATA, SCSI and SAS.

Interface types
===============

ATA/IDE/PATA

:   

Serial ATA (SATA)

:   

Small Computer Systems Interface (SCSI)

:   

Serially Attached SCSI (SAS)

:   

Operating system
----------------

-   Host operating system will see so-called block devices representing
    each individual disk attached to the HBA.

-   Block devices can then be partitioned or otherwise spatially managed
    by the host operating system.

-   Operating system normally inserts another layer of abstraction —
    the filesystem.

Multi-device DAS
================

Port multipliers
----------------

Port multipliers can allow a single DAS port to connect to more than one
device, :

-   HBA must support port multiplier usage

-   Port multiplier is transparent to individual disks

-   Bandwidth is shared

Storage appliances
------------------

A storage appliance with multiple disks can connect these to 1 or more
hosts in DAS-type configuration (usually SAS).

Controller utilisation
======================

The utilisation, $U$ of a disk controller ranges from 0 to 1:

	0 <= U <= 1

Although we commonly talk about utilisation as a percentage,
we must convert it to a decimal fraction when working out calculations that involve utilisation.
For example, 30% utilisation would mean that `U=0.3`.

Average response time
---------------------

The average response time, $R$, depends on the disk service time, taking
into account the controller utilisation:

	R = Ts / ( 1 - U )

Example: Response time under load
The disk service time of a disk under no load is 7.8ms.
What would the response time expected under 70% load be?

	R = 7.8ms ( 1 - 0.7 )
      = 26ms

IOPS vs utilisation
-------------------

A drive will be advertised as capable of doing a certain number of IOPS.
However, if we want to keep response times within a certain limit, we
may limit the number of IOPS to a certain number.

	IOPS limit = U desired * IOPS advertised

Example: IOPS under load: 
A drive is advertised as being capable of 180 IOPS.
Determine the maximum permissible IOPS if load is limited to 70%.

	IOPS @ 70%  load = 180 * 0.7
	                 = 126 IOPS

Multiple disks
--------------

Sometimes one disk cannot meet the application requirements on its own.
For a given application, the number of disks required, DR, will be
determined by two other quantities:

-   Number of disks required to meet the capacity, DC.

-   Number of disks required to meet the application IOPS requirement,
    DI, at a given utilisation U.

The higher of these two quantities determine D:

	DR = max ( DC, DI) 

Note that this requirement does not specify at what level the disks are combined.

Meeting IOPS requirement
------------------------

A common situation is where a given application seeks to guarantee a
minimum number of IOPS with a given controller utilisation time. This
can be done by:

1.  Use the controller utilisation to determine the number of
    available IOPS.

2.  Divide the required IOPs among the number of available IOPS to get
    the minmum number of disks.

Example: Disk required for IOPS at utilisation
A given application has a requirement of 3600 IOPS.
The disks available have a maximum of 180 IOPS.
Determine how many disks are required assuming a maximum utilisation of 80%

	available IOPS = 180 * 0.8
	               = 144
	disks required = ceil( 3600 / 144 )
	               = 25


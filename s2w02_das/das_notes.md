---
title: 'Direct-attached storage'
---

Disk service time
=================

The disk service time, TS is the time taken by a disk to complete an
I/O request, composed of:

1. the seek time, T
2. average rotational latency, L
3. data transfer time, X

where:

	TS = T + L + X

Seek / access time
------------------

Seek time is the time required to position the head on the correct
track. Obviously this isn’t uniform, so seek time is given separately:

Full stroke:

:   time taken to move from innermost to outermost track.

Track-to-track:

:   time taken to move between adjacent tracks.

Average:

:   time taken to move head from one random track to another.

We are normally concerned with the average seek time, defined as
one-third of the full stroke:

	average seek time = full-stroke seek time / 3
	full-stroke seek time = full-stroke seek time * 3
	
Typical average seek times would range from .

Example: Calculate the full-stroke seek time for a drive given an average seek time of 6ms.

	full-stroke seek time = 6 ms * 3
	                      = 18ms

Rotational latency
------------------

The average rotational latency, L, is the time taken for the drive to
revolve half a revolution:

	L = 0.5 / revolutions per second

This measure depends on drive speed, we must convert RPM to
revolutions per second.

Example: Rotational latency: Determine the average rotational latency for a 5400-rpm drive:

	5400 RPM = 5400 / 60 RPs
		     = 90 RPs
           L = 0.5 / 90 
             = 5.5 ms


Internal transfer time (X)
--------------------------

The data transfer time is how long it takes for one block of data (at a
given size) to be transferred inside the drive.

	X = block size / internal transfer rate

Example: Internal transfer time
Determine the transfer time given an internal transfer rate of and a
block size of .

    X = 32kB / 40 MB/s
      = ( 32 * 1024 ) / ( 40 * 1024 * 1024 )
      = 0.78 ms

IOPS
----

Storage performance is commonly quantified in Input/Output operations
Per Second (or IOPS), which is the reciprocal of the disk service time, TS.

	IOPS = 1.0 / TS

Native command queueing
=======================

![Native command queueing](ncq_diagram.svg)

A hard disk receives multiple commands in quick succession. Each command
will be delayed by seek time and rotational latency.

SATA Native Command Queueing tries to optimise the overall latency by
re-ordering the commands to reduce these latencies, .

All NCQ algorithms will optimise the seek time, but some will also
optimise the rotational latency.



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


---
bibliography:
- 'bibliography.bib'
title: Backup
---

Backup
======

You will find most of the ideas in [@ism-book].

Terminology
-----------

Production data

:   is actively used in the course of day-to-day operations.

Backup:

:   additional copy of production data that is created and retained for
    the sole purpose of recovering lost or corrupted data.

Archive:

:   store of data that is no longer actively used that is retained on
    low-cost secondary storage.

Purpose
-------

Disaster recovery

:   where production systems are damaged / destroyed.

Operational recovery

:   where data loss / corruption occurs due to application failure or
    user error (e.g. important email deleted).

Archival

:   for regulatory compliance, historical record, later analysis etc.

Parameters
----------

Recovery Point Objective (RPO)

:   the most recent point in time to which we should be able to restore.
    Dictates backup frequency.

Recovery Time Objective (RTO)

:   is the time taken to restore the system to the RPO point after an
    incident occurs.

Methods
-------

Hot / online:

:   production system is running during backup:

    -   Does not interrupt normal operation

    -   Issues with open files, particularly database backend stores.

Cold / offline:

:   production system is shut-down for normal operations.

Scope
-----

Scope refers to what is actually backed up:

-   Files themselves

-   Files and their layout (e.g. folders, symlinks)

-   Metadata (permissions, last updated)

-   Is a *Bare Metal Recovery* required?

Backup granularity
==================

There are three common granularities of backup, . [See Acronis
article](https://www.acronis.com/en-us/articles/incremental-differential-backups/)
on different granularities for further info.

Full backup
-----------

Full backup contains the entire dataset:

-   Completeness.

-   Frequent full backups may be prohibitive in terms of time and/or
    storage space.

Incremenetal backup
-------------------

Incremental backups store only the files changed since the most recent
full or incremental backup was taken. Restoration steps are shown in .

Cumulative / Differential backup
--------------------------------

Differential backup includes files changed since the last **full**
backup. Restoration steps are shown in

Targets
=======

Backup data is written to targets. Like any other storage media, targets
may be directly attached to a host or may be LAN or SAN attached.

Disk
----

Disk-based backup has low cost, fast backup and recovery. Should be
using monitored RAID to ensure backup availability.

Tape
----

Backup traditionally has used tape media.

Tape drives are best operated such that they do not have to start/stop
repeatedly during operation. Interleaving can be used so that multiple
streams of data can be written to a tape at speed, .

Tape libraries
--------------

Tape backup can be provisioned on a tape library in medium-large
installations, .

Virtual tape library
--------------------

Virtual tape library emulates a tape library but is actually provisioned
usually from SAN LUNs, .

Targets comparison
------------------

Comparison of different targets is given in .

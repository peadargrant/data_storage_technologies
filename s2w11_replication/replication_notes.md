---
title: Replication
---

Replication
===========

We primarily consider *remote* replication and assume a SAN-based
environment.

Terminology
-----------

Production host

:   in normal operations runs applications that access *source* data.

Source

:   or production LUNs (volumes) hold data normally accessed by the
    production host.

Target

:   LUN(s) where production data is replicated

Recoverability

:   is the restoration of data from replicas to source.

Restartability

:   is the restart of business operations using the replicas.

Point-in-time vs continuous replica
-----------------------------------

Point-in-time 

:   is a snapshot of the source LUN at some particular time.

Continuous

:   replica is in sync with the production data under normal operation.

Replica uses
------------

Alternative backup source

:   from a PIT replica to avoid impacting on production performance.

Fast recovery

:   on source device failure: restoring data to different new source
    device or restarting production directly on the replica.

Reporting or analytics

:   undertaken on replica to avoid impacting production performance.

Testing platform

:   for testing changes / updates on a testing environment before
    applying to production environment.

Modes
=====

There are two replication modes, synchronous and asynchronous.

Synchronous
-----------

shows the general sequence of synchronous replication.

Asynchronoous
-------------

Technologies
============

Host-based
----------

Array-based
-----------

### Synchronous

### Asynchronous

Network-based
-------------

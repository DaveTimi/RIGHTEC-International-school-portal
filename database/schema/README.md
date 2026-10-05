# Levity Ethics Systems — Database Schema

This directory contains the database schema definitions for Levity Ethics Systems (LES).

LES is a multi-school platform.

Every school is an independent tenant, and school-owned records must be associated with the correct `school_id`.

## Core entities

The initial database will contain:

- Schools
- Users
- School memberships
- Students
- Parents / Guardians
- Staff
- Classes
- Subjects
- Academic sessions
- Academic terms
- Attendance
- Examinations
- Results
- Assignments
- Fees
- Payments
- Announcements
- Notifications
- Documents
- Audit logs

## Multi-tenancy rule

Any entity containing school-owned data must be connected to a school.

Example:

```text
School
   ↓
Students
   ↓
Attendance
   ↓
Results
   ↓
Fees

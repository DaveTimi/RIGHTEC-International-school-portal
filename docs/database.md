# Levity Ethics Systems — Database

## Database Technology

Levity Ethics Systems uses Cloudflare D1 as its production SQL database.

D1 is based on SQLite and works directly with Cloudflare Workers.

## Database Architecture

LES is a multi-tenant platform.

Each school is treated as an independent tenant.

School-owned records contain a `school_id` that connects the
record to the correct school.

Example:

```text
School
   |
   +-- Users
   |
   +-- Staff
   |
   +-- Students
   |
   +-- Classes
   |
   +-- Subjects
   |
   +-- Attendance
   |
   +-- Examinations
   |
   +-- Results
   |
   +-- Fees
   |
   +-- Payments
   |
   +-- Announcements
   |
   +-- Documents

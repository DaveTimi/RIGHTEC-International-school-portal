-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- INITIAL DATABASE SCHEMA MIGRATION
-- ============================================================

PRAGMA foreign_keys = ON;

-- ============================================================
-- SCHOOLS
-- ============================================================

CREATE TABLE IF NOT EXISTS schools (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE,
    status TEXT NOT NULL DEFAULT 'active'
        CHECK (status IN ('active', 'suspended', 'inactive')),
    logo_url TEXT,
    email TEXT,
    phone TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    country TEXT DEFAULT 'Nigeria',
    timezone TEXT DEFAULT 'Africa/Lagos',
    settings_json TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- USERS
-- ============================================================

CREATE TABLE IF NOT EXISTS users (
    id TEXT PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    phone TEXT,
    status TEXT NOT NULL DEFAULT 'pending'
        CHECK (status IN ('active', 'suspended', 'pending', 'inactive')),
    avatar_url TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- SCHOOL MEMBERSHIPS
-- ============================================================

CREATE TABLE IF NOT EXISTS school_members (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    role TEXT NOT NULL
        CHECK (
            role IN (
                'school_owner',
                'school_admin',
                'principal',
                'vice_principal',
                'teacher',
                'bursar',
                'staff',
                'student',
                'parent'
            )
        ),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    UNIQUE (school_id, user_id)
);

-- ============================================================
-- STUDENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS students (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    user_id TEXT,
    admission_number TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    middle_name TEXT,
    date_of_birth TEXT,
    gender TEXT CHECK (gender IN ('male', 'female', 'other')),
    status TEXT NOT NULL DEFAULT 'active'
        CHECK (
            status IN (
                'active',
                'graduated',
                'transferred',
                'suspended',
                'inactive'
            )
        ),
    admission_date TEXT,
    photo_url TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    country TEXT DEFAULT 'Nigeria',
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE SET NULL,

    UNIQUE (school_id, admission_number)
);

-- ============================================================
-- PARENTS / GUARDIANS
-- ============================================================

CREATE TABLE IF NOT EXISTS parents (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    user_id TEXT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    middle_name TEXT,
    relationship TEXT NOT NULL,
    phone TEXT,
    email TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    country TEXT DEFAULT 'Nigeria',
    status TEXT NOT NULL DEFAULT 'active'
        CHECK (status IN ('active', 'inactive')),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- ============================================================
-- STAFF
-- ============================================================

CREATE TABLE IF NOT EXISTS staff (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    user_id TEXT,
    employee_number TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    middle_name TEXT,
    department TEXT,
    position TEXT NOT NULL,
    employment_type TEXT NOT NULL DEFAULT 'full_time'
        CHECK (
            employment_type IN (
                'full_time',
                'part_time',
                'contract',
                'temporary'
            )
        ),
    status TEXT NOT NULL DEFAULT 'active'
        CHECK (
            status IN (
                'active',
                'on_leave',
                'suspended',
                'inactive'
            )
        ),
    date_joined TEXT,
    phone TEXT,
    email TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    country TEXT DEFAULT 'Nigeria',
    photo_url TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE SET NULL,

    UNIQUE (school_id, employee_number)
);

-- ============================================================
-- CLASSES
-- ============================================================

CREATE TABLE IF NOT EXISTS classes (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    name TEXT NOT NULL,
    code TEXT,
    description TEXT,
    level TEXT,
    section TEXT,
    class_teacher_id TEXT,
    capacity INTEGER,
    status TEXT NOT NULL DEFAULT 'active'
        CHECK (status IN ('active', 'inactive')),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (class_teacher_id)
        REFERENCES staff(id)
        ON DELETE SET NULL,

    UNIQUE (school_id, name, section)
);

-- ============================================================
-- SUBJECTS
-- ============================================================

CREATE TABLE IF NOT EXISTS subjects (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    name TEXT NOT NULL,
    code TEXT,
    description TEXT,
    status TEXT NOT NULL DEFAULT 'active'
        CHECK (status IN ('active', 'inactive')),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    UNIQUE (school_id, name),
    UNIQUE (school_id, code)
);

-- ============================================================
-- ACADEMIC SESSIONS
-- ============================================================

CREATE TABLE IF NOT EXISTS academic_sessions (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    name TEXT NOT NULL,
    start_date TEXT NOT NULL,
    end_date TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'upcoming'
        CHECK (
            status IN (
                'upcoming',
                'active',
                'completed',
                'cancelled'
            )
        ),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    UNIQUE (school_id, name)
);

-- ============================================================
-- ACADEMIC TERMS
-- ============================================================

CREATE TABLE IF NOT EXISTS academic_terms (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    academic_session_id TEXT NOT NULL,
    name TEXT NOT NULL,
    start_date TEXT NOT NULL,
    end_date TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'upcoming'
        CHECK (
            status IN (
                'upcoming',
                'active',
                'completed',
                'cancelled'
            )
        ),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (academic_session_id)
        REFERENCES academic_sessions(id)
        ON DELETE CASCADE,

    UNIQUE (school_id, academic_session_id, name)
);

-- ============================================================
-- ATTENDANCE
-- ============================================================

CREATE TABLE IF NOT EXISTS attendance (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    student_id TEXT NOT NULL,
    class_id TEXT,
    academic_session_id TEXT,
    academic_term_id TEXT,
    attendance_date TEXT NOT NULL,
    status TEXT NOT NULL
        CHECK (
            status IN (
                'present',
                'absent',
                'late',
                'excused'
            )
        ),
    check_in_time TEXT,
    check_out_time TEXT,
    remarks TEXT,
    recorded_by TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE,

    FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON DELETE SET NULL,

    FOREIGN KEY (academic_session_id)
        REFERENCES academic_sessions(id)
        ON DELETE SET NULL,

    FOREIGN KEY (academic_term_id)
        REFERENCES academic_terms(id)
        ON DELETE SET NULL,

    FOREIGN KEY (recorded_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    UNIQUE (school_id, student_id, attendance_date)
);

-- ============================================================
-- EXAMINATIONS
-- ============================================================

CREATE TABLE IF NOT EXISTS examinations (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    academic_session_id TEXT NOT NULL,
    academic_term_id TEXT NOT NULL,
    class_id TEXT NOT NULL,
    subject_id TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    examination_type TEXT NOT NULL DEFAULT 'exam'
        CHECK (
            examination_type IN (
                'exam',
                'test',
                'quiz',
                'assignment',
                'project'
            )
        ),
    total_marks INTEGER NOT NULL DEFAULT 100,
    examination_date TEXT,
    start_time TEXT,
    end_time TEXT,
    status TEXT NOT NULL DEFAULT 'draft'
        CHECK (
            status IN (
                'draft',
                'published',
                'ongoing',
                'completed',
                'cancelled'
            )
        ),
    created_by TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (academic_session_id)
        REFERENCES academic_sessions(id)
        ON DELETE CASCADE,

    FOREIGN KEY (academic_term_id)
        REFERENCES academic_terms(id)
        ON DELETE CASCADE,

    FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON DELETE CASCADE,

    FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON DELETE CASCADE,

    FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- ============================================================
-- RESULTS
-- ============================================================

CREATE TABLE IF NOT EXISTS results (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    examination_id TEXT NOT NULL,
    student_id TEXT NOT NULL,
    subject_id TEXT NOT NULL,
    marks_obtained REAL NOT NULL DEFAULT 0,
    total_marks REAL NOT NULL DEFAULT 100,
    grade TEXT,
    grade_point REAL,
    position INTEGER,
    remarks TEXT,
    status TEXT NOT NULL DEFAULT 'draft'
        CHECK (
            status IN (
                'draft',
                'published',
                'locked'
            )
        ),
    entered_by TEXT,
    approved_by TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (examination_id)
        REFERENCES examinations(id)
        ON DELETE CASCADE,

    FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE,

    FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON DELETE CASCADE,

    FOREIGN KEY (entered_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    FOREIGN KEY (approved_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    UNIQUE (school_id, examination_id, student_id)
);

-- ============================================================
-- ASSIGNMENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS assignments (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    academic_session_id TEXT NOT NULL,
    academic_term_id TEXT NOT NULL,
    class_id TEXT NOT NULL,
    subject_id TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    instructions TEXT,
    due_date TEXT,
    total_marks REAL DEFAULT 100,
    status TEXT NOT NULL DEFAULT 'draft'
        CHECK (
            status IN (
                'draft',
                'published',
                'closed',
                'cancelled'
            )
        ),
    created_by TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (academic_session_id)
        REFERENCES academic_sessions(id)
        ON DELETE CASCADE,

    FOREIGN KEY (academic_term_id)
        REFERENCES academic_terms(id)
        ON DELETE CASCADE,

    FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON DELETE CASCADE,

    FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON DELETE CASCADE,

    FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- ============================================================
-- FEES
-- ============================================================

CREATE TABLE IF NOT EXISTS fees (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    student_id TEXT NOT NULL,
    academic_session_id TEXT NOT NULL,
    academic_term_id TEXT,
    title TEXT NOT NULL,
    description TEXT,
    amount REAL NOT NULL DEFAULT 0,
    due_date TEXT,
    status TEXT NOT NULL DEFAULT 'pending'
        CHECK (
            status IN (
                'pending',
                'partially_paid',
                'paid',
                'overdue',
                'waived',
                'cancelled'
            )
        ),
    created_by TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE,

    FOREIGN KEY (academic_session_id)
        REFERENCES academic_sessions(id)
        ON DELETE CASCADE,

    FOREIGN KEY (academic_term_id)
        REFERENCES academic_terms(id)
        ON DELETE SET NULL,

    FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- ============================================================
-- PAYMENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS payments (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    student_id TEXT NOT NULL,
    fee_id TEXT,
    amount REAL NOT NULL,
    currency TEXT NOT NULL DEFAULT 'NGN',
    payment_method TEXT NOT NULL DEFAULT 'cash'
        CHECK (
            payment_method IN (
                'cash',
                'bank_transfer',
                'card',
                'online',
                'other'
            )
        ),
    transaction_reference TEXT,
    payment_date TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending'
        CHECK (
            status IN (
                'pending',
                'successful',
                'failed',
                'refunded',
                'cancelled'
            )
        ),
    notes TEXT,
    received_by TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE,

    FOREIGN KEY (fee_id)
        REFERENCES fees(id)
        ON DELETE SET NULL,

    FOREIGN KEY (received_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- ============================================================
-- ANNOUNCEMENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS announcements (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    audience TEXT NOT NULL DEFAULT 'all'
        CHECK (
            audience IN (
                'all',
                'staff',
                'teachers',
                'students',
                'parents'
            )
        ),
    priority TEXT NOT NULL DEFAULT 'normal'
        CHECK (
            priority IN (
                'low',
                'normal',
                'high',
                'urgent'
            )
        ),
    status TEXT NOT NULL DEFAULT 'draft'
        CHECK (
            status IN (
                'draft',
                'published',
                'archived'
            )
        ),
    publish_at TEXT,
    expires_at TEXT,
    created_by TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- ============================================================
-- NOTIFICATIONS
-- ============================================================

CREATE TABLE IF NOT EXISTS notifications (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    type TEXT NOT NULL DEFAULT 'system'
        CHECK (
            type IN (
                'system',
                'announcement',
                'academic',
                'attendance',
                'result',
                'fee',
                'payment',
                'general'
            )
        ),
    is_read INTEGER NOT NULL DEFAULT 0
        CHECK (is_read IN (0, 1)),
    read_at TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

-- ============================================================
-- DOCUMENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS documents (
    id TEXT PRIMARY KEY,
    school_id TEXT NOT NULL,
    uploaded_by TEXT,
    name TEXT NOT NULL,
    original_name TEXT NOT NULL,
    file_key TEXT NOT NULL,
    file_url TEXT,
    mime_type TEXT,
    file_size INTEGER,
    category TEXT NOT NULL DEFAULT 'general'
        CHECK (
            category IN (
                'general',
                'student',
                'staff',
                'academic',
                'financial',
                'administrative',
                'announcement'
            )
        ),
    description TEXT,
    status TEXT NOT NULL DEFAULT 'active'
        CHECK (
            status IN (
                'active',
                'archived',
                'deleted'
            )
        ),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (uploaded_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- ============================================================
-- AUDIT LOGS
-- ============================================================

CREATE TABLE IF NOT EXISTS audit_logs (
    id TEXT PRIMARY KEY,
    school_id TEXT,
    user_id TEXT,
    action TEXT NOT NULL,
    entity_type TEXT,
    entity_id TEXT,
    description TEXT,
    ip_address TEXT,
    user_agent TEXT,
    metadata_json TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE SET NULL,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE SET NULL
);

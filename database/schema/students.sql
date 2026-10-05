-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- STUDENTS TABLE
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

    gender TEXT
        CHECK (
            gender IN (
                'male',
                'female',
                'other'
            )
        ),

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
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_students_school_id
ON students(school_id);

CREATE INDEX IF NOT EXISTS idx_students_user_id
ON students(user_id);

CREATE INDEX IF NOT EXISTS idx_students_admission_number
ON students(admission_number);

CREATE INDEX IF NOT EXISTS idx_students_status
ON students(status);

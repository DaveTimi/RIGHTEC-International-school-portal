-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- STAFF TABLE
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
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_staff_school_id
ON staff(school_id);

CREATE INDEX IF NOT EXISTS idx_staff_user_id
ON staff(user_id);

CREATE INDEX IF NOT EXISTS idx_staff_employee_number
ON staff(employee_number);

CREATE INDEX IF NOT EXISTS idx_staff_department
ON staff(department);

CREATE INDEX IF NOT EXISTS idx_staff_status
ON staff(status);

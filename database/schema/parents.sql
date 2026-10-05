-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- PARENTS / GUARDIANS TABLE
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
        CHECK (
            status IN (
                'active',
                'inactive'
            )
        ),

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
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_parents_school_id
ON parents(school_id);

CREATE INDEX IF NOT EXISTS idx_parents_user_id
ON parents(user_id);

CREATE INDEX IF NOT EXISTS idx_parents_email
ON parents(email);

CREATE INDEX IF NOT EXISTS idx_parents_phone
ON parents(phone);

CREATE INDEX IF NOT EXISTS idx_parents_status
ON parents(status);

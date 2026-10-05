-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- SUBJECTS TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS subjects (
    id TEXT PRIMARY KEY,

    school_id TEXT NOT NULL,

    name TEXT NOT NULL,

    code TEXT,

    description TEXT,

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

    UNIQUE (school_id, name),

    UNIQUE (school_id, code)
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_subjects_school_id
ON subjects(school_id);

CREATE INDEX IF NOT EXISTS idx_subjects_code
ON subjects(code);

CREATE INDEX IF NOT EXISTS idx_subjects_status
ON subjects(status);

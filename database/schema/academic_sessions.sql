-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- ACADEMIC SESSIONS TABLE
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
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_academic_sessions_school_id
ON academic_sessions(school_id);

CREATE INDEX IF NOT EXISTS idx_academic_sessions_status
ON academic_sessions(status);

CREATE INDEX IF NOT EXISTS idx_academic_sessions_start_date
ON academic_sessions(start_date);

CREATE INDEX IF NOT EXISTS idx_academic_sessions_end_date
ON academic_sessions(end_date);

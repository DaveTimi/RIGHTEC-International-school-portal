-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- ACADEMIC TERMS TABLE
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
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_academic_terms_school_id
ON academic_terms(school_id);

CREATE INDEX IF NOT EXISTS idx_academic_terms_session_id
ON academic_terms(academic_session_id);

CREATE INDEX IF NOT EXISTS idx_academic_terms_status
ON academic_terms(status);

CREATE INDEX IF NOT EXISTS idx_academic_terms_start_date
ON academic_terms(start_date);

CREATE INDEX IF NOT EXISTS idx_academic_terms_end_date
ON academic_terms(end_date);

-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- ASSIGNMENTS TABLE
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
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_assignments_school_id
ON assignments(school_id);

CREATE INDEX IF NOT EXISTS idx_assignments_session_id
ON assignments(academic_session_id);

CREATE INDEX IF NOT EXISTS idx_assignments_term_id
ON assignments(academic_term_id);

CREATE INDEX IF NOT EXISTS idx_assignments_class_id
ON assignments(class_id);

CREATE INDEX IF NOT EXISTS idx_assignments_subject_id
ON assignments(subject_id);

CREATE INDEX IF NOT EXISTS idx_assignments_due_date
ON assignments(due_date);

CREATE INDEX IF NOT EXISTS idx_assignments_status
ON assignments(status);

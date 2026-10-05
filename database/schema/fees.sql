-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- FEES TABLE
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
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_fees_school_id
ON fees(school_id);

CREATE INDEX IF NOT EXISTS idx_fees_student_id
ON fees(student_id);

CREATE INDEX IF NOT EXISTS idx_fees_session_id
ON fees(academic_session_id);

CREATE INDEX IF NOT EXISTS idx_fees_term_id
ON fees(academic_term_id);

CREATE INDEX IF NOT EXISTS idx_fees_status
ON fees(status);

CREATE INDEX IF NOT EXISTS idx_fees_due_date
ON fees(due_date);

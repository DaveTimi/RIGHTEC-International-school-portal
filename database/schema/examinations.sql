-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- EXAMINATIONS TABLE
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
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_examinations_school_id
ON examinations(school_id);

CREATE INDEX IF NOT EXISTS idx_examinations_session_id
ON examinations(academic_session_id);

CREATE INDEX IF NOT EXISTS idx_examinations_term_id
ON examinations(academic_term_id);

CREATE INDEX IF NOT EXISTS idx_examinations_class_id
ON examinations(class_id);

CREATE INDEX IF NOT EXISTS idx_examinations_subject_id
ON examinations(subject_id);

CREATE INDEX IF NOT EXISTS idx_examinations_date
ON examinations(examination_date);

CREATE INDEX IF NOT EXISTS idx_examinations_status
ON examinations(status);

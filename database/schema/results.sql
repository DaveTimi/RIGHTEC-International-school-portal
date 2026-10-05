-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- RESULTS TABLE
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

    UNIQUE (
        school_id,
        examination_id,
        student_id
    )
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_results_school_id
ON results(school_id);

CREATE INDEX IF NOT EXISTS idx_results_examination_id
ON results(examination_id);

CREATE INDEX IF NOT EXISTS idx_results_student_id
ON results(student_id);

CREATE INDEX IF NOT EXISTS idx_results_subject_id
ON results(subject_id);

CREATE INDEX IF NOT EXISTS idx_results_status
ON results(status);

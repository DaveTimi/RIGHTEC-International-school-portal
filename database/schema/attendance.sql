-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- ATTENDANCE TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS attendance (
    id TEXT PRIMARY KEY,

    school_id TEXT NOT NULL,

    student_id TEXT NOT NULL,

    class_id TEXT,

    academic_session_id TEXT,

    academic_term_id TEXT,

    attendance_date TEXT NOT NULL,

    status TEXT NOT NULL
        CHECK (
            status IN (
                'present',
                'absent',
                'late',
                'excused'
            )
        ),

    check_in_time TEXT,

    check_out_time TEXT,

    remarks TEXT,

    recorded_by TEXT,

    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE,

    FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON DELETE SET NULL,

    FOREIGN KEY (academic_session_id)
        REFERENCES academic_sessions(id)
        ON DELETE SET NULL,

    FOREIGN KEY (academic_term_id)
        REFERENCES academic_terms(id)
        ON DELETE SET NULL,

    FOREIGN KEY (recorded_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    UNIQUE (
        school_id,
        student_id,
        attendance_date
    )
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_attendance_school_id
ON attendance(school_id);

CREATE INDEX IF NOT EXISTS idx_attendance_student_id
ON attendance(student_id);

CREATE INDEX IF NOT EXISTS idx_attendance_class_id
ON attendance(class_id);

CREATE INDEX IF NOT EXISTS idx_attendance_date
ON attendance(attendance_date);

CREATE INDEX IF NOT EXISTS idx_attendance_status
ON attendance(status);

CREATE INDEX IF NOT EXISTS idx_attendance_term_id
ON attendance(academic_term_id);

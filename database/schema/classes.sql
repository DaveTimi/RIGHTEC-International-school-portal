-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- CLASSES TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS classes (
    id TEXT PRIMARY KEY,

    school_id TEXT NOT NULL,

    name TEXT NOT NULL,

    code TEXT,

    description TEXT,

    level TEXT,

    section TEXT,

    class_teacher_id TEXT,

    capacity INTEGER,

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

    FOREIGN KEY (class_teacher_id)
        REFERENCES staff(id)
        ON DELETE SET NULL,

    UNIQUE (school_id, name, section)
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_classes_school_id
ON classes(school_id);

CREATE INDEX IF NOT EXISTS idx_classes_class_teacher_id
ON classes(class_teacher_id);

CREATE INDEX IF NOT EXISTS idx_classes_level
ON classes(level);

CREATE INDEX IF NOT EXISTS idx_classes_status
ON classes(status);

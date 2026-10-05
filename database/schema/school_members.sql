-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- SCHOOL MEMBERSHIPS TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS school_members (
    id TEXT PRIMARY KEY,

    school_id TEXT NOT NULL,

    user_id TEXT NOT NULL,

    role TEXT NOT NULL
        CHECK (
            role IN (
                'school_owner',
                'school_admin',
                'principal',
                'vice_principal',
                'teacher',
                'bursar',
                'staff',
                'student',
                'parent'
            )
        ),

    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    UNIQUE (school_id, user_id)
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_school_members_school_id
ON school_members(school_id);

CREATE INDEX IF NOT EXISTS idx_school_members_user_id
ON school_members(user_id);

CREATE INDEX IF NOT EXISTS idx_school_members_role
ON school_members(role);

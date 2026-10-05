-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- ANNOUNCEMENTS TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS announcements (
    id TEXT PRIMARY KEY,

    school_id TEXT NOT NULL,

    title TEXT NOT NULL,

    content TEXT NOT NULL,

    audience TEXT NOT NULL DEFAULT 'all'
        CHECK (
            audience IN (
                'all',
                'staff',
                'teachers',
                'students',
                'parents'
            )
        ),

    priority TEXT NOT NULL DEFAULT 'normal'
        CHECK (
            priority IN (
                'low',
                'normal',
                'high',
                'urgent'
            )
        ),

    status TEXT NOT NULL DEFAULT 'draft'
        CHECK (
            status IN (
                'draft',
                'published',
                'archived'
            )
        ),

    publish_at TEXT,

    expires_at TEXT,

    created_by TEXT,

    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_announcements_school_id
ON announcements(school_id);

CREATE INDEX IF NOT EXISTS idx_announcements_audience
ON announcements(audience);

CREATE INDEX IF NOT EXISTS idx_announcements_status
ON announcements(status);

CREATE INDEX IF NOT EXISTS idx_announcements_publish_at
ON announcements(publish_at);

CREATE INDEX IF NOT EXISTS idx_announcements_created_by
ON announcements(created_by);

-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- NOTIFICATIONS TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS notifications (
    id TEXT PRIMARY KEY,

    school_id TEXT NOT NULL,

    user_id TEXT NOT NULL,

    title TEXT NOT NULL,

    message TEXT NOT NULL,

    type TEXT NOT NULL DEFAULT 'system'
        CHECK (
            type IN (
                'system',
                'announcement',
                'academic',
                'attendance',
                'result',
                'fee',
                'payment',
                'general'
            )
        ),

    is_read INTEGER NOT NULL DEFAULT 0
        CHECK (is_read IN (0, 1)),

    read_at TEXT,

    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_notifications_school_id
ON notifications(school_id);

CREATE INDEX IF NOT EXISTS idx_notifications_user_id
ON notifications(user_id);

CREATE INDEX IF NOT EXISTS idx_notifications_type
ON notifications(type);

CREATE INDEX IF NOT EXISTS idx_notifications_is_read
ON notifications(is_read);

CREATE INDEX IF NOT EXISTS idx_notifications_created_at
ON notifications(created_at);

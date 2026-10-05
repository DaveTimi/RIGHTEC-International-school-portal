-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- USERS TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS users (
    id TEXT PRIMARY KEY,

    email TEXT NOT NULL UNIQUE,

    first_name TEXT NOT NULL,

    last_name TEXT NOT NULL,

    phone TEXT,

    status TEXT NOT NULL DEFAULT 'pending'
        CHECK (
            status IN (
                'active',
                'suspended',
                'pending',
                'inactive'
            )
        ),

    avatar_url TEXT,

    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_users_email
ON users(email);

CREATE INDEX IF NOT EXISTS idx_users_status
ON users(status);

-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- SCHOOLS / TENANTS TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS schools (
    id TEXT PRIMARY KEY,

    name TEXT NOT NULL,

    slug TEXT NOT NULL UNIQUE,

    status TEXT NOT NULL DEFAULT 'active'
        CHECK (status IN ('active', 'suspended', 'inactive')),

    logo_url TEXT,

    email TEXT,

    phone TEXT,

    address TEXT,

    city TEXT,

    state TEXT,

    country TEXT DEFAULT 'Nigeria',

    timezone TEXT DEFAULT 'Africa/Lagos',

    settings_json TEXT,

    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_schools_slug
ON schools(slug);

CREATE INDEX IF NOT EXISTS idx_schools_status
ON schools(status);

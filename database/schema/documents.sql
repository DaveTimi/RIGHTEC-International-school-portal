-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- DOCUMENTS TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS documents (
    id TEXT PRIMARY KEY,

    school_id TEXT NOT NULL,

    uploaded_by TEXT,

    name TEXT NOT NULL,

    original_name TEXT NOT NULL,

    file_key TEXT NOT NULL,

    file_url TEXT,

    mime_type TEXT,

    file_size INTEGER,

    category TEXT NOT NULL DEFAULT 'general'
        CHECK (
            category IN (
                'general',
                'student',
                'staff',
                'academic',
                'financial',
                'administrative',
                'announcement'
            )
        ),

    description TEXT,

    status TEXT NOT NULL DEFAULT 'active'
        CHECK (
            status IN (
                'active',
                'archived',
                'deleted'
            )
        ),

    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (uploaded_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_documents_school_id
ON documents(school_id);

CREATE INDEX IF NOT EXISTS idx_documents_uploaded_by
ON documents(uploaded_by);

CREATE INDEX IF NOT EXISTS idx_documents_category
ON documents(category);

CREATE INDEX IF NOT EXISTS idx_documents_status
ON documents(status);

CREATE INDEX IF NOT EXISTS idx_documents_file_key
ON documents(file_key);

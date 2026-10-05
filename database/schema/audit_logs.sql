-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- AUDIT LOGS TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS audit_logs (
    id TEXT PRIMARY KEY,

    school_id TEXT,

    user_id TEXT,

    action TEXT NOT NULL,

    entity_type TEXT,

    entity_id TEXT,

    description TEXT,

    ip_address TEXT,

    user_agent TEXT,

    metadata_json TEXT,

    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE SET NULL,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_audit_logs_school_id
ON audit_logs(school_id);

CREATE INDEX IF NOT EXISTS idx_audit_logs_user_id
ON audit_logs(user_id);

CREATE INDEX IF NOT EXISTS idx_audit_logs_action
ON audit_logs(action);

CREATE INDEX IF NOT EXISTS idx_audit_logs_entity_type
ON audit_logs(entity_type);

CREATE INDEX IF NOT EXISTS idx_audit_logs_entity_id
ON audit_logs(entity_id);

CREATE INDEX IF NOT EXISTS idx_audit_logs_created_at
ON audit_logs(created_at);

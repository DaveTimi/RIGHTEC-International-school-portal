-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- PAYMENTS TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS payments (
    id TEXT PRIMARY KEY,

    school_id TEXT NOT NULL,

    student_id TEXT NOT NULL,

    fee_id TEXT,

    amount REAL NOT NULL,

    currency TEXT NOT NULL DEFAULT 'NGN',

    payment_method TEXT NOT NULL DEFAULT 'cash'
        CHECK (
            payment_method IN (
                'cash',
                'bank_transfer',
                'card',
                'online',
                'other'
            )
        ),

    transaction_reference TEXT,

    payment_date TEXT NOT NULL,

    status TEXT NOT NULL DEFAULT 'pending'
        CHECK (
            status IN (
                'pending',
                'successful',
                'failed',
                'refunded',
                'cancelled'
            )
        ),

    notes TEXT,

    received_by TEXT,

    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (school_id)
        REFERENCES schools(id)
        ON DELETE CASCADE,

    FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE,

    FOREIGN KEY (fee_id)
        REFERENCES fees(id)
        ON DELETE SET NULL,

    FOREIGN KEY (received_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_payments_school_id
ON payments(school_id);

CREATE INDEX IF NOT EXISTS idx_payments_student_id
ON payments(student_id);

CREATE INDEX IF NOT EXISTS idx_payments_fee_id
ON payments(fee_id);

CREATE INDEX IF NOT EXISTS idx_payments_reference
ON payments(transaction_reference);

CREATE INDEX IF NOT EXISTS idx_payments_payment_date
ON payments(payment_date);

CREATE INDEX IF NOT EXISTS idx_payments_status
ON payments(status);

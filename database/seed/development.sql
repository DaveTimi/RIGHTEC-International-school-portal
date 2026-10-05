-- ============================================================
-- LEVITY ETHICS SYSTEMS
-- DEVELOPMENT SEED DATA
-- ============================================================
-- IMPORTANT:
-- This file contains fictional development data only.
-- Never use real student, parent, staff, or financial data here.
-- ============================================================

PRAGMA foreign_keys = ON;

-- ============================================================
-- SAMPLE SCHOOL
-- ============================================================

INSERT OR IGNORE INTO schools (
    id,
    name,
    slug,
    status,
    email,
    phone,
    city,
    state,
    country,
    timezone
) VALUES (
    'school_demo_001',
    'LES Demo International School',
    'les-demo-school',
    'active',
    'demo@les.example',
    '+2340000000000',
    'Lagos',
    'Lagos',
    'Nigeria',
    'Africa/Lagos'
);

-- ============================================================
-- SAMPLE ADMIN USER
-- ============================================================

INSERT OR IGNORE INTO users (
    id,
    email,
    first_name,
    last_name,
    phone,
    status
) VALUES (
    'user_demo_admin_001',
    'admin@les.example',
    'Demo',
    'Administrator',
    '+2340000000000',
    'active'
);

-- ============================================================
-- SCHOOL MEMBERSHIP
-- ============================================================

INSERT OR IGNORE INTO school_members (
    id,
    school_id,
    user_id,
    role
) VALUES (
    'membership_demo_001',
    'school_demo_001',
    'user_demo_admin_001',
    'school_admin'
);

-- ============================================================
-- SAMPLE STAFF
-- ============================================================

INSERT OR IGNORE INTO staff (
    id,
    school_id,
    user_id,
    employee_number,
    first_name,
    last_name,
    position,
    employment_type,
    status,
    date_joined
) VALUES (
    'staff_demo_001',
    'school_demo_001',
    NULL,
    'EMP-DEMO-001',
    'Demo',
    'Teacher',
    'Teacher',
    'full_time',
    'active',
    '2026-09-01'
);

-- ============================================================
-- SAMPLE CLASS
-- ============================================================

INSERT OR IGNORE INTO classes (
    id,
    school_id,
    name,
    code,
    level,
    section,
    class_teacher_id,
    capacity,
    status
) VALUES (
    'class_demo_001',
    'school_demo_001',
    'JSS 1',
    'JSS1-A',
    'JSS 1',
    'A',
    'staff_demo_001',
    40,
    'active'
);

-- ============================================================
-- SAMPLE SUBJECTS
-- ============================================================

INSERT OR IGNORE INTO subjects (
    id,
    school_id,
    name,
    code,
    status
) VALUES
(
    'subject_demo_001',
    'school_demo_001',
    'Mathematics',
    'MATH',
    'active'
),
(
    'subject_demo_002',
    'school_demo_001',
    'English Language',
    'ENG',
    'active'
),
(
    'subject_demo_003',
    'school_demo_001',
    'Basic Science',
    'BSC',
    'active'
);

-- ============================================================
-- SAMPLE ACADEMIC SESSION
-- ============================================================

INSERT OR IGNORE INTO academic_sessions (
    id,
    school_id,
    name,
    start_date,
    end_date,
    status
) VALUES (
    'session_demo_001',
    'school_demo_001',
    '2026/2027 Academic Session',
    '2026-09-01',
    '2027-07-31',
    'active'
);

-- ============================================================
-- SAMPLE ACADEMIC TERMS
-- ============================================================

INSERT OR IGNORE INTO academic_terms (
    id,
    school_id,
    academic_session_id,
    name,
    start_date,
    end_date,
    status
) VALUES (
    'term_demo_001',
    'school_demo_001',
    'session_demo_001',
    'First Term',
    '2026-09-01',
    '2026-12-18',
    'active'
);

-- ============================================================
-- SAMPLE STUDENT
-- ============================================================

INSERT OR IGNORE INTO students (
    id,
    school_id,
    user_id,
    admission_number,
    first_name,
    last_name,
    gender,
    status,
    admission_date
) VALUES (
    'student_demo_001',
    'school_demo_001',
    NULL,
    'LES-DEMO-001',
    'Demo',
    'Student',
    'male',
    'active',
    '2026-09-01'
);

-- ============================================================
-- SAMPLE ANNOUNCEMENT
-- ============================================================

INSERT OR IGNORE INTO announcements (
    id,
    school_id,
    title,
    content,
    audience,
    priority,
    status,
    created_by
) VALUES (
    'announcement_demo_001',
    'school_demo_001',
    'Welcome to LES Demo School',
    'This is a fictional development announcement for testing the Levity Ethics Systems platform.',
    'all',
    'normal',
    'published',
    'user_demo_admin_001'
);

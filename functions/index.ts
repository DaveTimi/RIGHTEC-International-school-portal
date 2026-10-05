export interface Env {
  DB: D1Database;
  APP_NAME: string;
  APP_ENV: string;
}

const html = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Dave Timi Edtech Systems</title>

  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    :root {
      --primary: #2563eb;
      --primary-dark: #1d4ed8;
      --bg: #f5f7fb;
      --card: #ffffff;
      --text: #172033;
      --muted: #718096;
      --border: #e7ebf3;
      --success: #16a34a;
      --warning: #f59e0b;
      --danger: #dc2626;
      --sidebar: #ffffff;
    }

    body {
      font-family:
        Inter,
        ui-sans-serif,
        system-ui,
        -apple-system,
        BlinkMacSystemFont,
        "Segoe UI",
        sans-serif;
      background: var(--bg);
      color: var(--text);
    }

    button {
      font: inherit;
      cursor: pointer;
    }

    .app {
      display: flex;
      min-height: 100vh;
    }

    /* SIDEBAR */

    .sidebar {
      width: 255px;
      background: var(--sidebar);
      border-right: 1px solid var(--border);
      padding: 22px 16px;
      position: fixed;
      top: 0;
      left: 0;
      bottom: 0;
      overflow-y: auto;
      z-index: 20;
    }

    .brand {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 4px 10px 25px;
    }

    .brand-logo {
      width: 42px;
      height: 42px;
      border-radius: 13px;
      background: linear-gradient(135deg, #2563eb, #60a5fa);
      color: white;
      display: grid;
      place-items: center;
      font-weight: 800;
      box-shadow: 0 8px 20px rgba(37, 99, 235, .2);
    }

    .brand-title {
      font-size: 15px;
      font-weight: 800;
    }

    .brand-subtitle {
      color: var(--muted);
      font-size: 11px;
      margin-top: 2px;
    }

    .nav-title {
      color: #9aa4b2;
      font-size: 10px;
      text-transform: uppercase;
      letter-spacing: 1px;
      font-weight: 700;
      padding: 12px 12px 8px;
    }

    .nav {
      display: flex;
      flex-direction: column;
      gap: 4px;
    }

    .nav button {
      border: 0;
      background: transparent;
      color: #596579;
      text-align: left;
      padding: 11px 12px;
      border-radius: 10px;
      display: flex;
      align-items: center;
      gap: 12px;
      transition: .2s;
    }

    .nav button:hover,
    .nav button.active {
      background: #edf4ff;
      color: var(--primary);
    }

    .nav-icon {
      width: 20px;
      text-align: center;
      font-size: 16px;
    }

    /* MAIN */

    .main {
      margin-left: 255px;
      width: calc(100% - 255px);
      min-height: 100vh;
    }

    .topbar {
      height: 76px;
      background: rgba(255,255,255,.9);
      backdrop-filter: blur(12px);
      border-bottom: 1px solid var(--border);
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 30px;
      position: sticky;
      top: 0;
      z-index: 10;
    }

    .mobile-menu {
      display: none;
      border: 0;
      background: #edf4ff;
      color: var(--primary);
      width: 40px;
      height: 40px;
      border-radius: 10px;
    }

    .search {
      width: min(400px, 45vw);
      position: relative;
    }

    .search input {
      width: 100%;
      border: 1px solid var(--border);
      border-radius: 12px;
      padding: 11px 15px 11px 40px;
      outline: none;
      background: #fafbfe;
    }

    .search span {
      position: absolute;
      left: 14px;
      top: 10px;
      color: #98a2b3;
    }

    .top-actions {
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .icon-btn {
      width: 40px;
      height: 40px;
      border: 1px solid var(--border);
      border-radius: 11px;
      background: white;
    }

    .profile {
      display: flex;
      align-items: center;
      gap: 10px;
      padding-left: 8px;
    }

    .avatar {
      width: 38px;
      height: 38px;
      border-radius: 50%;
      background: #dbeafe;
      color: #1d4ed8;
      display: grid;
      place-items: center;
      font-weight: 800;
    }

    .profile-name {
      font-size: 13px;
      font-weight: 700;
    }

    .profile-role {
      font-size: 11px;
      color: var(--muted);
    }

    /* CONTENT */

    .content {
      padding: 30px;
      max-width: 1600px;
      margin: auto;
    }

    .welcome {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 25px;
    }

    .welcome h1 {
      font-size: 27px;
      letter-spacing: -.5px;
    }

    .welcome p {
      color: var(--muted);
      margin-top: 5px;
      font-size: 14px;
    }

    .school-pill {
      display: flex;
      align-items: center;
      gap: 10px;
      background: white;
      border: 1px solid var(--border);
      padding: 9px 13px;
      border-radius: 12px;
      font-size: 13px;
      font-weight: 700;
    }

    .school-dot {
      width: 9px;
      height: 9px;
      border-radius: 50%;
      background: var(--success);
    }

    /* HERO */

    .hero {
      border-radius: 20px;
      padding: 27px;
      background:
        radial-gradient(circle at 90% 20%, rgba(96,165,250,.35), transparent 30%),
        linear-gradient(120deg, #1555c0, #2563eb 55%, #3b82f6);
      color: white;
      margin-bottom: 25px;
      position: relative;
      overflow: hidden;
    }

    .hero:after {
      content: "";
      position: absolute;
      width: 250px;
      height: 250px;
      border-radius: 50%;
      border: 30px solid rgba(255,255,255,.08);
      right: -70px;
      bottom: -110px;
    }

    .hero h2 {
      font-size: 24px;
      margin-bottom: 7px;
      position: relative;
      z-index: 1;
    }

    .hero p {
      opacity: .88;
      max-width: 600px;
      line-height: 1.6;
      font-size: 14px;
      position: relative;
      z-index: 1;
    }

    .hero-buttons {
      display: flex;
      gap: 10px;
      margin-top: 18px;
      position: relative;
      z-index: 1;
    }

    .hero button {
      border: 0;
      padding: 10px 15px;
      border-radius: 10px;
      font-weight: 700;
    }

    .hero-primary {
      background: white;
      color: var(--primary);
    }

    .hero-secondary {
      background: rgba(255,255,255,.15);
      color: white;
      border: 1px solid rgba(255,255,255,.25) !important;
    }

    /* STAT CARDS */

    .stats {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 17px;
      margin-bottom: 25px;
    }

    .stat {
      background: white;
      border: 1px solid var(--border);
      border-radius: 16px;
      padding: 20px;
      box-shadow: 0 4px 15px rgba(15,23,42,.025);
    }

    .stat-top {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .stat-icon {
      width: 42px;
      height: 42px;
      border-radius: 12px;
      display: grid;
      place-items: center;
      background: #edf4ff;
      color: var(--primary);
      font-size: 18px;
    }

    .stat h3 {
      font-size: 26px;
      margin-top: 14px;
    }

    .stat p {
      color: var(--muted);
      font-size: 12px;
      margin-top: 3px;
    }

    .trend {
      font-size: 11px;
      color: var(--success);
      font-weight: 700;
    }

    /* GRID */

    .grid {
      display: grid;
      grid-template-columns: 1.45fr 1fr;
      gap: 20px;
    }

    .card {
      background: white;
      border: 1px solid var(--border);
      border-radius: 17px;
      padding: 20px;
    }

    .card-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 18px;
    }

    .card-header h3 {
      font-size: 16px;
    }

    .view {
      color: var(--primary);
      border: 0;
      background: transparent;
      font-size: 12px;
      font-weight: 700;
    }

    .activity {
      display: flex;
      gap: 13px;
      padding: 13px 0;
      border-bottom: 1px solid #f0f2f6;
    }

    .activity:last-child {
      border-bottom: 0;
    }

    .activity-icon {
      width: 36px;
      height: 36px;
      border-radius: 10px;
      background: #edf4ff;
      display: grid;
      place-items: center;
    }

    .activity strong {
      font-size: 13px;
    }

    .activity p {
      color: var(--muted);
      font-size: 11px;
      margin-top: 3px;
    }

    .notice {
      background: #f8fafc;
      border-radius: 12px;
      padding: 13px;
      margin-bottom: 10px;
      border: 1px solid #eef1f5;
    }

    .notice:last-child {
      margin-bottom: 0;
    }

    .notice strong {
      font-size: 13px;
    }

    .notice p {
      color: var(--muted);
      font-size: 11px;
      margin-top: 5px;
      line-height: 1.5;
    }

    /* PAGE */

    .page-title {
      margin-bottom: 20px;
    }

    .page-title h1 {
      font-size: 25px;
    }

    .page-title p {
      color: var(--muted);
      font-size: 13px;
      margin-top: 4px;
    }

    .table-card {
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      min-width: 700px;
    }

    th,
    td {
      text-align: left;
      padding: 14px 12px;
      border-bottom: 1px solid #eef1f5;
      font-size: 13px;
    }

    th {
      color: #7b8798;
      font-size: 11px;
      text-transform: uppercase;
      letter-spacing: .5px;
    }

    .badge {
      display: inline-flex;
      padding: 5px 9px;
      border-radius: 20px;
      font-size: 10px;
      font-weight: 700;
    }

    .badge-green {
      background: #eaf8ef;
      color: #15803d;
    }

    .badge-yellow {
      background: #fff7df;
      color: #a16207;
    }

    .badge-blue {
      background: #edf4ff;
      color: #1d4ed8;
    }

    .empty {
      text-align: center;
      padding: 50px 20px;
      color: var(--muted);
    }

    .hidden {
      display: none !important;
    }

    /* RESPONSIVE */

    @media(max-width: 1100px) {
      .stats {
        grid-template-columns: repeat(2, 1fr);
      }

      .grid {
        grid-template-columns: 1fr;
      }
    }

    @media(max-width: 760px) {
      .sidebar {
        transform: translateX(-100%);
        transition: .25s;
      }

      .sidebar.open {
        transform: translateX(0);
      }

      .main {
        margin-left: 0;
        width: 100%;
      }

      .mobile-menu {
        display: block;
      }

      .topbar {
        padding: 0 15px;
        gap: 10px;
      }

      .search {
        display: none;
      }

      .profile div:not(.avatar) {
        display: none;
      }

      .content {
        padding: 18px 15px;
      }

      .welcome {
        align-items: flex-start;
        gap: 15px;
        flex-direction: column;
      }

      .stats {
        grid-template-columns: 1fr 1fr;
        gap: 10px;
      }

      .stat {
        padding: 15px;
      }

      .stat h3 {
        font-size: 22px;
      }
    }

    @media(max-width: 430px) {
      .stats {
        grid-template-columns: 1fr;
      }

      .hero {
        padding: 21px;
      }
    }
  </style>
</head>

<body>
<div class="app">

  <aside class="sidebar" id="sidebar">

    <div class="brand">
      <div class="brand-logo">DT</div>
      <div>
        <div class="brand-title">Dave Timi</div>
        <div class="brand-subtitle">Edtech Systems</div>
      </div>
    </div>

    <div class="nav-title">Workspace</div>

    <nav class="nav">

      <button class="active" onclick="showPage('dashboard', this)">
        <span class="nav-icon">⌂</span>
        Dashboard
      </button>

      <button onclick="showPage('students', this)">
        <span class="nav-icon">👨‍🎓</span>
        Students
      </button>

      <button onclick="showPage('staff', this)">
        <span class="nav-icon">👩‍🏫</span>
        Staff
      </button>

      <button onclick="showPage('classes', this)">
        <span class="nav-icon">📚</span>
        Classes
      </button>

      <button onclick="showPage('academics', this)">
        <span class="nav-icon">🎓</span>
        Academics
      </button>

      <button onclick="showPage('attendance', this)">
        <span class="nav-icon">✓</span>
        Attendance
      </button>

      <div class="nav-title">Management</div>

      <button onclick="showPage('exams', this)">
        <span class="nav-icon">📝</span>
        Exams & Results
      </button>

      <button onclick="showPage('fees', this)">
        <span class="nav-icon">₦</span>
        Fees & Payments
      </button>

      <button onclick="showPage('announcements', this)">
        <span class="nav-icon">📢</span>
        Announcements
      </button>

      <button onclick="showPage('documents', this)">
        <span class="nav-icon">📄</span>
        Documents
      </button>

      <div class="nav-title">System</div>

      <button onclick="showPage('settings', this)">
        <span class="nav-icon">⚙</span>
        Settings
      </button>

    </nav>

  </aside>

  <main class="main">

    <header class="topbar">

      <button class="mobile-menu" onclick="toggleSidebar()">☰</button>

      <div class="search">
        <span>⌕</span>
        <input placeholder="Search students, staff, classes..." />
      </div>

      <div class="top-actions">

        <button class="icon-btn">🔔</button>

        <div class="profile">
          <div class="avatar">DT</div>
          <div>
            <div class="profile-name">Dave Timi</div>
            <div class="profile-role">School Administrator</div>
          </div>
        </div>

      </div>

    </header>

    <section class="content">

      <!-- DASHBOARD -->

      <div id="dashboard">

        <div class="welcome">
          <div>
            <h1>Good morning, Dave 👋</h1>
            <p>Here's what's happening across your school today.</p>
          </div>

          <div class="school-pill">
            <span class="school-dot"></span>
            Rightec International School
          </div>
        </div>

        <div class="hero">

          <h2>Welcome to Dave Timi Edtech Systems</h2>

          <p>
            A modern school management platform designed to make
            administration, teaching, learning and communication simpler.
          </p>

          <div class="hero-buttons">
            <button class="hero-primary" onclick="showPage('students')">
              Manage Students
            </button>

            <button class="hero-secondary" onclick="showPage('academics')">
              Explore Academics
            </button>
          </div>

        </div>

        <div class="stats">

          <div class="stat">
            <div class="stat-top">
              <div class="stat-icon">👨‍🎓</div>
              <span class="trend">+0%</span>
            </div>
            <h3 id="studentCount">0</h3>
            <p>Total Students</p>
          </div>

          <div class="stat">
            <div class="stat-top">
              <div class="stat-icon">👩‍🏫</div>
              <span class="trend">Active</span>
            </div>
            <h3 id="staffCount">0</h3>
            <p>Staff Members</p>
          </div>

          <div class="stat">
            <div class="stat-top">
              <div class="stat-icon">📚</div>
              <span class="trend">Active</span>
            </div>
            <h3 id="classCount">0</h3>
            <p>Classes</p>
          </div>

          <div class="stat">
            <div class="stat-top">
              <div class="stat-icon">📖</div>
              <span class="trend">Active</span>
            </div>
            <h3 id="subjectCount">0</h3>
            <p>Subjects</p>
          </div>

        </div>

        <div class="grid">

          <div class="card">

            <div class="card-header">
              <h3>Recent Activity</h3>
              <button class="view">View all</button>
            </div>

            <div class="activity">
              <div class="activity-icon">🏫</div>
              <div>
                <strong>School connected successfully</strong>
                <p>Rightec International School is connected to D1.</p>
              </div>
            </div>

            <div class="activity">
              <div class="activity-icon">🗄️</div>
              <div>
                <strong>Database initialized</strong>
                <p>School management tables are ready.</p>
              </div>
            </div>

            <div class="activity">
              <div class="activity-icon">🚀</div>
              <div>
                <strong>Platform deployment active</strong>
                <p>Dave Timi Edtech Systems is running on Cloudflare.</p>
              </div>
            </div>

          </div>

          <div class="card">

            <div class="card-header">
              <h3>School Updates</h3>
              <button class="view">Manage</button>
            </div>

            <div class="notice">
              <strong>Academic management</strong>
              <p>Manage sessions, terms, subjects and classes from one place.</p>
            </div>

            <div class="notice">
              <strong>Student records</strong>
              <p>Student profiles, admission numbers and attendance are ready.</p>
            </div>

            <div class="notice">
              <strong>Results & examinations</strong>
              <p>Examinations and academic results can be managed centrally.</p>
            </div>

          </div>

        </div>

      </div>

      <!-- GENERIC PAGES -->

      <div id="students" class="hidden">
        <div class="page-title">
          <h1>Students</h1>
          <p>Manage students enrolled in your school.</p>
        </div>

        <div class="card table-card">
          <div class="card-header">
            <h3>Student Directory</h3>
            <button class="view">+ Add Student</button>
          </div>

          <div id="studentsTable">
            Loading students...
          </div>
        </div>
      </div>

      <div id="staff" class="hidden">
        <div class="page-title">
          <h1>Staff & Teachers</h1>
          <p>Manage teaching and administrative staff.</p>
        </div>

        <div class="card">
          <div class="empty">
            Staff management interface is ready for connection.
          </div>
        </div>
      </div>

      <div id="classes" class="hidden">
        <div class="page-title">
          <h1>Classes</h1>
          <p>Manage school classes and class teachers.</p>
        </div>

        <div class="card">
          <div class="empty">
            Class management interface is ready.
          </div>
        </div>
      </div>

      <div id="academics" class="hidden">
        <div class="page-title">
          <h1>Academic Management</h1>
          <p>Sessions, terms, subjects and academic structure.</p>
        </div>

        <div class="stats">
          <div class="stat">
            <div class="stat-icon">📅</div>
            <h3>Sessions</h3>
            <p>Academic sessions</p>
          </div>

          <div class="stat">
            <div class="stat-icon">📖</div>
            <h3>Subjects</h3>
            <p>School subjects</p>
          </div>

          <div class="stat">
            <div class="stat-icon">🏫</div>
            <h3>Classes</h3>
            <p>Class structure</p>
          </div>
        </div>
      </div>

      <div id="attendance" class="hidden">
        <div class="page-title">
          <h1>Attendance</h1>
          <p>Monitor student attendance and daily records.</p>
        </div>

        <div class="card">
          <div class="empty">
            Attendance management is ready.
          </div>
        </div>
      </div>

      <div id="exams" class="hidden">
        <div class="page-title">
          <h1>Exams & Results</h1>
          <p>Create examinations and manage student results.</p>
        </div>

        <div class="card">
          <div class="empty">
            Examination and result management is ready.
          </div>
        </div>
      </div>

      <div id="fees" class="hidden">
        <div class="page-title">
          <h1>Fees & Payments</h1>
          <p>Manage school fees and payment records.</p>
        </div>

        <div class="card">
          <div class="empty">
            Financial management interface is ready.
          </div>
        </div>
      </div>

      <div id="announcements" class="hidden">
        <div class="page-title">
          <h1>Announcements</h1>
          <p>Communicate important information to your school community.</p>
        </div>

        <div class="card">
          <div class="empty">
            Announcement management is ready.
          </div>
        </div>
      </div>

      <div id="documents" class="hidden">
        <div class="page-title">
          <h1>Documents</h1>
          <p>Organize important school documents.</p>
        </div>

        <div class="card">
          <div class="empty">
            Document management is ready.
          </div>
        </div>
      </div>

      <div id="settings" class="hidden">
        <div class="page-title">
          <h1>Settings</h1>
          <p>Configure your school and platform preferences.</p>
        </div>

        <div class="card">
          <h3>Dave Timi Edtech Systems</h3>
          <p style="color:#718096;margin-top:8px;">
            School management platform.
          </p>
        </div>
      </div>

    </section>

  </main>

</div>

<script>

  const pages = [
    "dashboard",
    "students",
    "staff",
    "classes",
    "academics",
    "attendance",
    "exams",
    "fees",
    "announcements",
    "documents",
    "settings"
  ];

  function showPage(page, button) {

    pages.forEach(id => {
      const element = document.getElementById(id);

      if (element) {
        element.classList.add("hidden");
      }
    });

    const selected = document.getElementById(page);

    if (selected) {
      selected.classList.remove("hidden");
    }

    document.querySelectorAll(".nav button")
      .forEach(btn => btn.classList.remove("active"));

    if (button) {
      button.classList.add("active");
    }

    if (page === "students") {
      loadStudents();
    }

    document.getElementById("sidebar")
      .classList.remove("open");
  }

  function toggleSidebar() {
    document.getElementById("sidebar")
      .classList.toggle("open");
  }

  async function loadDashboard() {

    try {

      const response = await fetch("/api/dashboard");

      const data = await response.json();

      if (!data.success) return;

      document.getElementById("studentCount").textContent =
        data.counts.students;

      document.getElementById("staffCount").textContent =
        data.counts.staff;

      document.getElementById("classCount").textContent =
        data.counts.classes;

      document.getElementById("subjectCount").textContent =
        data.counts.subjects;

    } catch (error) {

      console.error(error);

    }

  }

  async function loadStudents() {

    const container =
      document.getElementById("studentsTable");

    container.innerHTML = "Loading students...";

    try {

      const response =
        await fetch("/api/students");

      const data =
        await response.json();

      if (!data.success || data.students.length === 0) {

        container.innerHTML = `
          <div class="empty">
            <h3>No students yet</h3>
            <p>Student records will appear here when added.</p>
          </div>
        `;

        return;
      }

      container.innerHTML = `
        <table>

          <thead>
            <tr>
              <th>Admission No.</th>
              <th>Name</th>
              <th>Gender</th>
              <th>Status</th>
            </tr>
          </thead>

          <tbody>

            ${data.students.map(student => `

              <tr>

                <td>
                  ${escapeHtml(student.admission_number)}
                </td>

                <td>
                  <strong>
                    ${escapeHtml(student.first_name)}
                    ${escapeHtml(student.last_name)}
                  </strong>
                </td>

                <td>
                  ${escapeHtml(student.gender || "-")}
                </td>

                <td>
                  <span class="badge badge-green">
                    ${escapeHtml(student.status)}
                  </span>
                </td>

              </tr>

            `).join("")}

          </tbody>

        </table>
      `;

    } catch (error) {

      container.innerHTML =
        '<div class="empty">Unable to load students.</div>';

    }

  }

  function escapeHtml(value) {

    return String(value ?? "")
      .replaceAll("&", "&amp;")
      .replaceAll("<", "&lt;")
      .replaceAll(">", "&gt;")
      .replaceAll('"', "&quot;")
      .replaceAll("'", "&#039;");

  }

  loadDashboard();

</script>

</body>
</html>`;

export default {

  async fetch(
    request: Request,
    env: Env
  ): Promise<Response> {

    const url = new URL(request.url);

    try {

      /*
       * DASHBOARD API
       */

      if (url.pathname === "/api/dashboard") {

        const [
          students,
          staff,
          classes,
          subjects
        ] = await Promise.all([

          env.DB
            .prepare(
              "SELECT COUNT(*) AS count FROM students WHERE status = 'active'"
            )
            .first<{ count: number }>(),

          env.DB
            .prepare(
              "SELECT COUNT(*) AS count FROM staff WHERE status = 'active'"
            )
            .first<{ count: number }>(),

          env.DB
            .prepare(
              "SELECT COUNT(*) AS count FROM classes WHERE status = 'active'"
            )
            .first<{ count: number }>(),

          env.DB
            .prepare(
              "SELECT COUNT(*) AS count FROM subjects WHERE status = 'active'"
            )
            .first<{ count: number }>()
        ]);

        return Response.json({

          success: true,

          counts: {

            students: students?.count ?? 0,

            staff: staff?.count ?? 0,

            classes: classes?.count ?? 0,

            subjects: subjects?.count ?? 0

          }

        });

      }


      /*
       * STUDENTS API
       */

      if (url.pathname === "/api/students") {

        const result = await env.DB
          .prepare(`
            SELECT
              id,
              admission_number,
              first_name,
              last_name,
              middle_name,
              gender,
              status
            FROM students
            ORDER BY created_at DESC
          `)
          .all();

        return Response.json({

          success: true,

          students: result.results

        });

      }


      /*
       * SCHOOL API
       */

      if (url.pathname === "/api/school") {

        const school = await env.DB
          .prepare(`
            SELECT
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
            FROM schools
            ORDER BY created_at ASC
            LIMIT 1
          `)
          .first();

        return Response.json({

          success: true,

          school

        });

      }


      /*
       * HEALTH / DATABASE TEST
       */

      if (url.pathname === "/api/health") {

        const result = await env.DB
          .prepare(`
            SELECT name
            FROM sqlite_master
            WHERE type = 'table'
            ORDER BY name
          `)
          .all();

        return Response.json({

          success: true,

          app: env.APP_NAME,

          environment: env.APP_ENV,

          database: "connected",

          tables: result.results

        });

      }


      /*
       * FRONTEND
       */

      return new Response(html, {

        headers: {

          "content-type":
            "text/html;charset=UTF-8",

          "cache-control":
            "no-cache"

        }

      });

    } catch (error) {

      return Response.json(

        {

          success: false,

          error:
            error instanceof Error
              ? error.message
              : String(error)

        },

        {
          status: 500
        }

      );

    }

  }

};

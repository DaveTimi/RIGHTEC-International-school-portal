/**
 * Levity Ethics Systems
 * System permissions
 *
 * These are the individual actions that can be
 * assigned to different roles later.
 */

export const PERMISSIONS = {
  // Platform
  PLATFORM_MANAGE: "platform.manage",
  PLATFORM_VIEW: "platform.view",

  // Schools
  SCHOOL_CREATE: "school.create",
  SCHOOL_VIEW: "school.view",
  SCHOOL_UPDATE: "school.update",
  SCHOOL_DELETE: "school.delete",

  // Users
  USER_CREATE: "user.create",
  USER_VIEW: "user.view",
  USER_UPDATE: "user.update",
  USER_SUSPEND: "user.suspend",

  // Students
  STUDENT_CREATE: "student.create",
  STUDENT_VIEW: "student.view",
  STUDENT_UPDATE: "student.update",
  STUDENT_DELETE: "student.delete",

  // Staff
  STAFF_CREATE: "staff.create",
  STAFF_VIEW: "staff.view",
  STAFF_UPDATE: "staff.update",
  STAFF_DELETE: "staff.delete",

  // Academics
  ACADEMICS_VIEW: "academics.view",
  ACADEMICS_MANAGE: "academics.manage",

  // Attendance
  ATTENDANCE_VIEW: "attendance.view",
  ATTENDANCE_MANAGE: "attendance.manage",

  // Examinations and results
  EXAM_CREATE: "exam.create",
  EXAM_VIEW: "exam.view",
  EXAM_UPDATE: "exam.update",
  RESULT_CREATE: "result.create",
  RESULT_VIEW: "result.view",
  RESULT_UPDATE: "result.update",

  // Fees
  FEES_VIEW: "fees.view",
  FEES_MANAGE: "fees.manage",
  PAYMENT_VIEW: "payment.view",
  PAYMENT_MANAGE: "payment.manage",

  // Communication
  ANNOUNCEMENT_CREATE: "announcement.create",
  ANNOUNCEMENT_VIEW: "announcement.view",
  NOTIFICATION_SEND: "notification.send",

  // Reports
  REPORT_VIEW: "report.view",
  REPORT_EXPORT: "report.export"
} as const;

export type Permission =
  (typeof PERMISSIONS)[keyof typeof PERMISSIONS];

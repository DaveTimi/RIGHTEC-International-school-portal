import type { UserRole } from "../types/index.js";

/**
 * Levity Ethics Systems
 * System roles
 */

export const ROLES: Record<UserRole, string> = {
  super_admin: "Platform Super Admin",

  school_owner: "School Owner",
  school_admin: "School Administrator",

  principal: "Principal",
  vice_principal: "Vice Principal",

  teacher: "Teacher",
  bursar: "Bursar",
  staff: "Staff",

  student: "Student",
  parent: "Parent / Guardian"
};

export const ALL_ROLES = Object.keys(ROLES) as UserRole[];

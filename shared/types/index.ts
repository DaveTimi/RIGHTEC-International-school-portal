/**
 * Levity Ethics Systems
 * Shared application types
 *
 * These types are intentionally kept independent of
 * the database and UI so they can be used across
 * the entire LES platform.
 */

export type ID = string;

export type SchoolStatus =
  | "active"
  | "suspended"
  | "inactive";

export type UserStatus =
  | "active"
  | "suspended"
  | "pending"
  | "inactive";

export type UserRole =
  | "super_admin"
  | "school_owner"
  | "school_admin"
  | "principal"
  | "vice_principal"
  | "teacher"
  | "bursar"
  | "staff"
  | "student"
  | "parent";

export interface School {
  id: ID;
  name: string;
  slug: string;
  status: SchoolStatus;
  createdAt: string;
  updatedAt: string;
}

export interface User {
  id: ID;
  email: string;
  firstName: string;
  lastName: string;
  status: UserStatus;
  createdAt: string;
  updatedAt: string;
}

export interface SchoolMember {
  id: ID;
  schoolId: ID;
  userId: ID;
  role: UserRole;
  createdAt: string;
  updatedAt: string;
}

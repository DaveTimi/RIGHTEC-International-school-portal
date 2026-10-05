import type { UserRole } from "../types/index.js";
import { ROLE_PERMISSIONS } from "./role-permissions.js";
import type { Permission } from "./permissions.js";

/**
 * Levity Ethics Systems
 * Authorization utilities
 *
 * This file provides the basic permission-checking layer.
 *
 * IMPORTANT:
 * These helpers determine whether a role has a permission.
 * School/tenant isolation will be enforced separately
 * when the backend and database layers are implemented.
 */

/**
 * Check whether a role has a specific permission.
 */
export function hasPermission(
  role: UserRole,
  permission: Permission
): boolean {
  const permissions = ROLE_PERMISSIONS[role];

  if (!permissions) {
    return false;
  }

  return permissions.includes(permission);
}

/**
 * Check whether a role has at least one of the
 * supplied permissions.
 */
export function hasAnyPermission(
  role: UserRole,
  permissions: Permission[]
): boolean {
  return permissions.some((permission) =>
    hasPermission(role, permission)
  );
}

/**
 * Check whether a role has every supplied permission.
 */
export function hasAllPermissions(
  role: UserRole,
  permissions: Permission[]
): boolean {
  return permissions.every((permission) =>
    hasPermission(role, permission)
  );
}

/**
 * Get every permission assigned to a role.
 */
export function getRolePermissions(
  role: UserRole
): Permission[] {
  return ROLE_PERMISSIONS[role] ?? [];
}

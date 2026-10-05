import type { ID } from "../types/index.js";
import type {
  AuthenticatedTenantContext,
  TenantContext
} from "../types/tenant.js";

/**
 * Levity Ethics Systems
 * Tenant / school access control
 *
 * These helpers provide the foundation for ensuring that
 * authenticated users can only access data belonging to
 * the school they are currently operating in.
 */

/**
 * Check whether a request belongs to the expected school.
 */
export function isSameTenant(
  context: TenantContext,
  schoolId: ID
): boolean {
  return context.schoolId === schoolId;
}

/**
 * Require the request to belong to the expected school.
 *
 * Throws an error when the school does not match.
 */
export function requireTenantAccess(
  context: TenantContext,
  schoolId: ID
): void {
  if (!isSameTenant(context, schoolId)) {
    throw new Error("Tenant access denied.");
  }
}

/**
 * Create a tenant-aware authentication context.
 */
export function createTenantContext(
  userId: ID,
  schoolId: ID,
  role: string
): AuthenticatedTenantContext {
  return {
    userId,
    schoolId,
    role
  };
}

/**
 * Verify that an authenticated user is operating
 * inside a specific school.
 */
export function verifyTenantContext(
  context: AuthenticatedTenantContext,
  schoolId: ID
): boolean {
  return context.schoolId === schoolId;
}

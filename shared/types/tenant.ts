/**
 * Levity Ethics Systems
 * Multi-tenant / multi-school types
 *
 * Every school using LES is treated as an independent tenant.
 * Tenant-aware services will use these types to make sure
 * data belongs to the correct school.
 */

import type { ID, SchoolStatus } from "./index.js";

export interface TenantContext {
  schoolId: ID;
  userId: ID;
}

export interface Tenant {
  id: ID;
  name: string;
  slug: string;
  status: SchoolStatus;
  createdAt: string;
  updatedAt: string;
}

/**
 * Represents a user's membership inside a school.
 */
export interface TenantMembership {
  id: ID;
  schoolId: ID;
  userId: ID;
  role: string;
  createdAt: string;
  updatedAt: string;
}

/**
 * Data that can safely be attached to a request
 * after authentication and tenant identification.
 */
export interface AuthenticatedTenantContext {
  userId: ID;
  schoolId: ID;
  role: string;
}

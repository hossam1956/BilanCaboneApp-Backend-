package com.example.BilanCarbone.config;

/**
 * @author Oussama
 **/



public class CustomUserRepresentationWithRole {
    private CustomUserRepresentation customUserRepresentation;
    private String role;

    public CustomUserRepresentationWithRole(CustomUserRepresentation customUserRepresentation, String role) {
        this.customUserRepresentation = customUserRepresentation;
        this.role = role;
    }

    public CustomUserRepresentationWithRole() {
    }

    public static CustomUserRepresentationWithRoleBuilder builder() {
        return new CustomUserRepresentationWithRoleBuilder();
    }

    public CustomUserRepresentation getCustomUserRepresentation() {
        return this.customUserRepresentation;
    }

    public String getRole() {
        return this.role;
    }

    public void setCustomUserRepresentation(CustomUserRepresentation customUserRepresentation) {
        this.customUserRepresentation = customUserRepresentation;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean equals(final Object o) {
        if (o == this) return true;
        if (!(o instanceof CustomUserRepresentationWithRole)) return false;
        final CustomUserRepresentationWithRole other = (CustomUserRepresentationWithRole) o;
        if (!other.canEqual((Object) this)) return false;
        final Object this$customUserRepresentation = this.getCustomUserRepresentation();
        final Object other$customUserRepresentation = other.getCustomUserRepresentation();
        if (this$customUserRepresentation == null ? other$customUserRepresentation != null : !this$customUserRepresentation.equals(other$customUserRepresentation))
            return false;
        final Object this$role = this.getRole();
        final Object other$role = other.getRole();
        if (this$role == null ? other$role != null : !this$role.equals(other$role)) return false;
        return true;
    }

    protected boolean canEqual(final Object other) {
        return other instanceof CustomUserRepresentationWithRole;
    }

    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final Object $customUserRepresentation = this.getCustomUserRepresentation();
        result = result * PRIME + ($customUserRepresentation == null ? 43 : $customUserRepresentation.hashCode());
        final Object $role = this.getRole();
        result = result * PRIME + ($role == null ? 43 : $role.hashCode());
        return result;
    }

    public String toString() {
        return "CustomUserRepresentationWithRole(customUserRepresentation=" + this.getCustomUserRepresentation() + ", role=" + this.getRole() + ")";
    }

    public static class CustomUserRepresentationWithRoleBuilder {
        private CustomUserRepresentation customUserRepresentation;
        private String role;

        CustomUserRepresentationWithRoleBuilder() {
        }

        public CustomUserRepresentationWithRoleBuilder customUserRepresentation(CustomUserRepresentation customUserRepresentation) {
            this.customUserRepresentation = customUserRepresentation;
            return this;
        }

        public CustomUserRepresentationWithRoleBuilder role(String role) {
            this.role = role;
            return this;
        }

        public CustomUserRepresentationWithRole build() {
            return new CustomUserRepresentationWithRole(this.customUserRepresentation, this.role);
        }

        public String toString() {
            return "CustomUserRepresentationWithRole.CustomUserRepresentationWithRoleBuilder(customUserRepresentation=" + this.customUserRepresentation + ", role=" + this.role + ")";
        }
    }
}

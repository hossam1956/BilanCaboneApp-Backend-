package com.example.BilanCarbone.dto;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.List;

/**
 * @author Oussama
 **/
public class TypeResponse {
    private Long id;
    private String nom_type;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Boolean active;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String create;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<TypeResponse> files;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Long parent;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<FacteurResponse> facteurs;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String deleted;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String update;

    public TypeResponse(Long id, String nom_type, Boolean active, String create, List<TypeResponse> files, Long parent, List<FacteurResponse> facteurs, String deleted, String update) {
        this.id = id;
        this.nom_type = nom_type;
        this.active = active;
        this.create = create;
        this.files = files;
        this.parent = parent;
        this.facteurs = facteurs;
        this.deleted = deleted;
        this.update = update;
    }

    public TypeResponse() {
    }

    public static TypeResponseBuilder builder() {
        return new TypeResponseBuilder();
    }

    public boolean existfils(Long id) {
        for (TypeResponse fil : files) {
            if (fil.getId().equals(id)) {
                return true;
            }
        }
        return false;
    }

    public Long getId() {
        return this.id;
    }

    public String getNom_type() {
        return this.nom_type;
    }

    public Boolean getActive() {
        return this.active;
    }

    public String getCreate() {
        return this.create;
    }

    public List<TypeResponse> getFiles() {
        return this.files;
    }

    public Long getParent() {
        return this.parent;
    }

    public List<FacteurResponse> getFacteurs() {
        return this.facteurs;
    }

    public String getDeleted() {
        return this.deleted;
    }

    public String getUpdate() {
        return this.update;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setNom_type(String nom_type) {
        this.nom_type = nom_type;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public void setCreate(String create) {
        this.create = create;
    }

    public void setFiles(List<TypeResponse> files) {
        this.files = files;
    }

    public void setParent(Long parent) {
        this.parent = parent;
    }

    public void setFacteurs(List<FacteurResponse> facteurs) {
        this.facteurs = facteurs;
    }

    public void setDeleted(String deleted) {
        this.deleted = deleted;
    }

    public void setUpdate(String update) {
        this.update = update;
    }

    public boolean equals(final Object o) {
        if (o == this) return true;
        if (!(o instanceof TypeResponse)) return false;
        final TypeResponse other = (TypeResponse) o;
        if (!other.canEqual((Object) this)) return false;
        final Object this$id = this.getId();
        final Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final Object this$nom_type = this.getNom_type();
        final Object other$nom_type = other.getNom_type();
        if (this$nom_type == null ? other$nom_type != null : !this$nom_type.equals(other$nom_type)) return false;
        final Object this$active = this.getActive();
        final Object other$active = other.getActive();
        if (this$active == null ? other$active != null : !this$active.equals(other$active)) return false;
        final Object this$create = this.getCreate();
        final Object other$create = other.getCreate();
        if (this$create == null ? other$create != null : !this$create.equals(other$create)) return false;
        final Object this$files = this.getFiles();
        final Object other$files = other.getFiles();
        if (this$files == null ? other$files != null : !this$files.equals(other$files)) return false;
        final Object this$parent = this.getParent();
        final Object other$parent = other.getParent();
        if (this$parent == null ? other$parent != null : !this$parent.equals(other$parent)) return false;
        final Object this$facteurs = this.getFacteurs();
        final Object other$facteurs = other.getFacteurs();
        if (this$facteurs == null ? other$facteurs != null : !this$facteurs.equals(other$facteurs)) return false;
        final Object this$deleted = this.getDeleted();
        final Object other$deleted = other.getDeleted();
        if (this$deleted == null ? other$deleted != null : !this$deleted.equals(other$deleted)) return false;
        final Object this$update = this.getUpdate();
        final Object other$update = other.getUpdate();
        if (this$update == null ? other$update != null : !this$update.equals(other$update)) return false;
        return true;
    }

    protected boolean canEqual(final Object other) {
        return other instanceof TypeResponse;
    }

    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final Object $nom_type = this.getNom_type();
        result = result * PRIME + ($nom_type == null ? 43 : $nom_type.hashCode());
        final Object $active = this.getActive();
        result = result * PRIME + ($active == null ? 43 : $active.hashCode());
        final Object $create = this.getCreate();
        result = result * PRIME + ($create == null ? 43 : $create.hashCode());
        final Object $files = this.getFiles();
        result = result * PRIME + ($files == null ? 43 : $files.hashCode());
        final Object $parent = this.getParent();
        result = result * PRIME + ($parent == null ? 43 : $parent.hashCode());
        final Object $facteurs = this.getFacteurs();
        result = result * PRIME + ($facteurs == null ? 43 : $facteurs.hashCode());
        final Object $deleted = this.getDeleted();
        result = result * PRIME + ($deleted == null ? 43 : $deleted.hashCode());
        final Object $update = this.getUpdate();
        result = result * PRIME + ($update == null ? 43 : $update.hashCode());
        return result;
    }

    public String toString() {
        return "TypeResponse(id=" + this.getId() + ", nom_type=" + this.getNom_type() + ", active=" + this.getActive() + ", create=" + this.getCreate() + ", files=" + this.getFiles() + ", parent=" + this.getParent() + ", facteurs=" + this.getFacteurs() + ", deleted=" + this.getDeleted() + ", update=" + this.getUpdate() + ")";
    }

    public static class TypeResponseBuilder {
        private Long id;
        private String nom_type;
        private Boolean active;
        private String create;
        private List<TypeResponse> files;
        private Long parent;
        private List<FacteurResponse> facteurs;
        private String deleted;
        private String update;

        TypeResponseBuilder() {
        }

        public TypeResponseBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public TypeResponseBuilder nom_type(String nom_type) {
            this.nom_type = nom_type;
            return this;
        }

        public TypeResponseBuilder active(Boolean active) {
            this.active = active;
            return this;
        }

        public TypeResponseBuilder create(String create) {
            this.create = create;
            return this;
        }

        public TypeResponseBuilder files(List<TypeResponse> files) {
            this.files = files;
            return this;
        }

        public TypeResponseBuilder parent(Long parent) {
            this.parent = parent;
            return this;
        }

        public TypeResponseBuilder facteurs(List<FacteurResponse> facteurs) {
            this.facteurs = facteurs;
            return this;
        }

        public TypeResponseBuilder deleted(String deleted) {
            this.deleted = deleted;
            return this;
        }

        public TypeResponseBuilder update(String update) {
            this.update = update;
            return this;
        }

        public TypeResponse build() {
            return new TypeResponse(this.id, this.nom_type, this.active, this.create, this.files, this.parent, this.facteurs, this.deleted, this.update);
        }

        public String toString() {
            return "TypeResponse.TypeResponseBuilder(id=" + this.id + ", nom_type=" + this.nom_type + ", active=" + this.active + ", create=" + this.create + ", files=" + this.files + ", parent=" + this.parent + ", facteurs=" + this.facteurs + ", deleted=" + this.deleted + ", update=" + this.update + ")";
        }
    }
}

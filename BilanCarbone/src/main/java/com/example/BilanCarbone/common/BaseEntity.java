package com.example.BilanCarbone.common;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;


/**
 * Classe de base pour toutes les entités du modèle de données.
 * <p>
 * La classe {@code BaseEntity} fournit des champs communs à toutes les entités, incluant un identifiant unique,
 * des informations de création et de modification, ainsi qu'un champ pour gérer les suppressions logiques.
 * Elle est annotée avec {@code @MappedSuperclass} pour être héritée par d'autres entités sans être elle-même une entité persistante.
 * </p>
 *
 * @author Oussama
 */
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public class BaseEntity {

    /**
     * Identifiant unique de l'entité, généré automatiquement.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Date et heure de création de l'entité, définie automatiquement lors de la persistance.
     */
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdDate;

    /**
     * Date et heure de la dernière modification de l'entité, mise à jour automatiquement lors des modifications.
     */
    @UpdateTimestamp
    @Column(insertable = false)
    private LocalDateTime UpdateDate;

    /**
     * Date et heure de suppression logique de l'entité. Si ce champ est non nul, l'entité est considérée comme supprimée.
     * La valeur par défaut est {@code null}.
     */
    @Column(columnDefinition = "timestamp default null")
    private LocalDateTime isDeleted;

    public BaseEntity(Long id, LocalDateTime createdDate, LocalDateTime UpdateDate, LocalDateTime isDeleted) {
        this.id = id;
        this.createdDate = createdDate;
        this.UpdateDate = UpdateDate;
        this.isDeleted = isDeleted;
    }

    public BaseEntity() {
    }

    protected BaseEntity(BaseEntityBuilder<?, ?> b) {
        this.id = b.id;
        this.createdDate = b.createdDate;
        this.UpdateDate = b.UpdateDate;
        this.isDeleted = b.isDeleted;
    }

    public static BaseEntityBuilder<?, ?> builder() {
        return new BaseEntityBuilderImpl();
    }

    public Long getId() {
        return this.id;
    }

    public LocalDateTime getCreatedDate() {
        return this.createdDate;
    }

    public LocalDateTime getUpdateDate() {
        return this.UpdateDate;
    }

    public LocalDateTime getIsDeleted() {
        return this.isDeleted;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public void setUpdateDate(LocalDateTime UpdateDate) {
        this.UpdateDate = UpdateDate;
    }

    public void setIsDeleted(LocalDateTime isDeleted) {
        this.isDeleted = isDeleted;
    }

    public boolean equals(final Object o) {
        if (o == this) return true;
        if (!(o instanceof BaseEntity)) return false;
        final BaseEntity other = (BaseEntity) o;
        if (!other.canEqual((Object) this)) return false;
        final Object this$id = this.getId();
        final Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final Object this$createdDate = this.getCreatedDate();
        final Object other$createdDate = other.getCreatedDate();
        if (this$createdDate == null ? other$createdDate != null : !this$createdDate.equals(other$createdDate))
            return false;
        final Object this$UpdateDate = this.getUpdateDate();
        final Object other$UpdateDate = other.getUpdateDate();
        if (this$UpdateDate == null ? other$UpdateDate != null : !this$UpdateDate.equals(other$UpdateDate))
            return false;
        final Object this$isDeleted = this.getIsDeleted();
        final Object other$isDeleted = other.getIsDeleted();
        if (this$isDeleted == null ? other$isDeleted != null : !this$isDeleted.equals(other$isDeleted)) return false;
        return true;
    }

    protected boolean canEqual(final Object other) {
        return other instanceof BaseEntity;
    }

    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final Object $createdDate = this.getCreatedDate();
        result = result * PRIME + ($createdDate == null ? 43 : $createdDate.hashCode());
        final Object $UpdateDate = this.getUpdateDate();
        result = result * PRIME + ($UpdateDate == null ? 43 : $UpdateDate.hashCode());
        final Object $isDeleted = this.getIsDeleted();
        result = result * PRIME + ($isDeleted == null ? 43 : $isDeleted.hashCode());
        return result;
    }

    public String toString() {
        return "BaseEntity(id=" + this.getId() + ", createdDate=" + this.getCreatedDate() + ", UpdateDate=" + this.getUpdateDate() + ", isDeleted=" + this.getIsDeleted() + ")";
    }

    public static abstract class BaseEntityBuilder<C extends BaseEntity, B extends BaseEntityBuilder<C, B>> {
        private Long id;
        private LocalDateTime createdDate;
        private LocalDateTime UpdateDate;
        private LocalDateTime isDeleted;

        public B id(Long id) {
            this.id = id;
            return self();
        }

        public B createdDate(LocalDateTime createdDate) {
            this.createdDate = createdDate;
            return self();
        }

        public B UpdateDate(LocalDateTime UpdateDate) {
            this.UpdateDate = UpdateDate;
            return self();
        }

        public B isDeleted(LocalDateTime isDeleted) {
            this.isDeleted = isDeleted;
            return self();
        }

        protected abstract B self();

        public abstract C build();

        public String toString() {
            return "BaseEntity.BaseEntityBuilder(id=" + this.id + ", createdDate=" + this.createdDate + ", UpdateDate=" + this.UpdateDate + ", isDeleted=" + this.isDeleted + ")";
        }
    }

    private static final class BaseEntityBuilderImpl extends BaseEntityBuilder<BaseEntity, BaseEntityBuilderImpl> {
        private BaseEntityBuilderImpl() {
        }

        protected BaseEntityBuilderImpl self() {
            return this;
        }

        public BaseEntity build() {
            return new BaseEntity(this);
        }
    }
}

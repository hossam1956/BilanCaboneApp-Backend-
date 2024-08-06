--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO admin;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO admin;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO admin;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO admin;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO admin;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO admin;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO admin;

--
-- Name: client; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO admin;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO admin;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO admin;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO admin;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO admin;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO admin;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO admin;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO admin;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO admin;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO admin;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO admin;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO admin;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO admin;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO admin;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO admin;

--
-- Name: component; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO admin;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO admin;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO admin;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO admin;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO admin;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO admin;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO admin;

--
-- Name: demande_utilisateur; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.demande_utilisateur (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nom character varying(255) NOT NULL,
    nom_utilisateur character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    prenom character varying(255) NOT NULL,
    raw_password character varying(255),
    role character varying(255) NOT NULL,
    send_date timestamp(6) without time zone NOT NULL,
    entreprise_id bigint NOT NULL
);


ALTER TABLE public.demande_utilisateur OWNER TO admin;

--
-- Name: demande_utilisateur_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.demande_utilisateur ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.demande_utilisateur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: entreprise; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.entreprise (
    id bigint NOT NULL,
    nom_entreprise character varying(255) NOT NULL
);


ALTER TABLE public.entreprise OWNER TO admin;

--
-- Name: entreprise_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.entreprise ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.entreprise_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO admin;

--
-- Name: facteur; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.facteur (
    id bigint NOT NULL,
    update_date timestamp(6) without time zone,
    created_date timestamp(6) without time zone NOT NULL,
    is_deleted timestamp without time zone,
    active boolean,
    emission_factor numeric(38,2),
    nom character varying(255),
    unit character varying(255),
    type_id bigint,
    CONSTRAINT facteur_unit_check CHECK (((unit)::text = ANY ((ARRAY['KG'::character varying, 'LITRE'::character varying, 'M3'::character varying, 'kWh'::character varying, 'WH'::character varying, 'kM'::character varying, 'TO'::character varying, 'PKM'::character varying, 'HA'::character varying, 'M2'::character varying, 'AN'::character varying, 'UNKNOWN'::character varying, 'HR'::character varying])::text[])))
);


ALTER TABLE public.facteur OWNER TO admin;

--
-- Name: facteur_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.facteur ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.facteur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO admin;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO admin;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO admin;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO admin;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO admin;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO admin;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO admin;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO admin;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO admin;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO admin;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO admin;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO admin;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO admin;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO admin;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO admin;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO admin;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO admin;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO admin;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO admin;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO admin;

--
-- Name: org; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000)
);


ALTER TABLE public.org OWNER TO admin;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO admin;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO admin;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO admin;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO admin;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO admin;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO admin;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO admin;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO admin;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO admin;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO admin;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO admin;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO admin;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO admin;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO admin;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO admin;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO admin;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO admin;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO admin;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO admin;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO admin;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO admin;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO admin;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO admin;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO admin;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO admin;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO admin;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO admin;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO admin;

--
-- Name: type; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.type (
    id bigint NOT NULL,
    update_date timestamp(6) without time zone,
    created_date timestamp(6) without time zone NOT NULL,
    is_deleted timestamp without time zone,
    active boolean,
    name character varying(255),
    parent_id bigint
);


ALTER TABLE public.type OWNER TO admin;

--
-- Name: type_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO admin;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO admin;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO admin;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO admin;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO admin;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO admin;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO admin;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO admin;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO admin;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO admin;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO admin;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO admin;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO admin;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO admin;

--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.utilisateur (
    id character varying(255) NOT NULL,
    entreprise_id bigint NOT NULL
);


ALTER TABLE public.utilisateur OWNER TO admin;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO admin;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
afe52ef4-e879-4fc6-b619-4f7442a5db31	\N	auth-cookie	beec1c98-131e-4539-bb19-21867eb81576	a78536a9-5f41-4649-abca-691e8a054a16	2	10	f	\N	\N
35db344f-fe80-49c3-9152-fc9055990169	\N	auth-spnego	beec1c98-131e-4539-bb19-21867eb81576	a78536a9-5f41-4649-abca-691e8a054a16	3	20	f	\N	\N
4b891a8a-6f1b-400a-bbf5-dc2f978c709c	\N	identity-provider-redirector	beec1c98-131e-4539-bb19-21867eb81576	a78536a9-5f41-4649-abca-691e8a054a16	2	25	f	\N	\N
5f22527d-7ea8-4031-9531-f30718891724	\N	\N	beec1c98-131e-4539-bb19-21867eb81576	a78536a9-5f41-4649-abca-691e8a054a16	2	30	t	92b97086-54de-42bc-ac77-ac577c0c73f0	\N
8d6e3af5-bbdb-4231-9bdb-170b419dfd15	\N	auth-username-password-form	beec1c98-131e-4539-bb19-21867eb81576	92b97086-54de-42bc-ac77-ac577c0c73f0	0	10	f	\N	\N
e121a9e3-f4c3-4f9f-bd37-e7a258104960	\N	\N	beec1c98-131e-4539-bb19-21867eb81576	92b97086-54de-42bc-ac77-ac577c0c73f0	1	20	t	73f9d87b-4c55-4b9e-a8cb-f51ef900e9cb	\N
826d3d9e-d924-45d1-9f38-c88545f27c10	\N	conditional-user-configured	beec1c98-131e-4539-bb19-21867eb81576	73f9d87b-4c55-4b9e-a8cb-f51ef900e9cb	0	10	f	\N	\N
96022af1-c1c4-4e95-ac1f-e4b8bf882763	\N	auth-otp-form	beec1c98-131e-4539-bb19-21867eb81576	73f9d87b-4c55-4b9e-a8cb-f51ef900e9cb	0	20	f	\N	\N
316d89d2-82dd-4084-b1d7-3cc7ecc99857	\N	direct-grant-validate-username	beec1c98-131e-4539-bb19-21867eb81576	6dcb5189-5e57-4961-bc89-e953047135d1	0	10	f	\N	\N
76a53f3a-b019-43f6-8973-0268f9a11969	\N	direct-grant-validate-password	beec1c98-131e-4539-bb19-21867eb81576	6dcb5189-5e57-4961-bc89-e953047135d1	0	20	f	\N	\N
cb057d14-7af3-451c-8ffa-c551fff4fff4	\N	\N	beec1c98-131e-4539-bb19-21867eb81576	6dcb5189-5e57-4961-bc89-e953047135d1	1	30	t	7b0da513-74c1-493d-82db-e6826294d41c	\N
3276e513-4251-472f-a22c-e5502ccd8c5a	\N	conditional-user-configured	beec1c98-131e-4539-bb19-21867eb81576	7b0da513-74c1-493d-82db-e6826294d41c	0	10	f	\N	\N
a8e7a154-8ba3-437d-bbf4-d9bbdaa7be5c	\N	direct-grant-validate-otp	beec1c98-131e-4539-bb19-21867eb81576	7b0da513-74c1-493d-82db-e6826294d41c	0	20	f	\N	\N
9902a717-8ad5-4ed0-9d98-b71e823fc3e1	\N	registration-page-form	beec1c98-131e-4539-bb19-21867eb81576	3f7a51ac-e397-4d40-ab85-0fa956c669af	0	10	t	0f22f1ad-8936-4e7f-a6b8-6cae18690630	\N
3637395a-489e-445e-afe8-ebceb7405617	\N	registration-user-creation	beec1c98-131e-4539-bb19-21867eb81576	0f22f1ad-8936-4e7f-a6b8-6cae18690630	0	20	f	\N	\N
88ae3129-754c-4950-bdc9-05cad771fbf7	\N	registration-password-action	beec1c98-131e-4539-bb19-21867eb81576	0f22f1ad-8936-4e7f-a6b8-6cae18690630	0	50	f	\N	\N
755db5ff-2848-4098-9a19-f10ed1e1d88f	\N	registration-recaptcha-action	beec1c98-131e-4539-bb19-21867eb81576	0f22f1ad-8936-4e7f-a6b8-6cae18690630	3	60	f	\N	\N
35a104a3-683e-48b2-bafe-6beea7a1fc74	\N	registration-terms-and-conditions	beec1c98-131e-4539-bb19-21867eb81576	0f22f1ad-8936-4e7f-a6b8-6cae18690630	3	70	f	\N	\N
7fce508d-fb9c-4978-af80-b362ee0b1b67	\N	reset-credentials-choose-user	beec1c98-131e-4539-bb19-21867eb81576	f2673826-cef8-4136-9604-f207bd7a6d63	0	10	f	\N	\N
e7603fd6-d270-4db4-9fc3-2a2b310bf4f1	\N	reset-credential-email	beec1c98-131e-4539-bb19-21867eb81576	f2673826-cef8-4136-9604-f207bd7a6d63	0	20	f	\N	\N
f825cbbc-3008-4530-adb7-0e8649444634	\N	reset-password	beec1c98-131e-4539-bb19-21867eb81576	f2673826-cef8-4136-9604-f207bd7a6d63	0	30	f	\N	\N
9eff03cd-2d0e-4d8c-9d39-4f74af6dbaa6	\N	\N	beec1c98-131e-4539-bb19-21867eb81576	f2673826-cef8-4136-9604-f207bd7a6d63	1	40	t	2a2748e0-3f00-46d9-8a77-7bc91ef45ad3	\N
23fc3a7c-d6a3-4a6a-a5e7-ad44c307cfbb	\N	conditional-user-configured	beec1c98-131e-4539-bb19-21867eb81576	2a2748e0-3f00-46d9-8a77-7bc91ef45ad3	0	10	f	\N	\N
127c67a5-a31f-4759-b925-89cdd42ec49f	\N	reset-otp	beec1c98-131e-4539-bb19-21867eb81576	2a2748e0-3f00-46d9-8a77-7bc91ef45ad3	0	20	f	\N	\N
5a3b1e85-2660-4372-a370-695aabcbd297	\N	client-secret	beec1c98-131e-4539-bb19-21867eb81576	89663f6c-1ec6-4ae7-9ec8-3a8ca4223cdb	2	10	f	\N	\N
3711453d-c1e1-464f-8a1b-93cd135575e7	\N	client-jwt	beec1c98-131e-4539-bb19-21867eb81576	89663f6c-1ec6-4ae7-9ec8-3a8ca4223cdb	2	20	f	\N	\N
8d1e906c-8b5b-466e-b4e3-80f9e7804940	\N	client-secret-jwt	beec1c98-131e-4539-bb19-21867eb81576	89663f6c-1ec6-4ae7-9ec8-3a8ca4223cdb	2	30	f	\N	\N
f8da27cf-63d9-4990-b0b1-358de1d5166a	\N	client-x509	beec1c98-131e-4539-bb19-21867eb81576	89663f6c-1ec6-4ae7-9ec8-3a8ca4223cdb	2	40	f	\N	\N
1e3dd291-5488-4e29-8810-9d712cd2bbe8	\N	idp-review-profile	beec1c98-131e-4539-bb19-21867eb81576	ba6f3019-3970-4e1d-965a-18b12b3d9983	0	10	f	\N	0303bd0e-23fc-487f-af53-51fed3255fe2
d4080725-68f7-4116-baa5-aeaf26771a29	\N	\N	beec1c98-131e-4539-bb19-21867eb81576	ba6f3019-3970-4e1d-965a-18b12b3d9983	0	20	t	b3022ce6-01fb-4991-bb06-8588971ef3e8	\N
685e46b8-391a-4949-b95a-8971e878650f	\N	idp-create-user-if-unique	beec1c98-131e-4539-bb19-21867eb81576	b3022ce6-01fb-4991-bb06-8588971ef3e8	2	10	f	\N	9a450a65-d8a1-432a-988c-faa54610dc55
83d57286-e732-4169-877f-bc96cf527cac	\N	\N	beec1c98-131e-4539-bb19-21867eb81576	b3022ce6-01fb-4991-bb06-8588971ef3e8	2	20	t	750b0f1b-d005-4549-81a1-6979e79e9111	\N
1520ee67-3439-4ac4-8658-0a0d76369b75	\N	idp-confirm-link	beec1c98-131e-4539-bb19-21867eb81576	750b0f1b-d005-4549-81a1-6979e79e9111	0	10	f	\N	\N
e605a138-8d6f-4475-aa82-b41895bb6ff1	\N	\N	beec1c98-131e-4539-bb19-21867eb81576	750b0f1b-d005-4549-81a1-6979e79e9111	0	20	t	344e7802-58f3-49d6-ac51-1147dd0cc7e4	\N
8ef1c34c-be8f-46c6-9f9d-c2b418e794d7	\N	idp-email-verification	beec1c98-131e-4539-bb19-21867eb81576	344e7802-58f3-49d6-ac51-1147dd0cc7e4	2	10	f	\N	\N
dbf8dd4d-8861-4c6c-96cc-eeb15c0af7cf	\N	\N	beec1c98-131e-4539-bb19-21867eb81576	344e7802-58f3-49d6-ac51-1147dd0cc7e4	2	20	t	90c15281-0600-46cf-a1e9-a15c223e2470	\N
6bf03612-4083-42ce-a77f-18e9221516f3	\N	idp-username-password-form	beec1c98-131e-4539-bb19-21867eb81576	90c15281-0600-46cf-a1e9-a15c223e2470	0	10	f	\N	\N
72565b31-4953-4d8f-8081-578ab5b13543	\N	\N	beec1c98-131e-4539-bb19-21867eb81576	90c15281-0600-46cf-a1e9-a15c223e2470	1	20	t	6428a344-1a53-4d9e-b20e-f754e26875f8	\N
d56911ef-3fc2-40e4-85fe-28b46ad25a93	\N	conditional-user-configured	beec1c98-131e-4539-bb19-21867eb81576	6428a344-1a53-4d9e-b20e-f754e26875f8	0	10	f	\N	\N
e9c54143-adb0-4331-ba4b-54d5acd0de2b	\N	auth-otp-form	beec1c98-131e-4539-bb19-21867eb81576	6428a344-1a53-4d9e-b20e-f754e26875f8	0	20	f	\N	\N
6862ddd8-13c6-4839-877b-e0e3db7d3bbe	\N	http-basic-authenticator	beec1c98-131e-4539-bb19-21867eb81576	7ae9e977-1bb2-40fb-b250-761e6a2d8ec8	0	10	f	\N	\N
8bdfbcf5-c643-4d4d-9f1e-5860feb9b719	\N	docker-http-basic-authenticator	beec1c98-131e-4539-bb19-21867eb81576	e11efc06-b844-42a8-9234-d6c5a43fa05e	0	10	f	\N	\N
c85d888f-0dda-416f-bc43-c861c4d5008b	\N	auth-cookie	3f237d26-0988-482a-b1c2-14ce1e4b950f	df5f1c24-9bd9-4127-b0a8-89397cc094e6	2	10	f	\N	\N
34c6027b-a650-4c8f-9019-54bc4507266e	\N	auth-spnego	3f237d26-0988-482a-b1c2-14ce1e4b950f	df5f1c24-9bd9-4127-b0a8-89397cc094e6	3	20	f	\N	\N
cc5bf744-7785-48d5-a8a6-298ddab7078c	\N	identity-provider-redirector	3f237d26-0988-482a-b1c2-14ce1e4b950f	df5f1c24-9bd9-4127-b0a8-89397cc094e6	2	25	f	\N	\N
054874d0-0209-4bdc-99ec-41d96cbfab15	\N	\N	3f237d26-0988-482a-b1c2-14ce1e4b950f	df5f1c24-9bd9-4127-b0a8-89397cc094e6	2	30	t	feb80c33-92d3-469e-b825-56095a851638	\N
2c301e7c-006a-4d0c-aa94-80def549c7ea	\N	auth-username-password-form	3f237d26-0988-482a-b1c2-14ce1e4b950f	feb80c33-92d3-469e-b825-56095a851638	0	10	f	\N	\N
7872ac26-0a9e-4638-a027-d6c17c54ceee	\N	\N	3f237d26-0988-482a-b1c2-14ce1e4b950f	feb80c33-92d3-469e-b825-56095a851638	1	20	t	43798999-9d3f-4a16-8a65-07f2719c656f	\N
c7a36349-b790-4ff9-b4a6-72b0e70c95aa	\N	conditional-user-configured	3f237d26-0988-482a-b1c2-14ce1e4b950f	43798999-9d3f-4a16-8a65-07f2719c656f	0	10	f	\N	\N
bfed15e7-e852-4e21-b14e-70ded2bbe9eb	\N	auth-otp-form	3f237d26-0988-482a-b1c2-14ce1e4b950f	43798999-9d3f-4a16-8a65-07f2719c656f	0	20	f	\N	\N
2468b760-4d96-440d-a8ac-d8577aca02ee	\N	direct-grant-validate-username	3f237d26-0988-482a-b1c2-14ce1e4b950f	24664842-4926-4d66-b1de-9e663a4562a1	0	10	f	\N	\N
aca421b6-543c-4994-8a38-6f71b2780689	\N	direct-grant-validate-password	3f237d26-0988-482a-b1c2-14ce1e4b950f	24664842-4926-4d66-b1de-9e663a4562a1	0	20	f	\N	\N
6e6cc860-ea67-443c-9685-bd3c9e67f7d8	\N	\N	3f237d26-0988-482a-b1c2-14ce1e4b950f	24664842-4926-4d66-b1de-9e663a4562a1	1	30	t	2e7c9ea5-c365-4da2-aa49-dc2b06b7c5f3	\N
6794b49e-edbd-4d84-b4d9-34ccbb060c5c	\N	conditional-user-configured	3f237d26-0988-482a-b1c2-14ce1e4b950f	2e7c9ea5-c365-4da2-aa49-dc2b06b7c5f3	0	10	f	\N	\N
8350d0e4-f125-4111-acfb-358ee255f6fa	\N	direct-grant-validate-otp	3f237d26-0988-482a-b1c2-14ce1e4b950f	2e7c9ea5-c365-4da2-aa49-dc2b06b7c5f3	0	20	f	\N	\N
350e8011-3677-400a-8cc7-2a03223e7487	\N	registration-page-form	3f237d26-0988-482a-b1c2-14ce1e4b950f	d9906c0c-53e1-46a7-8760-26ebb6a1b638	0	10	t	a1e3ebf8-aaaa-4471-9d21-6d8b59e998ca	\N
234ec47f-ac47-44cc-9318-5d15ed71548b	\N	registration-user-creation	3f237d26-0988-482a-b1c2-14ce1e4b950f	a1e3ebf8-aaaa-4471-9d21-6d8b59e998ca	0	20	f	\N	\N
cfa1c3bc-edcb-4527-94f2-63d44e95fd57	\N	registration-password-action	3f237d26-0988-482a-b1c2-14ce1e4b950f	a1e3ebf8-aaaa-4471-9d21-6d8b59e998ca	0	50	f	\N	\N
bccbce1b-f293-44b7-b40a-a9925e54e2b6	\N	registration-recaptcha-action	3f237d26-0988-482a-b1c2-14ce1e4b950f	a1e3ebf8-aaaa-4471-9d21-6d8b59e998ca	3	60	f	\N	\N
ff0eaef3-a38c-4e63-a1a4-88a79e910466	\N	reset-credentials-choose-user	3f237d26-0988-482a-b1c2-14ce1e4b950f	1352d643-b386-40c1-a7c8-4bfbbc2a73b2	0	10	f	\N	\N
4b97de8d-9ece-43d9-ac3c-7d0cdbb7768c	\N	reset-credential-email	3f237d26-0988-482a-b1c2-14ce1e4b950f	1352d643-b386-40c1-a7c8-4bfbbc2a73b2	0	20	f	\N	\N
b3fae8cd-a003-471f-8911-db9885c73042	\N	reset-password	3f237d26-0988-482a-b1c2-14ce1e4b950f	1352d643-b386-40c1-a7c8-4bfbbc2a73b2	0	30	f	\N	\N
e24c0615-1dae-4b5f-a530-a09613cf9c5d	\N	\N	3f237d26-0988-482a-b1c2-14ce1e4b950f	1352d643-b386-40c1-a7c8-4bfbbc2a73b2	1	40	t	874961de-4f0b-4309-a91b-908f60341ed0	\N
18a683de-f510-4737-a737-87d226955b17	\N	conditional-user-configured	3f237d26-0988-482a-b1c2-14ce1e4b950f	874961de-4f0b-4309-a91b-908f60341ed0	0	10	f	\N	\N
d2e4c470-786b-40bd-b620-527550017539	\N	reset-otp	3f237d26-0988-482a-b1c2-14ce1e4b950f	874961de-4f0b-4309-a91b-908f60341ed0	0	20	f	\N	\N
e6c59e3e-9075-4a7f-8de8-0e376270a6b7	\N	client-secret	3f237d26-0988-482a-b1c2-14ce1e4b950f	77c540dc-d8c3-47c2-aea9-6132dfb6244a	2	10	f	\N	\N
7ed18d61-b4e3-4fe5-9110-6bc74dbc20f9	\N	client-jwt	3f237d26-0988-482a-b1c2-14ce1e4b950f	77c540dc-d8c3-47c2-aea9-6132dfb6244a	2	20	f	\N	\N
f0ffa3b7-c1ea-4fc8-a3d4-013e0aa29d83	\N	client-secret-jwt	3f237d26-0988-482a-b1c2-14ce1e4b950f	77c540dc-d8c3-47c2-aea9-6132dfb6244a	2	30	f	\N	\N
72a75f0e-b516-4ef2-914f-3c5701b6079a	\N	client-x509	3f237d26-0988-482a-b1c2-14ce1e4b950f	77c540dc-d8c3-47c2-aea9-6132dfb6244a	2	40	f	\N	\N
bcb17020-7842-4def-bee3-074b63d68fc2	\N	idp-review-profile	3f237d26-0988-482a-b1c2-14ce1e4b950f	1f998112-efa9-49c8-a132-6f166b109262	0	10	f	\N	3d609d0e-3f6e-4985-97f3-15e5a398f9f3
40e05f56-2ee7-4bef-a415-421a7c534305	\N	\N	3f237d26-0988-482a-b1c2-14ce1e4b950f	1f998112-efa9-49c8-a132-6f166b109262	0	20	t	f6b22d4b-0f48-4de0-bbed-ba956c630cb9	\N
dc0add23-06fa-437e-a5c2-0a77e4a16a8d	\N	idp-create-user-if-unique	3f237d26-0988-482a-b1c2-14ce1e4b950f	f6b22d4b-0f48-4de0-bbed-ba956c630cb9	2	10	f	\N	b3409cbc-7352-46e2-b4fb-4d6ee1368d56
0a1efd7d-661f-457f-9a0c-e36eb11b76f9	\N	\N	3f237d26-0988-482a-b1c2-14ce1e4b950f	f6b22d4b-0f48-4de0-bbed-ba956c630cb9	2	20	t	a04ae4a2-33fa-4af9-a532-1e7cfff587b1	\N
f6f14ae0-6460-491b-95b0-3f5c4accef95	\N	idp-confirm-link	3f237d26-0988-482a-b1c2-14ce1e4b950f	a04ae4a2-33fa-4af9-a532-1e7cfff587b1	0	10	f	\N	\N
45f310f6-60ae-4a2f-817c-a4b20bb14d3e	\N	\N	3f237d26-0988-482a-b1c2-14ce1e4b950f	a04ae4a2-33fa-4af9-a532-1e7cfff587b1	0	20	t	4f780d3d-7e5e-4b0d-b7bb-7181fb71a7e3	\N
3a11a43f-136f-4e57-bb00-09a154c8028a	\N	idp-email-verification	3f237d26-0988-482a-b1c2-14ce1e4b950f	4f780d3d-7e5e-4b0d-b7bb-7181fb71a7e3	2	10	f	\N	\N
92b8710b-c8a6-4585-aea3-a56d728a1d59	\N	\N	3f237d26-0988-482a-b1c2-14ce1e4b950f	4f780d3d-7e5e-4b0d-b7bb-7181fb71a7e3	2	20	t	7b133556-7556-4e58-a5ff-5ea447fc3735	\N
be5cc4c0-5032-40ec-907e-762b9aa2ceaa	\N	idp-username-password-form	3f237d26-0988-482a-b1c2-14ce1e4b950f	7b133556-7556-4e58-a5ff-5ea447fc3735	0	10	f	\N	\N
09542e4b-597e-41f3-b0c3-a8a78b17530b	\N	\N	3f237d26-0988-482a-b1c2-14ce1e4b950f	7b133556-7556-4e58-a5ff-5ea447fc3735	1	20	t	472ff223-da4b-40f3-81ba-dcd3d1036c2a	\N
31212794-65fa-4bff-a184-34ec3d2a7b0a	\N	conditional-user-configured	3f237d26-0988-482a-b1c2-14ce1e4b950f	472ff223-da4b-40f3-81ba-dcd3d1036c2a	0	10	f	\N	\N
a1e5a995-5987-4227-8a5e-9f3554c50231	\N	auth-otp-form	3f237d26-0988-482a-b1c2-14ce1e4b950f	472ff223-da4b-40f3-81ba-dcd3d1036c2a	0	20	f	\N	\N
93a48cc5-0f7c-4ceb-9238-99fb20fe6c8d	\N	http-basic-authenticator	3f237d26-0988-482a-b1c2-14ce1e4b950f	9c5aef5e-2955-45fe-84fa-72f2cf81bb7e	0	10	f	\N	\N
ebaa4127-eea6-4cde-9d30-e6d8cb4ca56f	\N	docker-http-basic-authenticator	3f237d26-0988-482a-b1c2-14ce1e4b950f	2a224daf-b933-484e-a88c-1a4fcbf53f97	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
a78536a9-5f41-4649-abca-691e8a054a16	browser	browser based authentication	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	t	t
92b97086-54de-42bc-ac77-ac577c0c73f0	forms	Username, password, otp and other auth forms.	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	f	t
73f9d87b-4c55-4b9e-a8cb-f51ef900e9cb	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	f	t
6dcb5189-5e57-4961-bc89-e953047135d1	direct grant	OpenID Connect Resource Owner Grant	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	t	t
7b0da513-74c1-493d-82db-e6826294d41c	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	f	t
3f7a51ac-e397-4d40-ab85-0fa956c669af	registration	registration flow	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	t	t
0f22f1ad-8936-4e7f-a6b8-6cae18690630	registration form	registration form	beec1c98-131e-4539-bb19-21867eb81576	form-flow	f	t
f2673826-cef8-4136-9604-f207bd7a6d63	reset credentials	Reset credentials for a user if they forgot their password or something	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	t	t
2a2748e0-3f00-46d9-8a77-7bc91ef45ad3	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	f	t
89663f6c-1ec6-4ae7-9ec8-3a8ca4223cdb	clients	Base authentication for clients	beec1c98-131e-4539-bb19-21867eb81576	client-flow	t	t
ba6f3019-3970-4e1d-965a-18b12b3d9983	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	t	t
b3022ce6-01fb-4991-bb06-8588971ef3e8	User creation or linking	Flow for the existing/non-existing user alternatives	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	f	t
750b0f1b-d005-4549-81a1-6979e79e9111	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	f	t
344e7802-58f3-49d6-ac51-1147dd0cc7e4	Account verification options	Method with which to verity the existing account	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	f	t
90c15281-0600-46cf-a1e9-a15c223e2470	Verify Existing Account by Re-authentication	Reauthentication of existing account	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	f	t
6428a344-1a53-4d9e-b20e-f754e26875f8	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	f	t
7ae9e977-1bb2-40fb-b250-761e6a2d8ec8	saml ecp	SAML ECP Profile Authentication Flow	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	t	t
e11efc06-b844-42a8-9234-d6c5a43fa05e	docker auth	Used by Docker clients to authenticate against the IDP	beec1c98-131e-4539-bb19-21867eb81576	basic-flow	t	t
df5f1c24-9bd9-4127-b0a8-89397cc094e6	browser	browser based authentication	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	t	t
feb80c33-92d3-469e-b825-56095a851638	forms	Username, password, otp and other auth forms.	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	f	t
43798999-9d3f-4a16-8a65-07f2719c656f	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	f	t
24664842-4926-4d66-b1de-9e663a4562a1	direct grant	OpenID Connect Resource Owner Grant	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	t	t
2e7c9ea5-c365-4da2-aa49-dc2b06b7c5f3	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	f	t
d9906c0c-53e1-46a7-8760-26ebb6a1b638	registration	registration flow	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	t	t
a1e3ebf8-aaaa-4471-9d21-6d8b59e998ca	registration form	registration form	3f237d26-0988-482a-b1c2-14ce1e4b950f	form-flow	f	t
1352d643-b386-40c1-a7c8-4bfbbc2a73b2	reset credentials	Reset credentials for a user if they forgot their password or something	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	t	t
874961de-4f0b-4309-a91b-908f60341ed0	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	f	t
77c540dc-d8c3-47c2-aea9-6132dfb6244a	clients	Base authentication for clients	3f237d26-0988-482a-b1c2-14ce1e4b950f	client-flow	t	t
1f998112-efa9-49c8-a132-6f166b109262	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	t	t
f6b22d4b-0f48-4de0-bbed-ba956c630cb9	User creation or linking	Flow for the existing/non-existing user alternatives	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	f	t
a04ae4a2-33fa-4af9-a532-1e7cfff587b1	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	f	t
4f780d3d-7e5e-4b0d-b7bb-7181fb71a7e3	Account verification options	Method with which to verity the existing account	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	f	t
7b133556-7556-4e58-a5ff-5ea447fc3735	Verify Existing Account by Re-authentication	Reauthentication of existing account	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	f	t
472ff223-da4b-40f3-81ba-dcd3d1036c2a	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	f	t
9c5aef5e-2955-45fe-84fa-72f2cf81bb7e	saml ecp	SAML ECP Profile Authentication Flow	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	t	t
2a224daf-b933-484e-a88c-1a4fcbf53f97	docker auth	Used by Docker clients to authenticate against the IDP	3f237d26-0988-482a-b1c2-14ce1e4b950f	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
0303bd0e-23fc-487f-af53-51fed3255fe2	review profile config	beec1c98-131e-4539-bb19-21867eb81576
9a450a65-d8a1-432a-988c-faa54610dc55	create unique user config	beec1c98-131e-4539-bb19-21867eb81576
3d609d0e-3f6e-4985-97f3-15e5a398f9f3	review profile config	3f237d26-0988-482a-b1c2-14ce1e4b950f
b3409cbc-7352-46e2-b4fb-4d6ee1368d56	create unique user config	3f237d26-0988-482a-b1c2-14ce1e4b950f
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
0303bd0e-23fc-487f-af53-51fed3255fe2	missing	update.profile.on.first.login
9a450a65-d8a1-432a-988c-faa54610dc55	false	require.password.update.after.registration
3d609d0e-3f6e-4985-97f3-15e5a398f9f3	missing	update.profile.on.first.login
b3409cbc-7352-46e2-b4fb-4d6ee1368d56	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	f	master-realm	0	f	\N	\N	t	\N	f	beec1c98-131e-4539-bb19-21867eb81576	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	beec1c98-131e-4539-bb19-21867eb81576	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
01a41349-3ba2-42c9-ac22-e0ca3825646a	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	beec1c98-131e-4539-bb19-21867eb81576	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
71d84a5d-e6df-4c82-beba-37f4f877fca6	t	f	broker	0	f	\N	\N	t	\N	f	beec1c98-131e-4539-bb19-21867eb81576	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
fe9194f3-05e6-491e-bbc9-9cdd7909a908	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	beec1c98-131e-4539-bb19-21867eb81576	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
863892e1-a644-4552-9a3b-2b598f8c95f1	t	f	admin-cli	0	t	\N	\N	f	\N	f	beec1c98-131e-4539-bb19-21867eb81576	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	f	BilanCarbone-realm	0	f	\N	\N	t	\N	f	beec1c98-131e-4539-bb19-21867eb81576	\N	0	f	f	BilanCarbone Realm	f	client-secret	\N	\N	\N	t	f	f	f
b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	f	realm-management	0	f	\N	\N	t	\N	f	3f237d26-0988-482a-b1c2-14ce1e4b950f	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
c40bb8d7-0215-4550-8dd1-758bb382ac19	t	f	account	0	t	\N	/realms/BilanCarbone/account/	f	\N	f	3f237d26-0988-482a-b1c2-14ce1e4b950f	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
565f1b69-aa96-4c24-9f10-f5d921f0021e	t	f	account-console	0	t	\N	/realms/BilanCarbone/account/	f	\N	f	3f237d26-0988-482a-b1c2-14ce1e4b950f	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
31419541-a326-4108-9e0a-a76318440af7	t	f	broker	0	f	\N	\N	t	\N	f	3f237d26-0988-482a-b1c2-14ce1e4b950f	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
3a4802dd-0117-4eae-969d-d768b001c0ca	t	f	security-admin-console	0	t	\N	/admin/BilanCarbone/console/	f	\N	f	3f237d26-0988-482a-b1c2-14ce1e4b950f	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
cc775481-ca96-4f0e-a085-d8ea11a29d0a	t	f	admin-cli	0	t	\N	\N	f	\N	f	3f237d26-0988-482a-b1c2-14ce1e4b950f	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
a9ff1805-83cc-4742-96b5-201d1b8c3014	t	t	ReactApp	0	t	\N		f		f	3f237d26-0988-482a-b1c2-14ce1e4b950f	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	post.logout.redirect.uris	+
01a41349-3ba2-42c9-ac22-e0ca3825646a	post.logout.redirect.uris	+
01a41349-3ba2-42c9-ac22-e0ca3825646a	pkce.code.challenge.method	S256
fe9194f3-05e6-491e-bbc9-9cdd7909a908	post.logout.redirect.uris	+
fe9194f3-05e6-491e-bbc9-9cdd7909a908	pkce.code.challenge.method	S256
c40bb8d7-0215-4550-8dd1-758bb382ac19	post.logout.redirect.uris	+
565f1b69-aa96-4c24-9f10-f5d921f0021e	post.logout.redirect.uris	+
565f1b69-aa96-4c24-9f10-f5d921f0021e	pkce.code.challenge.method	S256
3a4802dd-0117-4eae-969d-d768b001c0ca	post.logout.redirect.uris	+
3a4802dd-0117-4eae-969d-d768b001c0ca	pkce.code.challenge.method	S256
a9ff1805-83cc-4742-96b5-201d1b8c3014	oauth2.device.authorization.grant.enabled	false
a9ff1805-83cc-4742-96b5-201d1b8c3014	oidc.ciba.grant.enabled	false
a9ff1805-83cc-4742-96b5-201d1b8c3014	backchannel.logout.session.required	true
a9ff1805-83cc-4742-96b5-201d1b8c3014	backchannel.logout.revoke.offline.tokens	false
a9ff1805-83cc-4742-96b5-201d1b8c3014	display.on.consent.screen	false
a9ff1805-83cc-4742-96b5-201d1b8c3014	login_theme	keycloak
a9ff1805-83cc-4742-96b5-201d1b8c3014	use.refresh.tokens	false
a9ff1805-83cc-4742-96b5-201d1b8c3014	client_credentials.use_refresh_token	false
a9ff1805-83cc-4742-96b5-201d1b8c3014	token.response.type.bearer.lower-case	false
a9ff1805-83cc-4742-96b5-201d1b8c3014	tls.client.certificate.bound.access.tokens	false
a9ff1805-83cc-4742-96b5-201d1b8c3014	require.pushed.authorization.requests	false
a9ff1805-83cc-4742-96b5-201d1b8c3014	client.use.lightweight.access.token.enabled	false
a9ff1805-83cc-4742-96b5-201d1b8c3014	client.introspection.response.allow.jwt.claim.enabled	false
a9ff1805-83cc-4742-96b5-201d1b8c3014	acr.loa.map	{}
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
dafcbb48-2270-4063-8ae9-761c726cc53d	offline_access	beec1c98-131e-4539-bb19-21867eb81576	OpenID Connect built-in scope: offline_access	openid-connect
b1241b05-3cc2-42f0-ad64-8e284154f84e	role_list	beec1c98-131e-4539-bb19-21867eb81576	SAML role list	saml
44e47a36-d5ce-4786-a838-fe715bd920cd	profile	beec1c98-131e-4539-bb19-21867eb81576	OpenID Connect built-in scope: profile	openid-connect
10db96a7-cdd1-4640-866f-c1fb74376f56	email	beec1c98-131e-4539-bb19-21867eb81576	OpenID Connect built-in scope: email	openid-connect
d40894c3-a63e-414f-b77e-f55e36ec2517	address	beec1c98-131e-4539-bb19-21867eb81576	OpenID Connect built-in scope: address	openid-connect
1c3296d1-1a84-4636-9b77-6b295ce40cd0	phone	beec1c98-131e-4539-bb19-21867eb81576	OpenID Connect built-in scope: phone	openid-connect
2810fac0-79f6-4901-bb80-b4f43d14da21	roles	beec1c98-131e-4539-bb19-21867eb81576	OpenID Connect scope for add user roles to the access token	openid-connect
458d374f-641a-4337-9732-419e2fe4f723	web-origins	beec1c98-131e-4539-bb19-21867eb81576	OpenID Connect scope for add allowed web origins to the access token	openid-connect
0fd78dd8-5193-49c1-9c96-49e9e9514b0e	microprofile-jwt	beec1c98-131e-4539-bb19-21867eb81576	Microprofile - JWT built-in scope	openid-connect
823578f0-ea54-4b92-8bab-7452e561cb62	acr	beec1c98-131e-4539-bb19-21867eb81576	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
10ee36e0-f356-46d9-9e70-0781e7748a08	offline_access	3f237d26-0988-482a-b1c2-14ce1e4b950f	OpenID Connect built-in scope: offline_access	openid-connect
d0bffa34-9e1b-4fde-8d17-94be72dbd245	role_list	3f237d26-0988-482a-b1c2-14ce1e4b950f	SAML role list	saml
90153c46-3b23-4d63-bbc5-9a532f66d2d2	profile	3f237d26-0988-482a-b1c2-14ce1e4b950f	OpenID Connect built-in scope: profile	openid-connect
c7767e38-79ac-46c4-8663-f85874c53b0d	email	3f237d26-0988-482a-b1c2-14ce1e4b950f	OpenID Connect built-in scope: email	openid-connect
19478448-6652-4156-9da5-0553a62f542c	address	3f237d26-0988-482a-b1c2-14ce1e4b950f	OpenID Connect built-in scope: address	openid-connect
0516ee30-7eac-4173-a7e1-ab491ad2da7e	phone	3f237d26-0988-482a-b1c2-14ce1e4b950f	OpenID Connect built-in scope: phone	openid-connect
95efc217-3bef-4624-a9f0-b6cf64db3c68	roles	3f237d26-0988-482a-b1c2-14ce1e4b950f	OpenID Connect scope for add user roles to the access token	openid-connect
8a26ad4d-325f-4896-8e08-88716f5c1416	web-origins	3f237d26-0988-482a-b1c2-14ce1e4b950f	OpenID Connect scope for add allowed web origins to the access token	openid-connect
828ee37b-7285-4c85-9f29-827af6b2f189	microprofile-jwt	3f237d26-0988-482a-b1c2-14ce1e4b950f	Microprofile - JWT built-in scope	openid-connect
af6132c7-bf30-4a86-be75-c3cf0d1b26d2	acr	3f237d26-0988-482a-b1c2-14ce1e4b950f	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
4a12a751-36cc-4225-bee4-024f20c2382f	basic	beec1c98-131e-4539-bb19-21867eb81576	OpenID Connect scope for add all basic claims to the token	openid-connect
c6931fbd-fa93-4bfb-a65d-178745dca064	basic	3f237d26-0988-482a-b1c2-14ce1e4b950f	OpenID Connect scope for add all basic claims to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
dafcbb48-2270-4063-8ae9-761c726cc53d	true	display.on.consent.screen
dafcbb48-2270-4063-8ae9-761c726cc53d	${offlineAccessScopeConsentText}	consent.screen.text
b1241b05-3cc2-42f0-ad64-8e284154f84e	true	display.on.consent.screen
b1241b05-3cc2-42f0-ad64-8e284154f84e	${samlRoleListScopeConsentText}	consent.screen.text
44e47a36-d5ce-4786-a838-fe715bd920cd	true	display.on.consent.screen
44e47a36-d5ce-4786-a838-fe715bd920cd	${profileScopeConsentText}	consent.screen.text
44e47a36-d5ce-4786-a838-fe715bd920cd	true	include.in.token.scope
10db96a7-cdd1-4640-866f-c1fb74376f56	true	display.on.consent.screen
10db96a7-cdd1-4640-866f-c1fb74376f56	${emailScopeConsentText}	consent.screen.text
10db96a7-cdd1-4640-866f-c1fb74376f56	true	include.in.token.scope
d40894c3-a63e-414f-b77e-f55e36ec2517	true	display.on.consent.screen
d40894c3-a63e-414f-b77e-f55e36ec2517	${addressScopeConsentText}	consent.screen.text
d40894c3-a63e-414f-b77e-f55e36ec2517	true	include.in.token.scope
1c3296d1-1a84-4636-9b77-6b295ce40cd0	true	display.on.consent.screen
1c3296d1-1a84-4636-9b77-6b295ce40cd0	${phoneScopeConsentText}	consent.screen.text
1c3296d1-1a84-4636-9b77-6b295ce40cd0	true	include.in.token.scope
2810fac0-79f6-4901-bb80-b4f43d14da21	true	display.on.consent.screen
2810fac0-79f6-4901-bb80-b4f43d14da21	${rolesScopeConsentText}	consent.screen.text
2810fac0-79f6-4901-bb80-b4f43d14da21	false	include.in.token.scope
458d374f-641a-4337-9732-419e2fe4f723	false	display.on.consent.screen
458d374f-641a-4337-9732-419e2fe4f723		consent.screen.text
458d374f-641a-4337-9732-419e2fe4f723	false	include.in.token.scope
0fd78dd8-5193-49c1-9c96-49e9e9514b0e	false	display.on.consent.screen
0fd78dd8-5193-49c1-9c96-49e9e9514b0e	true	include.in.token.scope
823578f0-ea54-4b92-8bab-7452e561cb62	false	display.on.consent.screen
823578f0-ea54-4b92-8bab-7452e561cb62	false	include.in.token.scope
10ee36e0-f356-46d9-9e70-0781e7748a08	true	display.on.consent.screen
10ee36e0-f356-46d9-9e70-0781e7748a08	${offlineAccessScopeConsentText}	consent.screen.text
d0bffa34-9e1b-4fde-8d17-94be72dbd245	true	display.on.consent.screen
d0bffa34-9e1b-4fde-8d17-94be72dbd245	${samlRoleListScopeConsentText}	consent.screen.text
90153c46-3b23-4d63-bbc5-9a532f66d2d2	true	display.on.consent.screen
90153c46-3b23-4d63-bbc5-9a532f66d2d2	${profileScopeConsentText}	consent.screen.text
90153c46-3b23-4d63-bbc5-9a532f66d2d2	true	include.in.token.scope
c7767e38-79ac-46c4-8663-f85874c53b0d	true	display.on.consent.screen
c7767e38-79ac-46c4-8663-f85874c53b0d	${emailScopeConsentText}	consent.screen.text
c7767e38-79ac-46c4-8663-f85874c53b0d	true	include.in.token.scope
19478448-6652-4156-9da5-0553a62f542c	true	display.on.consent.screen
19478448-6652-4156-9da5-0553a62f542c	${addressScopeConsentText}	consent.screen.text
19478448-6652-4156-9da5-0553a62f542c	true	include.in.token.scope
0516ee30-7eac-4173-a7e1-ab491ad2da7e	true	display.on.consent.screen
0516ee30-7eac-4173-a7e1-ab491ad2da7e	${phoneScopeConsentText}	consent.screen.text
0516ee30-7eac-4173-a7e1-ab491ad2da7e	true	include.in.token.scope
95efc217-3bef-4624-a9f0-b6cf64db3c68	true	display.on.consent.screen
95efc217-3bef-4624-a9f0-b6cf64db3c68	${rolesScopeConsentText}	consent.screen.text
95efc217-3bef-4624-a9f0-b6cf64db3c68	false	include.in.token.scope
8a26ad4d-325f-4896-8e08-88716f5c1416	false	display.on.consent.screen
8a26ad4d-325f-4896-8e08-88716f5c1416		consent.screen.text
8a26ad4d-325f-4896-8e08-88716f5c1416	false	include.in.token.scope
828ee37b-7285-4c85-9f29-827af6b2f189	false	display.on.consent.screen
828ee37b-7285-4c85-9f29-827af6b2f189	true	include.in.token.scope
af6132c7-bf30-4a86-be75-c3cf0d1b26d2	false	display.on.consent.screen
af6132c7-bf30-4a86-be75-c3cf0d1b26d2	false	include.in.token.scope
4a12a751-36cc-4225-bee4-024f20c2382f	false	display.on.consent.screen
4a12a751-36cc-4225-bee4-024f20c2382f	false	include.in.token.scope
c6931fbd-fa93-4bfb-a65d-178745dca064	false	display.on.consent.screen
c6931fbd-fa93-4bfb-a65d-178745dca064	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	823578f0-ea54-4b92-8bab-7452e561cb62	t
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	458d374f-641a-4337-9732-419e2fe4f723	t
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	10db96a7-cdd1-4640-866f-c1fb74376f56	t
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	2810fac0-79f6-4901-bb80-b4f43d14da21	t
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	44e47a36-d5ce-4786-a838-fe715bd920cd	t
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	d40894c3-a63e-414f-b77e-f55e36ec2517	f
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	1c3296d1-1a84-4636-9b77-6b295ce40cd0	f
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	0fd78dd8-5193-49c1-9c96-49e9e9514b0e	f
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	dafcbb48-2270-4063-8ae9-761c726cc53d	f
01a41349-3ba2-42c9-ac22-e0ca3825646a	823578f0-ea54-4b92-8bab-7452e561cb62	t
01a41349-3ba2-42c9-ac22-e0ca3825646a	458d374f-641a-4337-9732-419e2fe4f723	t
01a41349-3ba2-42c9-ac22-e0ca3825646a	10db96a7-cdd1-4640-866f-c1fb74376f56	t
01a41349-3ba2-42c9-ac22-e0ca3825646a	2810fac0-79f6-4901-bb80-b4f43d14da21	t
01a41349-3ba2-42c9-ac22-e0ca3825646a	44e47a36-d5ce-4786-a838-fe715bd920cd	t
01a41349-3ba2-42c9-ac22-e0ca3825646a	d40894c3-a63e-414f-b77e-f55e36ec2517	f
01a41349-3ba2-42c9-ac22-e0ca3825646a	1c3296d1-1a84-4636-9b77-6b295ce40cd0	f
01a41349-3ba2-42c9-ac22-e0ca3825646a	0fd78dd8-5193-49c1-9c96-49e9e9514b0e	f
01a41349-3ba2-42c9-ac22-e0ca3825646a	dafcbb48-2270-4063-8ae9-761c726cc53d	f
863892e1-a644-4552-9a3b-2b598f8c95f1	823578f0-ea54-4b92-8bab-7452e561cb62	t
863892e1-a644-4552-9a3b-2b598f8c95f1	458d374f-641a-4337-9732-419e2fe4f723	t
863892e1-a644-4552-9a3b-2b598f8c95f1	10db96a7-cdd1-4640-866f-c1fb74376f56	t
863892e1-a644-4552-9a3b-2b598f8c95f1	2810fac0-79f6-4901-bb80-b4f43d14da21	t
863892e1-a644-4552-9a3b-2b598f8c95f1	44e47a36-d5ce-4786-a838-fe715bd920cd	t
863892e1-a644-4552-9a3b-2b598f8c95f1	d40894c3-a63e-414f-b77e-f55e36ec2517	f
863892e1-a644-4552-9a3b-2b598f8c95f1	1c3296d1-1a84-4636-9b77-6b295ce40cd0	f
863892e1-a644-4552-9a3b-2b598f8c95f1	0fd78dd8-5193-49c1-9c96-49e9e9514b0e	f
863892e1-a644-4552-9a3b-2b598f8c95f1	dafcbb48-2270-4063-8ae9-761c726cc53d	f
71d84a5d-e6df-4c82-beba-37f4f877fca6	823578f0-ea54-4b92-8bab-7452e561cb62	t
71d84a5d-e6df-4c82-beba-37f4f877fca6	458d374f-641a-4337-9732-419e2fe4f723	t
71d84a5d-e6df-4c82-beba-37f4f877fca6	10db96a7-cdd1-4640-866f-c1fb74376f56	t
71d84a5d-e6df-4c82-beba-37f4f877fca6	2810fac0-79f6-4901-bb80-b4f43d14da21	t
71d84a5d-e6df-4c82-beba-37f4f877fca6	44e47a36-d5ce-4786-a838-fe715bd920cd	t
71d84a5d-e6df-4c82-beba-37f4f877fca6	d40894c3-a63e-414f-b77e-f55e36ec2517	f
71d84a5d-e6df-4c82-beba-37f4f877fca6	1c3296d1-1a84-4636-9b77-6b295ce40cd0	f
71d84a5d-e6df-4c82-beba-37f4f877fca6	0fd78dd8-5193-49c1-9c96-49e9e9514b0e	f
71d84a5d-e6df-4c82-beba-37f4f877fca6	dafcbb48-2270-4063-8ae9-761c726cc53d	f
556acc1e-30c6-4cec-bc2d-91c41bf9184b	823578f0-ea54-4b92-8bab-7452e561cb62	t
556acc1e-30c6-4cec-bc2d-91c41bf9184b	458d374f-641a-4337-9732-419e2fe4f723	t
556acc1e-30c6-4cec-bc2d-91c41bf9184b	10db96a7-cdd1-4640-866f-c1fb74376f56	t
556acc1e-30c6-4cec-bc2d-91c41bf9184b	2810fac0-79f6-4901-bb80-b4f43d14da21	t
556acc1e-30c6-4cec-bc2d-91c41bf9184b	44e47a36-d5ce-4786-a838-fe715bd920cd	t
556acc1e-30c6-4cec-bc2d-91c41bf9184b	d40894c3-a63e-414f-b77e-f55e36ec2517	f
556acc1e-30c6-4cec-bc2d-91c41bf9184b	1c3296d1-1a84-4636-9b77-6b295ce40cd0	f
556acc1e-30c6-4cec-bc2d-91c41bf9184b	0fd78dd8-5193-49c1-9c96-49e9e9514b0e	f
556acc1e-30c6-4cec-bc2d-91c41bf9184b	dafcbb48-2270-4063-8ae9-761c726cc53d	f
fe9194f3-05e6-491e-bbc9-9cdd7909a908	823578f0-ea54-4b92-8bab-7452e561cb62	t
fe9194f3-05e6-491e-bbc9-9cdd7909a908	458d374f-641a-4337-9732-419e2fe4f723	t
fe9194f3-05e6-491e-bbc9-9cdd7909a908	10db96a7-cdd1-4640-866f-c1fb74376f56	t
fe9194f3-05e6-491e-bbc9-9cdd7909a908	2810fac0-79f6-4901-bb80-b4f43d14da21	t
fe9194f3-05e6-491e-bbc9-9cdd7909a908	44e47a36-d5ce-4786-a838-fe715bd920cd	t
fe9194f3-05e6-491e-bbc9-9cdd7909a908	d40894c3-a63e-414f-b77e-f55e36ec2517	f
fe9194f3-05e6-491e-bbc9-9cdd7909a908	1c3296d1-1a84-4636-9b77-6b295ce40cd0	f
fe9194f3-05e6-491e-bbc9-9cdd7909a908	0fd78dd8-5193-49c1-9c96-49e9e9514b0e	f
fe9194f3-05e6-491e-bbc9-9cdd7909a908	dafcbb48-2270-4063-8ae9-761c726cc53d	f
c40bb8d7-0215-4550-8dd1-758bb382ac19	90153c46-3b23-4d63-bbc5-9a532f66d2d2	t
c40bb8d7-0215-4550-8dd1-758bb382ac19	af6132c7-bf30-4a86-be75-c3cf0d1b26d2	t
c40bb8d7-0215-4550-8dd1-758bb382ac19	95efc217-3bef-4624-a9f0-b6cf64db3c68	t
c40bb8d7-0215-4550-8dd1-758bb382ac19	8a26ad4d-325f-4896-8e08-88716f5c1416	t
c40bb8d7-0215-4550-8dd1-758bb382ac19	c7767e38-79ac-46c4-8663-f85874c53b0d	t
c40bb8d7-0215-4550-8dd1-758bb382ac19	10ee36e0-f356-46d9-9e70-0781e7748a08	f
c40bb8d7-0215-4550-8dd1-758bb382ac19	19478448-6652-4156-9da5-0553a62f542c	f
c40bb8d7-0215-4550-8dd1-758bb382ac19	0516ee30-7eac-4173-a7e1-ab491ad2da7e	f
c40bb8d7-0215-4550-8dd1-758bb382ac19	828ee37b-7285-4c85-9f29-827af6b2f189	f
565f1b69-aa96-4c24-9f10-f5d921f0021e	90153c46-3b23-4d63-bbc5-9a532f66d2d2	t
565f1b69-aa96-4c24-9f10-f5d921f0021e	af6132c7-bf30-4a86-be75-c3cf0d1b26d2	t
565f1b69-aa96-4c24-9f10-f5d921f0021e	95efc217-3bef-4624-a9f0-b6cf64db3c68	t
565f1b69-aa96-4c24-9f10-f5d921f0021e	8a26ad4d-325f-4896-8e08-88716f5c1416	t
565f1b69-aa96-4c24-9f10-f5d921f0021e	c7767e38-79ac-46c4-8663-f85874c53b0d	t
565f1b69-aa96-4c24-9f10-f5d921f0021e	10ee36e0-f356-46d9-9e70-0781e7748a08	f
565f1b69-aa96-4c24-9f10-f5d921f0021e	19478448-6652-4156-9da5-0553a62f542c	f
565f1b69-aa96-4c24-9f10-f5d921f0021e	0516ee30-7eac-4173-a7e1-ab491ad2da7e	f
565f1b69-aa96-4c24-9f10-f5d921f0021e	828ee37b-7285-4c85-9f29-827af6b2f189	f
cc775481-ca96-4f0e-a085-d8ea11a29d0a	90153c46-3b23-4d63-bbc5-9a532f66d2d2	t
cc775481-ca96-4f0e-a085-d8ea11a29d0a	af6132c7-bf30-4a86-be75-c3cf0d1b26d2	t
cc775481-ca96-4f0e-a085-d8ea11a29d0a	95efc217-3bef-4624-a9f0-b6cf64db3c68	t
cc775481-ca96-4f0e-a085-d8ea11a29d0a	8a26ad4d-325f-4896-8e08-88716f5c1416	t
cc775481-ca96-4f0e-a085-d8ea11a29d0a	c7767e38-79ac-46c4-8663-f85874c53b0d	t
cc775481-ca96-4f0e-a085-d8ea11a29d0a	10ee36e0-f356-46d9-9e70-0781e7748a08	f
cc775481-ca96-4f0e-a085-d8ea11a29d0a	19478448-6652-4156-9da5-0553a62f542c	f
cc775481-ca96-4f0e-a085-d8ea11a29d0a	0516ee30-7eac-4173-a7e1-ab491ad2da7e	f
cc775481-ca96-4f0e-a085-d8ea11a29d0a	828ee37b-7285-4c85-9f29-827af6b2f189	f
31419541-a326-4108-9e0a-a76318440af7	90153c46-3b23-4d63-bbc5-9a532f66d2d2	t
31419541-a326-4108-9e0a-a76318440af7	af6132c7-bf30-4a86-be75-c3cf0d1b26d2	t
31419541-a326-4108-9e0a-a76318440af7	95efc217-3bef-4624-a9f0-b6cf64db3c68	t
31419541-a326-4108-9e0a-a76318440af7	8a26ad4d-325f-4896-8e08-88716f5c1416	t
31419541-a326-4108-9e0a-a76318440af7	c7767e38-79ac-46c4-8663-f85874c53b0d	t
31419541-a326-4108-9e0a-a76318440af7	10ee36e0-f356-46d9-9e70-0781e7748a08	f
31419541-a326-4108-9e0a-a76318440af7	19478448-6652-4156-9da5-0553a62f542c	f
31419541-a326-4108-9e0a-a76318440af7	0516ee30-7eac-4173-a7e1-ab491ad2da7e	f
31419541-a326-4108-9e0a-a76318440af7	828ee37b-7285-4c85-9f29-827af6b2f189	f
b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	90153c46-3b23-4d63-bbc5-9a532f66d2d2	t
b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	af6132c7-bf30-4a86-be75-c3cf0d1b26d2	t
b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	95efc217-3bef-4624-a9f0-b6cf64db3c68	t
b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	8a26ad4d-325f-4896-8e08-88716f5c1416	t
b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	c7767e38-79ac-46c4-8663-f85874c53b0d	t
b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	10ee36e0-f356-46d9-9e70-0781e7748a08	f
b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	19478448-6652-4156-9da5-0553a62f542c	f
b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	0516ee30-7eac-4173-a7e1-ab491ad2da7e	f
b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	828ee37b-7285-4c85-9f29-827af6b2f189	f
3a4802dd-0117-4eae-969d-d768b001c0ca	90153c46-3b23-4d63-bbc5-9a532f66d2d2	t
3a4802dd-0117-4eae-969d-d768b001c0ca	af6132c7-bf30-4a86-be75-c3cf0d1b26d2	t
3a4802dd-0117-4eae-969d-d768b001c0ca	95efc217-3bef-4624-a9f0-b6cf64db3c68	t
3a4802dd-0117-4eae-969d-d768b001c0ca	8a26ad4d-325f-4896-8e08-88716f5c1416	t
3a4802dd-0117-4eae-969d-d768b001c0ca	c7767e38-79ac-46c4-8663-f85874c53b0d	t
3a4802dd-0117-4eae-969d-d768b001c0ca	10ee36e0-f356-46d9-9e70-0781e7748a08	f
3a4802dd-0117-4eae-969d-d768b001c0ca	19478448-6652-4156-9da5-0553a62f542c	f
3a4802dd-0117-4eae-969d-d768b001c0ca	0516ee30-7eac-4173-a7e1-ab491ad2da7e	f
3a4802dd-0117-4eae-969d-d768b001c0ca	828ee37b-7285-4c85-9f29-827af6b2f189	f
a9ff1805-83cc-4742-96b5-201d1b8c3014	90153c46-3b23-4d63-bbc5-9a532f66d2d2	t
a9ff1805-83cc-4742-96b5-201d1b8c3014	af6132c7-bf30-4a86-be75-c3cf0d1b26d2	t
a9ff1805-83cc-4742-96b5-201d1b8c3014	95efc217-3bef-4624-a9f0-b6cf64db3c68	t
a9ff1805-83cc-4742-96b5-201d1b8c3014	8a26ad4d-325f-4896-8e08-88716f5c1416	t
a9ff1805-83cc-4742-96b5-201d1b8c3014	c7767e38-79ac-46c4-8663-f85874c53b0d	t
a9ff1805-83cc-4742-96b5-201d1b8c3014	10ee36e0-f356-46d9-9e70-0781e7748a08	f
a9ff1805-83cc-4742-96b5-201d1b8c3014	19478448-6652-4156-9da5-0553a62f542c	f
a9ff1805-83cc-4742-96b5-201d1b8c3014	0516ee30-7eac-4173-a7e1-ab491ad2da7e	f
a9ff1805-83cc-4742-96b5-201d1b8c3014	828ee37b-7285-4c85-9f29-827af6b2f189	f
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	4a12a751-36cc-4225-bee4-024f20c2382f	t
01a41349-3ba2-42c9-ac22-e0ca3825646a	4a12a751-36cc-4225-bee4-024f20c2382f	t
fe9194f3-05e6-491e-bbc9-9cdd7909a908	4a12a751-36cc-4225-bee4-024f20c2382f	t
863892e1-a644-4552-9a3b-2b598f8c95f1	4a12a751-36cc-4225-bee4-024f20c2382f	t
c40bb8d7-0215-4550-8dd1-758bb382ac19	c6931fbd-fa93-4bfb-a65d-178745dca064	t
565f1b69-aa96-4c24-9f10-f5d921f0021e	c6931fbd-fa93-4bfb-a65d-178745dca064	t
3a4802dd-0117-4eae-969d-d768b001c0ca	c6931fbd-fa93-4bfb-a65d-178745dca064	t
cc775481-ca96-4f0e-a085-d8ea11a29d0a	c6931fbd-fa93-4bfb-a65d-178745dca064	t
a9ff1805-83cc-4742-96b5-201d1b8c3014	c6931fbd-fa93-4bfb-a65d-178745dca064	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
dafcbb48-2270-4063-8ae9-761c726cc53d	43c69691-5960-48c7-9587-81efadfa7eff
10ee36e0-f356-46d9-9e70-0781e7748a08	a6f65cb7-29ba-48a1-a3b2-0f9e1c9ed89c
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
4ae51544-a718-4c66-8bad-29a6db12937a	Trusted Hosts	beec1c98-131e-4539-bb19-21867eb81576	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	beec1c98-131e-4539-bb19-21867eb81576	anonymous
339a9da5-7341-40a4-8c4d-04f041f5e863	Consent Required	beec1c98-131e-4539-bb19-21867eb81576	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	beec1c98-131e-4539-bb19-21867eb81576	anonymous
2d341f18-a421-49d4-98cf-7e6a0bfeb023	Full Scope Disabled	beec1c98-131e-4539-bb19-21867eb81576	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	beec1c98-131e-4539-bb19-21867eb81576	anonymous
1ac9400c-8fbf-4392-bda8-ae3b39bb10f5	Max Clients Limit	beec1c98-131e-4539-bb19-21867eb81576	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	beec1c98-131e-4539-bb19-21867eb81576	anonymous
52b0f326-6e63-4302-bfe6-c71a351572ad	Allowed Protocol Mapper Types	beec1c98-131e-4539-bb19-21867eb81576	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	beec1c98-131e-4539-bb19-21867eb81576	anonymous
c20148cf-1cf6-49a1-b7dd-783dd92ddb2c	Allowed Client Scopes	beec1c98-131e-4539-bb19-21867eb81576	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	beec1c98-131e-4539-bb19-21867eb81576	anonymous
926e112c-2dfe-4332-967f-6bd2bddf3af4	Allowed Protocol Mapper Types	beec1c98-131e-4539-bb19-21867eb81576	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	beec1c98-131e-4539-bb19-21867eb81576	authenticated
38273329-39c0-49b3-820a-4b8b718cbb7c	Allowed Client Scopes	beec1c98-131e-4539-bb19-21867eb81576	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	beec1c98-131e-4539-bb19-21867eb81576	authenticated
27820a43-f79e-46ca-aeb8-610818bcd974	rsa-generated	beec1c98-131e-4539-bb19-21867eb81576	rsa-generated	org.keycloak.keys.KeyProvider	beec1c98-131e-4539-bb19-21867eb81576	\N
a9221e16-b75f-403a-ac67-ac7d6e4ae332	rsa-enc-generated	beec1c98-131e-4539-bb19-21867eb81576	rsa-enc-generated	org.keycloak.keys.KeyProvider	beec1c98-131e-4539-bb19-21867eb81576	\N
824ca3ea-85ef-48ee-a375-cdca2a148f2a	hmac-generated	beec1c98-131e-4539-bb19-21867eb81576	hmac-generated	org.keycloak.keys.KeyProvider	beec1c98-131e-4539-bb19-21867eb81576	\N
7d3dc817-4504-404b-b959-0fc44e1a86be	aes-generated	beec1c98-131e-4539-bb19-21867eb81576	aes-generated	org.keycloak.keys.KeyProvider	beec1c98-131e-4539-bb19-21867eb81576	\N
b164d659-61a1-40ec-a489-6eb0e03f94eb	rsa-generated	3f237d26-0988-482a-b1c2-14ce1e4b950f	rsa-generated	org.keycloak.keys.KeyProvider	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N
cf8c6e0f-996c-4879-917c-e2b16c8b12ac	rsa-enc-generated	3f237d26-0988-482a-b1c2-14ce1e4b950f	rsa-enc-generated	org.keycloak.keys.KeyProvider	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N
fefa439f-9aa6-4a5b-b3fc-51f187c664c3	hmac-generated	3f237d26-0988-482a-b1c2-14ce1e4b950f	hmac-generated	org.keycloak.keys.KeyProvider	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N
a575cd37-7a3d-40fd-9bda-8d3f8313fdb5	aes-generated	3f237d26-0988-482a-b1c2-14ce1e4b950f	aes-generated	org.keycloak.keys.KeyProvider	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N
39bf8df6-b2b4-4166-b88d-90f78e2b6649	Trusted Hosts	3f237d26-0988-482a-b1c2-14ce1e4b950f	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3f237d26-0988-482a-b1c2-14ce1e4b950f	anonymous
22646591-eb14-4ca6-bdca-4abbd2e539cc	Consent Required	3f237d26-0988-482a-b1c2-14ce1e4b950f	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3f237d26-0988-482a-b1c2-14ce1e4b950f	anonymous
d8157223-0808-4ac4-85fa-c63e4a54e779	Full Scope Disabled	3f237d26-0988-482a-b1c2-14ce1e4b950f	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3f237d26-0988-482a-b1c2-14ce1e4b950f	anonymous
b99c5c83-f759-499b-8816-b03759b72883	Max Clients Limit	3f237d26-0988-482a-b1c2-14ce1e4b950f	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3f237d26-0988-482a-b1c2-14ce1e4b950f	anonymous
fb86a35c-e475-4260-9a32-92d3abe9e77c	Allowed Protocol Mapper Types	3f237d26-0988-482a-b1c2-14ce1e4b950f	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3f237d26-0988-482a-b1c2-14ce1e4b950f	anonymous
64e23165-2b0a-4c0f-ba57-97a03440396f	Allowed Client Scopes	3f237d26-0988-482a-b1c2-14ce1e4b950f	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3f237d26-0988-482a-b1c2-14ce1e4b950f	anonymous
d5d40bc2-9142-4958-97c4-36502144332c	Allowed Protocol Mapper Types	3f237d26-0988-482a-b1c2-14ce1e4b950f	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3f237d26-0988-482a-b1c2-14ce1e4b950f	authenticated
dcccca4a-159d-40a3-a94c-abbcfcba49eb	Allowed Client Scopes	3f237d26-0988-482a-b1c2-14ce1e4b950f	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3f237d26-0988-482a-b1c2-14ce1e4b950f	authenticated
d4833b98-9d8f-420a-9373-a60f54bee46c	\N	beec1c98-131e-4539-bb19-21867eb81576	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	beec1c98-131e-4539-bb19-21867eb81576	\N
b9e258ce-62da-48e5-94ee-ad895370a350	hmac-generated-hs512	beec1c98-131e-4539-bb19-21867eb81576	hmac-generated	org.keycloak.keys.KeyProvider	beec1c98-131e-4539-bb19-21867eb81576	\N
fb71cb13-7288-4116-80da-beae84c56436	\N	3f237d26-0988-482a-b1c2-14ce1e4b950f	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N
c6535b5e-d169-4bbd-a4c0-d5957b01f692	hmac-generated-hs512	3f237d26-0988-482a-b1c2-14ce1e4b950f	hmac-generated	org.keycloak.keys.KeyProvider	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
d156e62b-61a3-4b43-8573-922132d192f6	c20148cf-1cf6-49a1-b7dd-783dd92ddb2c	allow-default-scopes	true
02c1dac3-7a9b-41ca-a58e-0270413097b4	4ae51544-a718-4c66-8bad-29a6db12937a	client-uris-must-match	true
52156f02-1027-42b2-9fa2-9a1612bf7cfe	4ae51544-a718-4c66-8bad-29a6db12937a	host-sending-registration-request-must-match	true
96fecacb-0002-4d6c-884a-9a1ff71629f1	926e112c-2dfe-4332-967f-6bd2bddf3af4	allowed-protocol-mapper-types	oidc-full-name-mapper
7a3ae6d4-94fd-47ba-bed7-6690f500983e	926e112c-2dfe-4332-967f-6bd2bddf3af4	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b4a36e83-9162-4b0a-8b49-2494f2b489e6	926e112c-2dfe-4332-967f-6bd2bddf3af4	allowed-protocol-mapper-types	saml-role-list-mapper
d880e826-f2b7-40c1-97f5-cea8f0ecc755	926e112c-2dfe-4332-967f-6bd2bddf3af4	allowed-protocol-mapper-types	saml-user-attribute-mapper
e945767b-6144-4483-8806-009f41d9337e	926e112c-2dfe-4332-967f-6bd2bddf3af4	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
41c6a8e0-9b20-463c-9cab-a1ff815264f3	926e112c-2dfe-4332-967f-6bd2bddf3af4	allowed-protocol-mapper-types	saml-user-property-mapper
bebc225b-b463-420b-9e75-0840b7a92ee6	926e112c-2dfe-4332-967f-6bd2bddf3af4	allowed-protocol-mapper-types	oidc-address-mapper
391771e9-11c0-4e5e-a4e9-60cf9664c766	926e112c-2dfe-4332-967f-6bd2bddf3af4	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
294bf3e5-764c-4e63-9cf4-0ab75815a743	38273329-39c0-49b3-820a-4b8b718cbb7c	allow-default-scopes	true
dbeae339-0834-4838-948b-87d9370e0138	1ac9400c-8fbf-4392-bda8-ae3b39bb10f5	max-clients	200
9e4f700b-c4da-47f0-905b-3fb527f44492	52b0f326-6e63-4302-bfe6-c71a351572ad	allowed-protocol-mapper-types	oidc-full-name-mapper
62305d34-85be-49b3-86a2-69d44442b9b8	52b0f326-6e63-4302-bfe6-c71a351572ad	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
96222d4b-7817-4e01-a67b-ce38002cc22f	52b0f326-6e63-4302-bfe6-c71a351572ad	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
daf052d0-b222-4964-8123-193efb1f0f09	52b0f326-6e63-4302-bfe6-c71a351572ad	allowed-protocol-mapper-types	oidc-address-mapper
b88c19aa-9b66-471e-9249-e5f201b9c42d	52b0f326-6e63-4302-bfe6-c71a351572ad	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
160ea5e5-dc68-4602-af70-384e6ab84ca6	52b0f326-6e63-4302-bfe6-c71a351572ad	allowed-protocol-mapper-types	saml-user-attribute-mapper
82494c57-1925-40dc-b13c-3db0dfaf8475	52b0f326-6e63-4302-bfe6-c71a351572ad	allowed-protocol-mapper-types	saml-user-property-mapper
ec8dc3af-9154-4419-8464-a8ff43941eaa	52b0f326-6e63-4302-bfe6-c71a351572ad	allowed-protocol-mapper-types	saml-role-list-mapper
d6001ba0-a75c-4c61-aa62-3928b3888d6c	824ca3ea-85ef-48ee-a375-cdca2a148f2a	kid	d55eb186-5868-4156-8b14-0b15359b77ef
0df31504-cf67-4106-a049-b16a6154eb1c	824ca3ea-85ef-48ee-a375-cdca2a148f2a	algorithm	HS256
07bca95f-43dd-44c8-8320-dd86a52d73dc	824ca3ea-85ef-48ee-a375-cdca2a148f2a	secret	WDKhym-k8MRL-I1TTCzqi18Xqag1h0_OLQPPLbO4sUg69tTq2nD9RoP5kOroRuUwVEHogqTuTV6e-CZHzC1TSg
080f0dcf-bb9c-48b5-bd2e-a3a15354325d	824ca3ea-85ef-48ee-a375-cdca2a148f2a	priority	100
8590c69a-e090-42cc-8d6b-714e332ab8cb	7d3dc817-4504-404b-b959-0fc44e1a86be	priority	100
0cddc05d-7b7e-4cfb-aaa8-549e8883344e	7d3dc817-4504-404b-b959-0fc44e1a86be	kid	24f90b7a-47b6-4635-85b3-c6ac3d83fea5
4ab69cbb-1e4b-40b0-8831-232328703fe6	7d3dc817-4504-404b-b959-0fc44e1a86be	secret	puXffVNEgaIR88uGD_WHUw
80fe8ac4-0bbe-4830-a846-875cdea858f9	a9221e16-b75f-403a-ac67-ac7d6e4ae332	algorithm	RSA-OAEP
16005596-01d7-485c-bf20-aac1b0c3f1f2	a9221e16-b75f-403a-ac67-ac7d6e4ae332	certificate	MIICmzCCAYMCBgGQoeXnLjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNzExMTMwMzM3WhcNMzQwNzExMTMwNTE3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7iQoAuUtzKTF0QB/84Bp6GrEC518zP6cRiSVdfNWQpC1jqIhdfEvU4WnP07co8dEatv3wfkeyckpGtZlt7QuRFMHQreo54/GrIGfuwVXEz4/F1tm2QKb3yChlwkYYPkMXrCa/qxoSUfT/j4LnRkjPYtIlGSUU6uioOSFwiXRf5ANIf0cP5ZqGzLtLqjYGlSVO0oKwsGY8seExyQf72vZQERzgwryALR6mqb4y5CcZ3BcjDjc5LA/8mhzggw+wZEVZfRTUWsXLa6Yde3kpZeNo0pOLsrO3Tda4aM4LPjHIGbbfPc+GUuBDj/ptAu8EnVlnF3XiaIO3/5iLQzouPNQPAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACRFSYGAdhOzY1JJITgj4l4SsIlS+ubEqg0JJfJzJBdq07FWpGNANBHkn29jn8xoDbQyDPhc1Ev02p00f4VvXCP7AW5l/W32mvJ4Z0TnFwv8lci7tgQ86zlk8d9MYB8xz9LpDKAYvTln4q/ebCOG4/9VS5Lz85jIXDZBTByD2S015DGpIxAC9ZZx78PdRhF0k4wFwIgetvYYiYW9cvjCTIA/iu5zxhzZ5ld16oNpMdpQrcr2qLMOW50MVia/zSSx2pTrTb7EBw5EyugE0t3Bili+m0G1ybHwrlmaTfY24baozNCQjG8W2hXYmZ4jz4YVnSed80NUruLH9bs8kiaXij4=
4bdabaad-f2dc-4fcd-87e7-6715db78e6ab	a9221e16-b75f-403a-ac67-ac7d6e4ae332	keyUse	ENC
ed45b9c5-4823-42b2-8112-4dd3677c3015	a9221e16-b75f-403a-ac67-ac7d6e4ae332	priority	100
b82ea808-1072-474a-a984-cb61f99fc497	a9221e16-b75f-403a-ac67-ac7d6e4ae332	privateKey	MIIEowIBAAKCAQEAu4kKALlLcykxdEAf/OAaehqxAudfMz+nEYklXXzVkKQtY6iIXXxL1OFpz9O3KPHRGrb98H5HsnJKRrWZbe0LkRTB0K3qOePxqyBn7sFVxM+PxdbZtkCm98goZcJGGD5DF6wmv6saElH0/4+C50ZIz2LSJRklFOroqDkhcIl0X+QDSH9HD+Wahsy7S6o2BpUlTtKCsLBmPLHhMckH+9r2UBEc4MK8gC0epqm+MuQnGdwXIw43OSwP/Joc4IMPsGRFWX0U1FrFy2umHXt5KWXjaNKTi7Kzt03WuGjOCz4xyBm23z3PhlLgQ4/6bQLvBJ1ZZxd14miDt/+Yi0M6LjzUDwIDAQABAoIBABAM/MCuxfDk09lAdccVwokJ3iBCqki/csP9n3zpZs6lkUby0T0NxYsXrI/qQxvA2qX1MeB9W73qVJt0W93nMx1nOpFq7ohRj0kXZx3YXp1k1cgtM961Q4p4j1CU+J0xkwTPKf/Z8Ut5HUV+7x7D9WOz8GAsJJrY4jHSYJ96UZi1TIQG29aYtoXVVR92rvXBpidCncMzB71MtJHjppmrttFjmxxroQIhrqrIybh0VRMCdvr18rde0++hixfQP7fQRxf4gyQWB0qr5indGPFOZWlGry5E4EOZ8XwmFNYkPNvL7SmKb0L2Xq7II5wV2G7HSxYDh4bW1Z00Zac6VsIGLIkCgYEA5nCjadyfIpv/lXrXLR6/IjT/AIcMOre2jV+xjURX6paZmVjjJXsgOvrnhfz2iGruetBwUKx1YayYrQpFClW+g1+z0xtussNqKgJUtuIrKPTFX5QwFm1oCPxkTNsc4hTn+22sIstVjc8zvf01ZKmywtQBWTqEq8bksut3MU7rUAcCgYEA0FYebY1+qRd7Q8O8EPyPGZUf2tVkeaOtSDde/z9ClJXTaLlSDqbo9wf/kQl6/qfEwY2El8ybY8Epizg1DSH+ZtCF7PcVSOwoLfGjTY1DWhXJSSFpkHrtjQNo+xirAYSPeFzQVttN0Oo1tq/zjL7dRIIYd9eTEjq4oFCXAn0ySbkCgYAd4zYOoOKy5nC7vnbyDy7TDPSV6O4ZH4K5y1OH8vlEH8xEK1cqoVGI1Mn6gtim0NelbitjCzseM/iJWO+ja4OOHneAReqRnO7EDBFYtvTKFxUSVHH4NrBrmfCYV0Ljv7pmzc6ppJ2wCtO3LIQkTi41PrH+FKzoap925TtMVeQHOQKBgCgXqptik3Fu92W/ET4jnFZMAGlYj5FpEjvHjByKzAFUI+8PWt8+964yd9gtfuHq305wMYgU9AJqddg45Ny2IgMfNea4VfxGliThT4/pE4EOmEHekDYhsf1lHprT0HTmUcXT9rQAWCVQLS4PBkubn3FDp/nIHqFvc4BGggkUlszhAoGBAKYR26yRWDLgay8dYnIXy5B3Fid5fqwvXfBaH3EQcpSJc9ULpmtLYItXvpbqXXC4Dp3FOhVIBEwbipNez3QR41km8ACTvADpTlpcLKxT2x8VpmPYtoDaDUNB7XYyB2KtXNCPJ5YeygBDBNWbrAhruOqeXR3oQGmlg85pbeiMcGWo
470b745f-9e1f-4137-8740-550e8ee698d1	27820a43-f79e-46ca-aeb8-610818bcd974	certificate	MIICmzCCAYMCBgGQoeXmqDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNzExMTMwMzM2WhcNMzQwNzExMTMwNTE2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCgSgCWsaiAyNIIg/qgemwF/dyJGbL9oyMHXFWJklqaw+4aurkrcu4j9+yXF0cHCBh9mq98D6HV5JzFC13Z9zkSt0/iyYAoQ/hyNlVh3TjEcEWfmnYqIKXeVEkumDWWrv50pGokL34PH6aYsCGBC55oGxhzL4+LOSEedvvugviFzv1/m2Go1UXdohwIOIgAkB+oVJ+xNtZn5dyHsFp8eP1R7jFl3fS23Anej8fVvhkIrW2/cWMaGugjXd6ELF5xEVr3WFlyhlu4lBWO2fAMkYboBz4qiRXNV8grXeXjsYHPIDJVd3j2omkV1CVpvxba2PoPbXlJnTdZkYXHrF75RJE3AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIJXxsCIbCRSlMQTZFFh9Bx1chO2MqFugRyb22bckjDhewxTmwdoxCcx9EYOJdyI0iyxkou/16cnDn9QpTa2/O6WLAhJovzsbc591RBQay///s1UfwkC48lzqkeYR+FOEbd0oPPkdTo3o4hqTyRCRvJtIgl9MHNAgBq1JUKrE/YdQQ8sq6fo+M1psGMLuo3Nb14TjvT8KtBNbWAb8q1IO8R2/+MTr6CqiA1+dvdCKYxW8+Dkv2CXtTd5e9MN3ujOePHCYLC0XmutI8D0bB8ewNWZwBoNA4aeqKT1fYJGylFNZnuKCGN7+G2JQ4vv5u+SeqrNe1QdqxtXEc60W94W1z0=
6747c0de-9b9f-483f-8c8a-357443ac5a6f	27820a43-f79e-46ca-aeb8-610818bcd974	priority	100
9f625f29-aedc-40c7-ad99-309842f2cfbe	27820a43-f79e-46ca-aeb8-610818bcd974	privateKey	MIIEowIBAAKCAQEAoEoAlrGogMjSCIP6oHpsBf3ciRmy/aMjB1xViZJamsPuGrq5K3LuI/fslxdHBwgYfZqvfA+h1eScxQtd2fc5ErdP4smAKEP4cjZVYd04xHBFn5p2KiCl3lRJLpg1lq7+dKRqJC9+Dx+mmLAhgQueaBsYcy+PizkhHnb77oL4hc79f5thqNVF3aIcCDiIAJAfqFSfsTbWZ+Xch7BafHj9Ue4xZd30ttwJ3o/H1b4ZCK1tv3FjGhroI13ehCxecRFa91hZcoZbuJQVjtnwDJGG6Ac+KokVzVfIK13l47GBzyAyVXd49qJpFdQlab8W2tj6D215SZ03WZGFx6xe+USRNwIDAQABAoIBAE6CIIquxqUZd4JTPlkGzU0b+74tF7XShzAuQfkpdXZTXBa8eUC2QLzeTIPuk0v246P1tVkTAQXWPRDoEdZWGB66KYcfgcV3EUPDqAtQguL4SKm1SoY0ynk8mEGZrLm6yYgRFanWlyxKKNulfSuLKNG937pfQ7QBzd5xkdDPVnGW255swERN/Y8KBXcYikcCCnchtRwIB9loxJmGbJSwtRaBiOOJdlowXf2MliWA6j+QNRreGcou4/frVEmH4JI1AOkAd1pqfpgnGlcsj6p8DyYGjJe+Fm15paVN3+rd8+AsOKPXC/Y/vJjZQl2sl67JwH2OllA3jroVh+81PDcANSUCgYEA0JzoONTt7lpwm9ZuwsBZfkjJEtf2QmgQNGjOfT/7zEoSKYYtLbqgoj5Rg1+G5kPrdvFLDbEq6q4+bopsVA1c+TxCW6opkQRKiXdI/fLowPzN4YzmFJq976I9nIHHnPh6j4d5jX98H4qln3wo7lXgMWoXjLQRUWuvctQaV0yS6AMCgYEAxLMBU6+gXRdEr2D7O9VvU4emqfjgdkGd+1Tg0ZBMUj3h7ePXws4ZBbL47fEsPQZds9Y/NgVv+ZM6EKERjuy407ZckKepT0+NCpq+O/I9cyO6D4d0zY/Mb4GxbPMv3cuc0Blthbkx0hYgeR7Ua/yRhs/kBPU75jwykU397lwCbb0CgYB3qQkrUDgKeKYPPbjazSqIXYe431fKT5a7+UI4ZfMxA2vXlbdke6CYb9ah3LGsc1klKNM8T1umsbvt/EiXDfM+o2oM2lZtcGCw6VNdF3CbAme18PQo7Xn1csKUe3zcdUsX+UWn/HBeR1EpYja4P1oR/iDz/HXSlkpVO4TAfpPlsQKBgGCWGZ+zTMaJZ3PK5nLyElFs+dza1bWb8Ox6OE8PUTrNIkTDLa59r3HJ+Uw1sehhWN+246EuOFbQAaIqxUluWi+zi26Ita25PWOoqqMbByujrnhzplpOMy/J+oqqO6Xolp7k7Y/NaXZk4Rs4lUxVYExXhvscRIaApsANERTbX2HtAoGBAJdnAg8YM+NzPwJXpuNrl8Vk921dXNY8i8DPCD0KUYoq7ASsDH0xSiOM80LAUJex7YWR9UolE12T/SWWC/5IBAZZzJTOPQpJrOe+LPNq7yGvLmTuUt5v6cdX+HOl7n5LpuT0ZtTGQcfg8guqZqsjjLi56unBsQHf/wskHIh/zFaq
fe6a4069-18c9-4326-b995-087b6964a22f	27820a43-f79e-46ca-aeb8-610818bcd974	keyUse	SIG
6e07139c-f66a-45dc-a7ec-f819e24317dc	cf8c6e0f-996c-4879-917c-e2b16c8b12ac	certificate	MIICpzCCAY8CBgGQoexsDTANBgkqhkiG9w0BAQsFADAXMRUwEwYDVQQDDAxCaWxhbkNhcmJvbmUwHhcNMjQwNzExMTMxMDQ0WhcNMzQwNzExMTMxMjI0WjAXMRUwEwYDVQQDDAxCaWxhbkNhcmJvbmUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCRenhwfwL7CfNSeDHZGSHxmN6FfM7hmjZUXh+v9Bb8kZQjQnE3aOmm3nvETVhheS4Oa2hdCO3diEhniIgvroZBAKLRcQ7uTuu15Bqu1JrMTKrSohjmNbsqsHTAvYshGJozwSJcr0qmhZOOpG+luQZCr99Y1Ym070pzNCXlEeM78wtSWHglA8T8Dr51HIN8NnO2IVzaU5MNzpn/fs9fH4jXnwNgfEAdc22IJWoAkRDVPwyGj11zp5eQgvCFASBX5NH6nVgd7eseqyGWyXcxicnYdLNnt+1TFU34N3Fo4XV0lU7yfc/9nKw12q7nTveu60o98n27TsgJkNnQz/DFrCVZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFxOxjnzoCd4m1hplCKUgWVIgoZD08pxbXkCPRBTUiMzLKakqwM6hK8bVRpVHZLzC3I9t2EhOPCgRK7dE4D1YSy1RPXJtoDoxme8Kj5rKtrxVbCBFg1icbMVeLEiOMoWArYQb2H46y/HBMU73E6mp5a94lrhGqYYWwYlon/XRJapYXdiGhqlifqzzvFh3PoB060XJWCeQG27k1VovQs+w/CdUCUydkcPGRmBabD6rkNQSCLndP3DLDDGozptFLSONGuz/hgs+mtvHEcjJSLGlLlACgZ1lCpgyK7+VU/fKMFifx1lsBXUUgajWsW1jfSbGDLrEjxopieTGdWOnUxJG9A=
21ac0a72-4241-40f0-8643-91da68209225	cf8c6e0f-996c-4879-917c-e2b16c8b12ac	priority	100
37947836-b384-441a-a335-7b18a57a0e10	cf8c6e0f-996c-4879-917c-e2b16c8b12ac	algorithm	RSA-OAEP
b7748cf0-cf49-41ba-adc5-cbc676775dc1	cf8c6e0f-996c-4879-917c-e2b16c8b12ac	privateKey	MIIEogIBAAKCAQEAkXp4cH8C+wnzUngx2Rkh8ZjehXzO4Zo2VF4fr/QW/JGUI0JxN2jppt57xE1YYXkuDmtoXQjt3YhIZ4iIL66GQQCi0XEO7k7rteQartSazEyq0qIY5jW7KrB0wL2LIRiaM8EiXK9KpoWTjqRvpbkGQq/fWNWJtO9KczQl5RHjO/MLUlh4JQPE/A6+dRyDfDZztiFc2lOTDc6Z/37PXx+I158DYHxAHXNtiCVqAJEQ1T8Mho9dc6eXkILwhQEgV+TR+p1YHe3rHqshlsl3MYnJ2HSzZ7ftUxVN+DdxaOF1dJVO8n3P/ZysNdqu5073rutKPfJ9u07ICZDZ0M/wxawlWQIDAQABAoIBAANxqktDfn8R77w6kzeIBEkzbMUtPLqTi4i4x7hDJ44oJiElkAeXSLzGFJkDmb2JAGGgAlL9hKATe19UGKFEWPJOAQzDR+61WJgwQ79y0g1XHU4qPzun9vvePI1Zj2MjsXbbMiSOk85YaDNeyjPaqv7GKhvwxjdN2O3cRK9lGoOPRsYJm2a6rnmCp5Yq8P3fipT2CcZ3aev81Otb22ZT7++G1WhZCf0qT68iP8dOboUK7vaLvDAmnaVmPzRVap+IBqfQosx9Mo8SfjB4/AFzXz7wPWj6185lXjjGE8FaEYEU326rueP1QqsnQxyc5PdwwHVK0ryhCUjikYf9mpm5GHkCgYEAyl0ivTzxW/aLBXszReeii5S0gSATmunMl/yDDR7WElXLSQr3ZIJW+spc/YFtdcODXO4z2Q99b2TFlU6gUUGv/rGciB6JQH77duoVKi/fUetpsbcz02NTS+mPlTaeBfxo4gIltdFpZ+PhXgU4xn59CreUKHuM+gsZ483JDFTdbIUCgYEAuAmGV+69pfU9lLSF9zzfu39KlNvL6Lqx6jhQ22IjolIt/p1iz9tph2AnzyiPoMQbjQfdqjIJWugGL/f80zhraPfGN9h0FhPr2WAyh9cdm268ksWtTfSDnjU3fT/nt+Fh4j9vr/a2//D24TKbQLoBh2A06a0GisTSI2Cknm0QB8UCgYBLszN/nwCa6ktvLXsst03y8RnlA97RoIxMfsV3bwWdrkJxfIy3KJrpDjJjErujxhOp++GhXU4LEaNoCxWlz/DKUh7APMwTOG1ROpfYRDhCKNJNDL9yYEGUsDZqFxheHOIPScZZkZDgsDpqNYHbnw2fqLTfv/gowWZZ9W00E7sREQKBgB4saZtXKD7ic4NDCcfcci4yk47ObqMsoOju7MrbT05YvPPG6CF+LtIkQMKlOs839/Bqfrxd0czWx9Triscys+GU5inX0kigYYXVUNOWwGLwh/hkcqKaWU4CGaPua1ZpnHvUvMIT6DMUVdXcTzoQhRml+2bomG7+EBn+yV60MPGlAoGAaeSKGhtMNb+g2zHCe4EzzHzvVq0XUpQu9giOz/TNIkNuk8CBQPmR8vLigl5K8uol5Q4e0pX1HXK96+1EbNzDIX37x8J74j8XXCyPqFxuZile79oI3A3DJS+lycmGbVgNNitcyzMZq3mLHTwhsoMILCLMS5qLDB2AL9Y12jBOFLE=
eaeb94ba-1a23-46b9-a02a-7d808993fd8b	cf8c6e0f-996c-4879-917c-e2b16c8b12ac	keyUse	ENC
fcc9cc1b-02c0-44dc-922c-7b0075e4e442	fefa439f-9aa6-4a5b-b3fc-51f187c664c3	kid	b925d26d-d40f-4e05-ac28-9522585a839f
e7f0f26b-b2a3-4ada-836e-91c48a0cc090	fefa439f-9aa6-4a5b-b3fc-51f187c664c3	algorithm	HS256
57bc1e64-b875-4b2f-aec4-22dc9d3f6d6c	fefa439f-9aa6-4a5b-b3fc-51f187c664c3	priority	100
ec480027-ac99-4ba9-bac5-088c24fb907c	fefa439f-9aa6-4a5b-b3fc-51f187c664c3	secret	vE9F-FB44oHgehU7Jnt4zDZIrHNcJzfk4bqmzBMyeMfkvBjeZoPqK8d41bqrWsAyuKiSW5diADaWz3k-ZjCwgg
4ba2a099-cdd9-43b3-99ff-5e91a0402078	a575cd37-7a3d-40fd-9bda-8d3f8313fdb5	secret	zhI1B-yMc75_JaOT-t2njw
0af6ecf7-6ddc-4f30-aa23-8d5c0d20b985	a575cd37-7a3d-40fd-9bda-8d3f8313fdb5	kid	9f802e94-ee01-4e8d-a3dd-5f1394d2ea3e
b36519ae-9e67-4f55-a6f9-d6f728358c3e	a575cd37-7a3d-40fd-9bda-8d3f8313fdb5	priority	100
7517bd0d-fb79-4fc9-baa4-2932c41f08f8	b164d659-61a1-40ec-a489-6eb0e03f94eb	keyUse	SIG
de3e1435-5710-4fe0-a8c9-2091aba7c38c	b164d659-61a1-40ec-a489-6eb0e03f94eb	privateKey	MIIEogIBAAKCAQEAm0Ugc7Xrn2PZhEAxsauOFRLjSic1soQ8PMyoOhYFCi0Ychf9us7ifDb0D7cGI1sVY7DAwxbpyuLa4IVaoTnP0Poa2Ua+Q+TgpM4fYNxkFob6lfJee+ql6VKj5YnbMgj0+czvhBowQDtzwmcFWl+BmVtGh/Q2u0V7/PRsf9WgaWSBZD4NyMl9pTLpgDCLACyquVcM1DhXBCOXrnsBH9XcTZuVoFsad0mmLCDm99ls9otsoIE+vhXULgWAf7V5+tQkoSfK1eVHNkeYCjSaUCBoDZmN55W0VfY4C23DM5dzLhUxCubD6372hISr5zShuqPVtmIAsgL4oqlSJvl22NKnHwIDAQABAoIBACGJ0PStevO20akrZJCICeyrY8UEqyigP5KycjP5xaTpELq0S+4p+enyxM0QL5c7eWdLKpf5Pw6/6Z9NrsHchvMQ0vPTwA1SRuPSUhzN/iCPj1kMPTRu/t9jJlvSZzJrlN7QUXwrW/jD3sFDF3jp4EiL2rRLH/dbjuiYs0b5keixos9fXHFu2ixyOD9TAHmgbOssc7cQ2esTe5NZsXOSFnPT/HWu2w3hUH9sVuNESJUF2LANmLQx2dgO6UOZCgc0ciKsFtF/6la5DQdy5dgRR4+00DVruHX+z6HDxD0mHgLJz2ADsH2QnLSPBz3lkChp33UQNznk5qEZHDFL2QGIgAECgYEAyOxyC4qqgOdQV8rAMqyPPfClkDXhwXhl474QjxT9Zzpd3G7MUGY3D9veTYH7AgqsUYATM4QNTyP2605Wi1VBTEB/qDMmbr1wYs5PevRYOb1anDtaZQWvFMAq3xQhS2VKtd92kzK82R8BbmC+PazNMiJf7ov6F30YZyE8xlp/lx8CgYEAxdT/8y6nWWr63J8sNRZUUZeyTXav+YRD1vijpj8nRJMpLK9vq9EMQDgoJ5wBW+yNC4o3ogQ9pn8oGAE5pjuzOlZqxEefvmIQyuPKQxyTTzV5d0+RymZakSnHvNPTs71dbjA6uWplxaF8FSUCnWGj3GG9awMqgbLFs1oUwQia8AECgYATMeuPSLcTS4X0bS1BahThMP1QMqWXqx3ozP6d/L5cv0m6RmeEgs9d1358Xx+QyV4/BwJOmJ4A4omzXy+LbiCn3T2U3xYb3ENBXT5gm7lWAs4GQPFY11srm1Q9LZokrs+dYnTciStbfsfPOLTUBY8w6/HIQ10oI05Sg+1fccPgtwKBgC1uLqDf09p68MT9YJ+IUzCxj2aunNbGAvY4/wvMcO4UhV4Xo6NnTFLrEn2WG9HKTtGZmhEAvE+h38kzbtO33f7FnZsZf5uu1YBiMy6aP1HvS8eUZDyAqMexOocodfNOx0fol3PA9UIfRWltqF4P8BtJ7r/GaFqEfVYkl6OEoGABAoGAA1wKFyFBr4W2NMiBzH3X1dO1pBygRD3NlAXIJ+pXhtF5UOPWjgmEvavLLXaCsZwH/83mVcsVZETA5eQJqKSWVt6EJEs4xqM+NudnOvskO1jOQn4mjlYXEpuIpEbvYcdh+1EWdSbSDMRfBbGtJE8DEZ7PlNil8EMl5HqcG4FNzoM=
0b165edd-14b1-4c79-8148-001ab2a7ce12	b164d659-61a1-40ec-a489-6eb0e03f94eb	certificate	MIICpzCCAY8CBgGQoexrkzANBgkqhkiG9w0BAQsFADAXMRUwEwYDVQQDDAxCaWxhbkNhcmJvbmUwHhcNMjQwNzExMTMxMDQ0WhcNMzQwNzExMTMxMjI0WjAXMRUwEwYDVQQDDAxCaWxhbkNhcmJvbmUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCbRSBzteufY9mEQDGxq44VEuNKJzWyhDw8zKg6FgUKLRhyF/26zuJ8NvQPtwYjWxVjsMDDFunK4trghVqhOc/Q+hrZRr5D5OCkzh9g3GQWhvqV8l576qXpUqPlidsyCPT5zO+EGjBAO3PCZwVaX4GZW0aH9Da7RXv89Gx/1aBpZIFkPg3IyX2lMumAMIsALKq5VwzUOFcEI5euewEf1dxNm5WgWxp3SaYsIOb32Wz2i2yggT6+FdQuBYB/tXn61CShJ8rV5Uc2R5gKNJpQIGgNmY3nlbRV9jgLbcMzl3MuFTEK5sPrfvaEhKvnNKG6o9W2YgCyAviiqVIm+XbY0qcfAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFg1K3GK+nz2IQ5jBzlnoCKSL8dmPWFYpzLupOGY8G95MH26z8rlWGV3Y+e9odszr1lOiMqSAvHKK2Uer4xmvatXM7wyxs/6r1uAB+NE6lLe45cCAew75pA2Dq8QL7QWnpRGC5+anlXVoB54oLc4q2OnNw9ra/x9nN7mMYfN3/j+CpBC7NV6rx1XHBrzzKQAq0g4+PaEqp5gxZWA2K5rjSm+ZRGJuFCZlazYLHvD/UdSi0Pnl5oENn7zYUYtcG/ok4UYDSh/wmcMCA2H+nvm1kMFSCwzlkYmKMljIjykmzKKTcdcLtRyKKyHBYlYxky5UMm6eaPMk908Gz+aSV7MvhA=
8bf5c539-9789-4147-ae8a-684110166a47	b164d659-61a1-40ec-a489-6eb0e03f94eb	priority	100
010449a6-d50f-46fd-aac1-d8bd8b7c2bf5	d5d40bc2-9142-4958-97c4-36502144332c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
66485a78-2292-4511-9061-4a470b39a525	d5d40bc2-9142-4958-97c4-36502144332c	allowed-protocol-mapper-types	saml-user-property-mapper
c58db070-28d1-469e-a57b-7fa808d6fd82	d5d40bc2-9142-4958-97c4-36502144332c	allowed-protocol-mapper-types	oidc-full-name-mapper
a1eae16d-4665-4a9c-8228-05a6ec137375	d5d40bc2-9142-4958-97c4-36502144332c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
4c9fd1e7-d5c5-4adc-9c4d-720993c5a725	d5d40bc2-9142-4958-97c4-36502144332c	allowed-protocol-mapper-types	oidc-address-mapper
0215b4ed-0417-45bd-8be0-a5ad91a7943a	d5d40bc2-9142-4958-97c4-36502144332c	allowed-protocol-mapper-types	saml-user-attribute-mapper
c398f06b-5336-4870-9021-26f396de7d55	d5d40bc2-9142-4958-97c4-36502144332c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b800fc71-09f5-4525-936a-4f683e41cbbe	d5d40bc2-9142-4958-97c4-36502144332c	allowed-protocol-mapper-types	saml-role-list-mapper
f02fa646-27f6-4a8d-823e-2b9cee2f9de2	fb86a35c-e475-4260-9a32-92d3abe9e77c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
157dbc79-851c-4975-a994-da1f91da30c2	fb86a35c-e475-4260-9a32-92d3abe9e77c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
45144115-da6e-4de2-96d9-ce6517dce8b6	fb86a35c-e475-4260-9a32-92d3abe9e77c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c18c34a4-edb1-4a86-94ba-c82ebeb86ac2	fb86a35c-e475-4260-9a32-92d3abe9e77c	allowed-protocol-mapper-types	saml-user-property-mapper
963f5b35-238d-4712-9179-a083fcd93545	fb86a35c-e475-4260-9a32-92d3abe9e77c	allowed-protocol-mapper-types	oidc-address-mapper
e2aeed76-b585-4129-a153-41d26d89b1b7	fb86a35c-e475-4260-9a32-92d3abe9e77c	allowed-protocol-mapper-types	oidc-full-name-mapper
1ae29d27-7fa0-4490-b7c8-8fddc27d0023	fb86a35c-e475-4260-9a32-92d3abe9e77c	allowed-protocol-mapper-types	saml-role-list-mapper
75a66890-564e-4fce-9448-4f994f96e309	fb86a35c-e475-4260-9a32-92d3abe9e77c	allowed-protocol-mapper-types	saml-user-attribute-mapper
f489f3b7-4295-49c3-832f-bb9b93014201	b99c5c83-f759-499b-8816-b03759b72883	max-clients	200
2a61ec2b-c689-47a0-8b26-4ad6c117bf13	39bf8df6-b2b4-4166-b88d-90f78e2b6649	host-sending-registration-request-must-match	true
76f06e1e-13d7-4ea7-8de9-6b7c5245dbff	39bf8df6-b2b4-4166-b88d-90f78e2b6649	client-uris-must-match	true
cd339d85-8997-4851-b8a6-761efcc173c1	dcccca4a-159d-40a3-a94c-abbcfcba49eb	allow-default-scopes	true
709186c1-a894-4ec3-8933-7d5d580813e4	64e23165-2b0a-4c0f-ba57-97a03440396f	allow-default-scopes	true
389df53b-1fa5-44cb-9f65-7a53d3164af2	d4833b98-9d8f-420a-9373-a60f54bee46c	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}
037c7db2-d1ea-4a93-9c44-5a4650a40129	b9e258ce-62da-48e5-94ee-ad895370a350	kid	0003e52d-16d5-4cc6-abc9-c764b6af6096
3f375986-12f3-4189-8dfc-f29da8aec6ff	b9e258ce-62da-48e5-94ee-ad895370a350	secret	tTQscuMy57Vagcy8OzUMTAPGJgRuaGjgc1w09ShTpaW5_j49IxOYDgVqfgScJXg27_Y6h2TZdtiCiLK2u7MGBnjztMvdtembpSUtsvFAylDv4fYJTZrydd1fODTLmzDR7TOimjJ98Gz6iW3SiHGkbYWb_AmjyrppK1lDerd_h1c
46789296-7a53-4692-839c-48b3e698d239	b9e258ce-62da-48e5-94ee-ad895370a350	priority	100
9fc165e8-11f7-4a0e-9ea4-40549de9d08e	b9e258ce-62da-48e5-94ee-ad895370a350	algorithm	HS512
75da59ee-a45d-4b67-9717-4571d5ab84a4	c6535b5e-d169-4bbd-a4c0-d5957b01f692	priority	100
aa8d32c8-1f60-4ebc-bab2-8e8d1ae84218	c6535b5e-d169-4bbd-a4c0-d5957b01f692	algorithm	HS512
e840848d-8665-4319-a22b-97ad99ee7a97	c6535b5e-d169-4bbd-a4c0-d5957b01f692	kid	f0b9e1e2-e034-40e2-bda5-6722c47d4ca8
50a00c0a-2989-414d-bb3b-e24f75573f91	c6535b5e-d169-4bbd-a4c0-d5957b01f692	secret	wu0MchdJQr_9tQHTm3TIpj2dvSf_Y9iwxXI0tcgUE2oF8AIKBmmQU2iNOJd97h2uLR9qeo7Y-_rQM78c4l7RCnKNVP_yb0hORklpPSH7ib2RI-x_q91pnOa0lg7rUUMXvSH4q6bGUsh3Ia5cMzUeUEJUgE4LyUkJ5EoPiBaiqF4
228d07e3-8800-4df2-9979-a6241a2ad193	fb71cb13-7288-4116-80da-beae84c56436	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.composite_role (composite, child_role) FROM stdin;
e7e163dd-4893-438a-abae-b5a59e640a97	1040ee85-dfed-48e4-98dd-d97e1931c40b
e7e163dd-4893-438a-abae-b5a59e640a97	ab53b2cc-b589-4b75-a1fa-137930e1b2bc
e7e163dd-4893-438a-abae-b5a59e640a97	7a4447ad-ffdd-44c4-99ac-253b340e59a8
e7e163dd-4893-438a-abae-b5a59e640a97	39553248-045f-4966-8505-2382f6365557
e7e163dd-4893-438a-abae-b5a59e640a97	62e5ce2b-27c0-44fc-af39-e362967fbe4e
e7e163dd-4893-438a-abae-b5a59e640a97	c1d1e66d-50c4-4d1b-9e9d-6b2b191e0205
e7e163dd-4893-438a-abae-b5a59e640a97	888b642f-04fd-4f85-9f82-a173e9cd558e
e7e163dd-4893-438a-abae-b5a59e640a97	7e4190fc-a547-4b8f-a5cf-72ff5a1ca254
e7e163dd-4893-438a-abae-b5a59e640a97	cf3bcf4b-f25f-4f23-87ca-ccc08deab6cd
e7e163dd-4893-438a-abae-b5a59e640a97	1f99680c-a902-4f57-870a-627b1e70a344
e7e163dd-4893-438a-abae-b5a59e640a97	9b69143e-d122-49f2-bf0f-d93a0d0ea555
e7e163dd-4893-438a-abae-b5a59e640a97	18fa80b5-aaf6-4ce2-a6d9-a2a423a1987d
e7e163dd-4893-438a-abae-b5a59e640a97	8a018078-33ac-4ded-bc37-7a8b55b93ba9
e7e163dd-4893-438a-abae-b5a59e640a97	b1debf07-6396-454c-94cc-2852bdc27c6f
e7e163dd-4893-438a-abae-b5a59e640a97	1bf0253f-23d8-48eb-b675-d40662c65333
e7e163dd-4893-438a-abae-b5a59e640a97	90e23467-4e97-49a1-bbe2-fcea102fb85c
e7e163dd-4893-438a-abae-b5a59e640a97	8d449f4d-d365-4192-baf3-1a631215c990
e7e163dd-4893-438a-abae-b5a59e640a97	82b768a5-3092-4c9f-8c39-296e7aa23d22
39553248-045f-4966-8505-2382f6365557	1bf0253f-23d8-48eb-b675-d40662c65333
39553248-045f-4966-8505-2382f6365557	82b768a5-3092-4c9f-8c39-296e7aa23d22
62e5ce2b-27c0-44fc-af39-e362967fbe4e	90e23467-4e97-49a1-bbe2-fcea102fb85c
6c27489a-09f0-4f82-adb7-422c45318e5d	ca024dfd-7fe2-4d57-ad10-e26b8b809ea7
6c27489a-09f0-4f82-adb7-422c45318e5d	71019e50-8f57-4708-b0ae-450a5da85ca5
71019e50-8f57-4708-b0ae-450a5da85ca5	2c5ed4d3-f23e-4d12-913e-ee7b46a5674f
c2f0a4b7-fcba-4d20-8da5-cba6e6fd9a7f	6d28556c-e2a4-418c-9670-f6d902a6c6b5
e7e163dd-4893-438a-abae-b5a59e640a97	0674b9c1-570e-4232-ab3b-b485777a6698
6c27489a-09f0-4f82-adb7-422c45318e5d	43c69691-5960-48c7-9587-81efadfa7eff
6c27489a-09f0-4f82-adb7-422c45318e5d	9cc56e04-9700-4f6e-92dc-7761e2b85210
e7e163dd-4893-438a-abae-b5a59e640a97	2e96d65d-6aa8-495c-9cc4-c1c1c02b0620
e7e163dd-4893-438a-abae-b5a59e640a97	b33f016d-ce02-4d82-afbe-0503e52fd425
e7e163dd-4893-438a-abae-b5a59e640a97	f9b952e1-f7ff-48db-ac5c-9856cac33c6e
e7e163dd-4893-438a-abae-b5a59e640a97	a7b852a3-12b4-4bbf-b5e1-548827c3f4e4
e7e163dd-4893-438a-abae-b5a59e640a97	162f97e3-636d-423b-be39-bb76d2a839f0
e7e163dd-4893-438a-abae-b5a59e640a97	62c268d3-a127-425b-b451-1823bb996a72
e7e163dd-4893-438a-abae-b5a59e640a97	2a3625d9-9b0d-4d68-b5dc-8bb4e668c0d7
e7e163dd-4893-438a-abae-b5a59e640a97	4942b676-bfa6-464d-8fa4-0f1ca1847916
e7e163dd-4893-438a-abae-b5a59e640a97	4dfacfc7-d6c1-460c-8b17-6e01cd8b3c09
e7e163dd-4893-438a-abae-b5a59e640a97	cc76babc-8f2b-4567-a58a-6d767a1c2d4f
e7e163dd-4893-438a-abae-b5a59e640a97	928001fe-b8b2-417d-8c6a-d79b4dc3debd
e7e163dd-4893-438a-abae-b5a59e640a97	4255f549-298a-4052-8919-d3b4054635b1
e7e163dd-4893-438a-abae-b5a59e640a97	65868ac8-63ec-4ede-a9c4-95ba7f52bc10
e7e163dd-4893-438a-abae-b5a59e640a97	ceb55e40-27dd-4c51-aa99-7ed04e20cb17
e7e163dd-4893-438a-abae-b5a59e640a97	1c5f38de-a1fe-4150-8bec-a24b7ba3c4da
e7e163dd-4893-438a-abae-b5a59e640a97	ac09856d-4d38-4af5-a9ef-56db668010f5
e7e163dd-4893-438a-abae-b5a59e640a97	77a42733-ab1f-4996-8573-223a980d4e7e
a7b852a3-12b4-4bbf-b5e1-548827c3f4e4	1c5f38de-a1fe-4150-8bec-a24b7ba3c4da
f9b952e1-f7ff-48db-ac5c-9856cac33c6e	77a42733-ab1f-4996-8573-223a980d4e7e
f9b952e1-f7ff-48db-ac5c-9856cac33c6e	ceb55e40-27dd-4c51-aa99-7ed04e20cb17
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	b0219297-4967-4508-914d-eccb2b150360
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	9b7d36a1-d3d5-4071-ad11-39053cc6fe1e
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	c53f571c-5618-41e0-b45b-fa2d07b9f462
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	9b47a21b-ad29-4286-949c-bbc7f4892fc9
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	5aacf348-adf4-4b4e-a25b-370dfb5fc838
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	64ab9867-dd1e-4589-adc1-941b852c618e
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	7580e50e-5328-49c3-b261-f12761d0724e
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	3ee68063-6fea-4e3f-8d0e-93752e91030f
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	1fa019c6-f295-44a3-b84a-4af8c14b0eb1
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	d1cb561f-0d6f-415f-ac51-0f4c8c9ad4d2
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	db96df6d-ba11-4e39-b976-92b92064c1cc
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	31909272-dddb-4112-8577-0db3c1a7f5e3
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	4d1c9d79-dd24-4168-bc38-db10c0468768
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	aac20644-f3a3-4d62-88bd-de5615501116
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	8cb66f25-41c9-4574-8776-16117e31b6b9
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	c371afba-1447-47c1-a87e-08380bcc3073
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	fe091d6c-b2cb-4adc-bb1b-323db3640f7c
3c4e2f83-7e42-4a2f-9c34-21cdfb854a70	3f807fd7-6174-44cf-b199-359f6232320e
9b47a21b-ad29-4286-949c-bbc7f4892fc9	8cb66f25-41c9-4574-8776-16117e31b6b9
c53f571c-5618-41e0-b45b-fa2d07b9f462	fe091d6c-b2cb-4adc-bb1b-323db3640f7c
c53f571c-5618-41e0-b45b-fa2d07b9f462	aac20644-f3a3-4d62-88bd-de5615501116
3c4e2f83-7e42-4a2f-9c34-21cdfb854a70	b264cfad-a71e-4ffd-8ada-a3dfc01628d6
b264cfad-a71e-4ffd-8ada-a3dfc01628d6	dc332a66-bd3e-46fa-beef-09262155e199
92ed1938-ab02-4436-ac42-8487ccdab8ea	63eff15a-18b1-40bb-bbb6-e0f2a4ae7452
e7e163dd-4893-438a-abae-b5a59e640a97	c24efa94-f09d-4b5d-9e6e-983bb6b88a41
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	5cac8d15-14f8-4c1e-8a8f-fd76b9e5c66d
3c4e2f83-7e42-4a2f-9c34-21cdfb854a70	a6f65cb7-29ba-48a1-a3b2-0f9e1c9ed89c
3c4e2f83-7e42-4a2f-9c34-21cdfb854a70	70937752-b8ea-4de2-80b2-01e0c3956701
3905cfad-7099-45cc-a96d-685320385613	7580e50e-5328-49c3-b261-f12761d0724e
3905cfad-7099-45cc-a96d-685320385613	aac20644-f3a3-4d62-88bd-de5615501116
3905cfad-7099-45cc-a96d-685320385613	c371afba-1447-47c1-a87e-08380bcc3073
3905cfad-7099-45cc-a96d-685320385613	dc332a66-bd3e-46fa-beef-09262155e199
3905cfad-7099-45cc-a96d-685320385613	fe091d6c-b2cb-4adc-bb1b-323db3640f7c
3905cfad-7099-45cc-a96d-685320385613	b9d3e61b-3dfb-4e11-8bfa-5c2221d7a7a9
3905cfad-7099-45cc-a96d-685320385613	c3209ca8-1eb7-4a0e-ac59-e5c9957d3831
3905cfad-7099-45cc-a96d-685320385613	64ab9867-dd1e-4589-adc1-941b852c618e
3905cfad-7099-45cc-a96d-685320385613	6b042f3c-b82e-4e60-8efb-961cc5bb6a18
3905cfad-7099-45cc-a96d-685320385613	8cb66f25-41c9-4574-8776-16117e31b6b9
3905cfad-7099-45cc-a96d-685320385613	5cac8d15-14f8-4c1e-8a8f-fd76b9e5c66d
3905cfad-7099-45cc-a96d-685320385613	1fa019c6-f295-44a3-b84a-4af8c14b0eb1
3905cfad-7099-45cc-a96d-685320385613	b0219297-4967-4508-914d-eccb2b150360
3905cfad-7099-45cc-a96d-685320385613	b264cfad-a71e-4ffd-8ada-a3dfc01628d6
3905cfad-7099-45cc-a96d-685320385613	44f5ac06-3d80-4179-92eb-135e44936344
3905cfad-7099-45cc-a96d-685320385613	9b7d36a1-d3d5-4071-ad11-39053cc6fe1e
3905cfad-7099-45cc-a96d-685320385613	db96df6d-ba11-4e39-b976-92b92064c1cc
3905cfad-7099-45cc-a96d-685320385613	3ee68063-6fea-4e3f-8d0e-93752e91030f
3905cfad-7099-45cc-a96d-685320385613	9b47a21b-ad29-4286-949c-bbc7f4892fc9
3905cfad-7099-45cc-a96d-685320385613	c53f571c-5618-41e0-b45b-fa2d07b9f462
3905cfad-7099-45cc-a96d-685320385613	92ed1938-ab02-4436-ac42-8487ccdab8ea
3905cfad-7099-45cc-a96d-685320385613	5aacf348-adf4-4b4e-a25b-370dfb5fc838
3905cfad-7099-45cc-a96d-685320385613	d1cb561f-0d6f-415f-ac51-0f4c8c9ad4d2
3905cfad-7099-45cc-a96d-685320385613	3f807fd7-6174-44cf-b199-359f6232320e
3905cfad-7099-45cc-a96d-685320385613	2c8ec5a2-63de-4660-9528-fb69fc6fd392
3905cfad-7099-45cc-a96d-685320385613	31909272-dddb-4112-8577-0db3c1a7f5e3
3905cfad-7099-45cc-a96d-685320385613	63eff15a-18b1-40bb-bbb6-e0f2a4ae7452
3905cfad-7099-45cc-a96d-685320385613	4d1c9d79-dd24-4168-bc38-db10c0468768
7c9ad2b9-d89b-4ff6-b625-3637de83d666	b264cfad-a71e-4ffd-8ada-a3dfc01628d6
0d833f8d-98cb-42be-9a07-4c1a0adf287b	c53f571c-5618-41e0-b45b-fa2d07b9f462
0d833f8d-98cb-42be-9a07-4c1a0adf287b	b264cfad-a71e-4ffd-8ada-a3dfc01628d6
0d833f8d-98cb-42be-9a07-4c1a0adf287b	1fa019c6-f295-44a3-b84a-4af8c14b0eb1
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
10c42cd2-ea50-42c2-ad99-d2339f57f312	\N	password	5db6d25f-748f-462d-9ab0-5adf0c1f5953	1720777286041	My password	{"value":"WkmmtKnoi0QfVwfeOYvBaYoTIpOboTkYzhG0p4Ma4QI=","salt":"2B77+jUOcArz3xkyjyNkqg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
0ed6c3b5-3516-45bc-bedc-6c194786462e	\N	password	6df8a143-0b2c-43cf-96e7-06fc76c8ea94	1721376513059	My password	{"value":"3httsJAX1gvXRF9jKxxlfdHH3ebM8njik/K3ECH+cfg=","salt":"W5IJrwUvkoAgbp9OcYTX9Q==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-07-11 13:05:15.838743	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	0703115472
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-07-11 13:05:15.862175	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	0703115472
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-07-11 13:05:15.877748	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.23.2	\N	\N	0703115472
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-07-11 13:05:15.879046	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	0703115472
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-07-11 13:05:15.912732	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	0703115472
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-07-11 13:05:15.920716	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	0703115472
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-07-11 13:05:15.952446	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	0703115472
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-07-11 13:05:15.962326	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	0703115472
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-07-11 13:05:15.965287	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.23.2	\N	\N	0703115472
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-07-11 13:05:15.994788	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.23.2	\N	\N	0703115472
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-07-11 13:05:16.012979	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	0703115472
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-07-11 13:05:16.017513	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	0703115472
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-07-11 13:05:16.024419	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	0703115472
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-11 13:05:16.030811	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.23.2	\N	\N	0703115472
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-11 13:05:16.031527	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	0703115472
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-11 13:05:16.032914	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.23.2	\N	\N	0703115472
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-11 13:05:16.033921	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.23.2	\N	\N	0703115472
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-07-11 13:05:16.050449	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.23.2	\N	\N	0703115472
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-07-11 13:05:16.066159	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	0703115472
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-07-11 13:05:16.067568	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	0703115472
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-16 19:02:17.898787	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	1156537868
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-07-11 13:05:16.071806	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	0703115472
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-07-11 13:05:16.073724	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	0703115472
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-07-11 13:05:16.080497	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.23.2	\N	\N	0703115472
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-07-11 13:05:16.081927	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	0703115472
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-07-11 13:05:16.082388	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	0703115472
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-07-11 13:05:16.091794	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.23.2	\N	\N	0703115472
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-07-11 13:05:16.115925	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.23.2	\N	\N	0703115472
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-07-11 13:05:16.117344	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	0703115472
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-07-11 13:05:16.134796	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.23.2	\N	\N	0703115472
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-07-11 13:05:16.139172	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.23.2	\N	\N	0703115472
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-07-11 13:05:16.144238	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.23.2	\N	\N	0703115472
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-07-11 13:05:16.145509	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.23.2	\N	\N	0703115472
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-11 13:05:16.147158	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	0703115472
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-11 13:05:16.149157	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	0703115472
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-11 13:05:16.158305	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	0703115472
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-07-11 13:05:16.159787	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.23.2	\N	\N	0703115472
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-11 13:05:16.162287	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	0703115472
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-07-11 13:05:16.163217	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.23.2	\N	\N	0703115472
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-07-11 13:05:16.164068	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.23.2	\N	\N	0703115472
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-07-11 13:05:16.164503	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	0703115472
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-07-11 13:05:16.165239	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	0703115472
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-07-11 13:05:16.166656	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.23.2	\N	\N	0703115472
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-07-11 13:05:16.201562	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.23.2	\N	\N	0703115472
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-07-11 13:05:16.203241	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.23.2	\N	\N	0703115472
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-11 13:05:16.204533	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	0703115472
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-11 13:05:16.206011	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.23.2	\N	\N	0703115472
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-11 13:05:16.206464	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	0703115472
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-11 13:05:16.218475	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.23.2	\N	\N	0703115472
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-11 13:05:16.219725	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.23.2	\N	\N	0703115472
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-07-11 13:05:16.232226	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.23.2	\N	\N	0703115472
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-07-11 13:05:16.241147	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.23.2	\N	\N	0703115472
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-07-11 13:05:16.242061	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0703115472
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-07-11 13:05:16.242745	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.23.2	\N	\N	0703115472
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-07-11 13:05:16.243329	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.23.2	\N	\N	0703115472
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-11 13:05:16.244785	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.23.2	\N	\N	0703115472
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-11 13:05:16.245909	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.23.2	\N	\N	0703115472
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-11 13:05:16.251344	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.23.2	\N	\N	0703115472
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-11 13:05:16.280364	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.23.2	\N	\N	0703115472
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-07-11 13:05:16.2897	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.23.2	\N	\N	0703115472
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-07-11 13:05:16.291382	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	0703115472
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-07-11 13:05:16.293938	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.23.2	\N	\N	0703115472
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-07-11 13:05:16.297792	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.23.2	\N	\N	0703115472
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-07-11 13:05:16.301246	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	0703115472
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-07-11 13:05:16.302523	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	0703115472
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-07-11 13:05:16.305106	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.23.2	\N	\N	0703115472
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-07-11 13:05:16.309413	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.23.2	\N	\N	0703115472
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-07-11 13:05:16.310766	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.23.2	\N	\N	0703115472
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-07-11 13:05:16.311758	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.23.2	\N	\N	0703115472
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-07-11 13:05:16.31451	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.23.2	\N	\N	0703115472
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-07-11 13:05:16.315728	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.23.2	\N	\N	0703115472
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-07-11 13:05:16.316779	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	0703115472
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-11 13:05:16.318238	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	0703115472
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-11 13:05:16.320132	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	0703115472
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-11 13:05:16.321544	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	0703115472
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-11 13:05:16.326791	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.23.2	\N	\N	0703115472
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-11 13:05:16.328831	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.23.2	\N	\N	0703115472
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-11 13:05:16.329765	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.23.2	\N	\N	0703115472
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-11 13:05:16.330264	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.23.2	\N	\N	0703115472
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-11 13:05:16.335692	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.23.2	\N	\N	0703115472
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-11 13:05:16.337065	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.23.2	\N	\N	0703115472
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-11 13:05:16.338999	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.23.2	\N	\N	0703115472
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-11 13:05:16.339366	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	0703115472
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-11 13:05:16.340577	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	0703115472
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-11 13:05:16.341127	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	0703115472
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-11 13:05:16.342591	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	0703115472
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-07-11 13:05:16.343809	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.23.2	\N	\N	0703115472
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-07-11 13:05:16.345509	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.23.2	\N	\N	0703115472
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-07-11 13:05:16.347696	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.23.2	\N	\N	0703115472
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-11 13:05:16.349145	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.23.2	\N	\N	0703115472
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-11 13:05:16.350492	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.23.2	\N	\N	0703115472
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-11 13:05:16.35259	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	0703115472
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-11 13:05:16.354482	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.23.2	\N	\N	0703115472
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-11 13:05:16.354939	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	0703115472
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-11 13:05:16.356918	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	0703115472
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-11 13:05:16.357711	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.23.2	\N	\N	0703115472
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-11 13:05:16.359196	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.23.2	\N	\N	0703115472
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-11 13:05:16.362002	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	0703115472
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-11 13:05:16.362485	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0703115472
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-11 13:05:16.365021	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0703115472
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-11 13:05:16.366928	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0703115472
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-11 13:05:16.367408	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0703115472
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-11 13:05:16.369078	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.23.2	\N	\N	0703115472
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-11 13:05:16.37043	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.23.2	\N	\N	0703115472
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-07-11 13:05:16.37293	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.23.2	\N	\N	0703115472
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-07-11 13:05:16.374512	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.23.2	\N	\N	0703115472
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-07-11 13:05:16.375945	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.23.2	\N	\N	0703115472
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-07-11 13:05:16.377117	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.23.2	\N	\N	0703115472
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-07-11 13:05:16.378529	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	0703115472
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-07-11 13:05:16.378987	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	0703115472
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-07-11 13:05:16.380528	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0703115472
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-07-11 13:05:16.381562	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.23.2	\N	\N	0703115472
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-07-11 13:05:16.387489	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	0703115472
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-07-11 13:05:16.38857	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.23.2	\N	\N	0703115472
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-07-11 13:05:16.390043	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.23.2	\N	\N	0703115472
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-07-11 13:05:16.390459	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.23.2	\N	\N	0703115472
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-07-11 13:05:16.392041	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.23.2	\N	\N	0703115472
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-07-11 13:05:16.392929	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	0703115472
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-16 19:02:17.893731	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	1156537868
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-16 19:02:17.90266	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	1156537868
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-16 19:02:17.906876	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	1156537868
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-07-16 19:02:17.910889	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	1156537868
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-07-16 19:02:17.911603	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	1156537868
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-07-16 19:02:17.912614	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	1156537868
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-16 19:02:17.915653	125	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.25.1	\N	\N	1156537868
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-16 19:02:17.917983	126	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	1156537868
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-16 19:02:17.921059	127	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.25.1	\N	\N	1156537868
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-16 19:02:17.921781	128	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	1156537868
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-16 19:02:17.925631	129	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	1156537868
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-16 19:02:17.934754	130	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.25.1	\N	\N	1156537868
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-16 19:02:17.943503	131	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	1156537868
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-16 19:02:17.944338	132	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	1156537868
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-16 19:02:17.947844	133	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.25.1	\N	\N	1156537868
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
beec1c98-131e-4539-bb19-21867eb81576	dafcbb48-2270-4063-8ae9-761c726cc53d	f
beec1c98-131e-4539-bb19-21867eb81576	b1241b05-3cc2-42f0-ad64-8e284154f84e	t
beec1c98-131e-4539-bb19-21867eb81576	44e47a36-d5ce-4786-a838-fe715bd920cd	t
beec1c98-131e-4539-bb19-21867eb81576	10db96a7-cdd1-4640-866f-c1fb74376f56	t
beec1c98-131e-4539-bb19-21867eb81576	d40894c3-a63e-414f-b77e-f55e36ec2517	f
beec1c98-131e-4539-bb19-21867eb81576	1c3296d1-1a84-4636-9b77-6b295ce40cd0	f
beec1c98-131e-4539-bb19-21867eb81576	2810fac0-79f6-4901-bb80-b4f43d14da21	t
beec1c98-131e-4539-bb19-21867eb81576	458d374f-641a-4337-9732-419e2fe4f723	t
beec1c98-131e-4539-bb19-21867eb81576	0fd78dd8-5193-49c1-9c96-49e9e9514b0e	f
beec1c98-131e-4539-bb19-21867eb81576	823578f0-ea54-4b92-8bab-7452e561cb62	t
3f237d26-0988-482a-b1c2-14ce1e4b950f	10ee36e0-f356-46d9-9e70-0781e7748a08	f
3f237d26-0988-482a-b1c2-14ce1e4b950f	d0bffa34-9e1b-4fde-8d17-94be72dbd245	t
3f237d26-0988-482a-b1c2-14ce1e4b950f	90153c46-3b23-4d63-bbc5-9a532f66d2d2	t
3f237d26-0988-482a-b1c2-14ce1e4b950f	c7767e38-79ac-46c4-8663-f85874c53b0d	t
3f237d26-0988-482a-b1c2-14ce1e4b950f	19478448-6652-4156-9da5-0553a62f542c	f
3f237d26-0988-482a-b1c2-14ce1e4b950f	0516ee30-7eac-4173-a7e1-ab491ad2da7e	f
3f237d26-0988-482a-b1c2-14ce1e4b950f	95efc217-3bef-4624-a9f0-b6cf64db3c68	t
3f237d26-0988-482a-b1c2-14ce1e4b950f	8a26ad4d-325f-4896-8e08-88716f5c1416	t
3f237d26-0988-482a-b1c2-14ce1e4b950f	828ee37b-7285-4c85-9f29-827af6b2f189	f
3f237d26-0988-482a-b1c2-14ce1e4b950f	af6132c7-bf30-4a86-be75-c3cf0d1b26d2	t
beec1c98-131e-4539-bb19-21867eb81576	4a12a751-36cc-4225-bee4-024f20c2382f	t
3f237d26-0988-482a-b1c2-14ce1e4b950f	c6931fbd-fa93-4bfb-a65d-178745dca064	t
\.


--
-- Data for Name: demande_utilisateur; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.demande_utilisateur (id, email, nom, nom_utilisateur, password, prenom, raw_password, role, send_date, entreprise_id) FROM stdin;
\.


--
-- Data for Name: entreprise; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.entreprise (id, nom_entreprise) FROM stdin;
1	bmw
2	orange
3	norsys afrique
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: facteur; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.facteur (id, update_date, created_date, is_deleted, active, emission_factor, nom, unit, type_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
6c27489a-09f0-4f82-adb7-422c45318e5d	beec1c98-131e-4539-bb19-21867eb81576	f	${role_default-roles}	default-roles-master	beec1c98-131e-4539-bb19-21867eb81576	\N	\N
1040ee85-dfed-48e4-98dd-d97e1931c40b	beec1c98-131e-4539-bb19-21867eb81576	f	${role_create-realm}	create-realm	beec1c98-131e-4539-bb19-21867eb81576	\N	\N
e7e163dd-4893-438a-abae-b5a59e640a97	beec1c98-131e-4539-bb19-21867eb81576	f	${role_admin}	admin	beec1c98-131e-4539-bb19-21867eb81576	\N	\N
ab53b2cc-b589-4b75-a1fa-137930e1b2bc	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_create-client}	create-client	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
7a4447ad-ffdd-44c4-99ac-253b340e59a8	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_view-realm}	view-realm	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
39553248-045f-4966-8505-2382f6365557	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_view-users}	view-users	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
62e5ce2b-27c0-44fc-af39-e362967fbe4e	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_view-clients}	view-clients	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
c1d1e66d-50c4-4d1b-9e9d-6b2b191e0205	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_view-events}	view-events	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
888b642f-04fd-4f85-9f82-a173e9cd558e	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_view-identity-providers}	view-identity-providers	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
7e4190fc-a547-4b8f-a5cf-72ff5a1ca254	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_view-authorization}	view-authorization	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
cf3bcf4b-f25f-4f23-87ca-ccc08deab6cd	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_manage-realm}	manage-realm	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
1f99680c-a902-4f57-870a-627b1e70a344	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_manage-users}	manage-users	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
9b69143e-d122-49f2-bf0f-d93a0d0ea555	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_manage-clients}	manage-clients	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
18fa80b5-aaf6-4ce2-a6d9-a2a423a1987d	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_manage-events}	manage-events	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
8a018078-33ac-4ded-bc37-7a8b55b93ba9	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_manage-identity-providers}	manage-identity-providers	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
b1debf07-6396-454c-94cc-2852bdc27c6f	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_manage-authorization}	manage-authorization	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
1bf0253f-23d8-48eb-b675-d40662c65333	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_query-users}	query-users	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
90e23467-4e97-49a1-bbe2-fcea102fb85c	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_query-clients}	query-clients	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
8d449f4d-d365-4192-baf3-1a631215c990	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_query-realms}	query-realms	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
82b768a5-3092-4c9f-8c39-296e7aa23d22	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_query-groups}	query-groups	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
ca024dfd-7fe2-4d57-ad10-e26b8b809ea7	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	t	${role_view-profile}	view-profile	beec1c98-131e-4539-bb19-21867eb81576	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	\N
71019e50-8f57-4708-b0ae-450a5da85ca5	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	t	${role_manage-account}	manage-account	beec1c98-131e-4539-bb19-21867eb81576	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	\N
2c5ed4d3-f23e-4d12-913e-ee7b46a5674f	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	t	${role_manage-account-links}	manage-account-links	beec1c98-131e-4539-bb19-21867eb81576	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	\N
46fc95d6-1a13-48a9-ab31-f6cf937cde43	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	t	${role_view-applications}	view-applications	beec1c98-131e-4539-bb19-21867eb81576	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	\N
6d28556c-e2a4-418c-9670-f6d902a6c6b5	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	t	${role_view-consent}	view-consent	beec1c98-131e-4539-bb19-21867eb81576	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	\N
c2f0a4b7-fcba-4d20-8da5-cba6e6fd9a7f	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	t	${role_manage-consent}	manage-consent	beec1c98-131e-4539-bb19-21867eb81576	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	\N
c784d174-b11d-406a-b566-20e679991519	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	t	${role_view-groups}	view-groups	beec1c98-131e-4539-bb19-21867eb81576	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	\N
b4c82bd4-bfbe-4ebf-99e6-41ea53dd2fb2	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	t	${role_delete-account}	delete-account	beec1c98-131e-4539-bb19-21867eb81576	7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	\N
143f8270-e416-4537-938f-8cb807107324	71d84a5d-e6df-4c82-beba-37f4f877fca6	t	${role_read-token}	read-token	beec1c98-131e-4539-bb19-21867eb81576	71d84a5d-e6df-4c82-beba-37f4f877fca6	\N
0674b9c1-570e-4232-ab3b-b485777a6698	556acc1e-30c6-4cec-bc2d-91c41bf9184b	t	${role_impersonation}	impersonation	beec1c98-131e-4539-bb19-21867eb81576	556acc1e-30c6-4cec-bc2d-91c41bf9184b	\N
43c69691-5960-48c7-9587-81efadfa7eff	beec1c98-131e-4539-bb19-21867eb81576	f	${role_offline-access}	offline_access	beec1c98-131e-4539-bb19-21867eb81576	\N	\N
9cc56e04-9700-4f6e-92dc-7761e2b85210	beec1c98-131e-4539-bb19-21867eb81576	f	${role_uma_authorization}	uma_authorization	beec1c98-131e-4539-bb19-21867eb81576	\N	\N
3c4e2f83-7e42-4a2f-9c34-21cdfb854a70	3f237d26-0988-482a-b1c2-14ce1e4b950f	f	${role_default-roles}	default-roles-bilancarbone	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N	\N
2e96d65d-6aa8-495c-9cc4-c1c1c02b0620	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_create-client}	create-client	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
b33f016d-ce02-4d82-afbe-0503e52fd425	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_view-realm}	view-realm	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
f9b952e1-f7ff-48db-ac5c-9856cac33c6e	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_view-users}	view-users	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
a7b852a3-12b4-4bbf-b5e1-548827c3f4e4	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_view-clients}	view-clients	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
162f97e3-636d-423b-be39-bb76d2a839f0	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_view-events}	view-events	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
62c268d3-a127-425b-b451-1823bb996a72	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_view-identity-providers}	view-identity-providers	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
2a3625d9-9b0d-4d68-b5dc-8bb4e668c0d7	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_view-authorization}	view-authorization	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
4942b676-bfa6-464d-8fa4-0f1ca1847916	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_manage-realm}	manage-realm	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
4dfacfc7-d6c1-460c-8b17-6e01cd8b3c09	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_manage-users}	manage-users	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
cc76babc-8f2b-4567-a58a-6d767a1c2d4f	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_manage-clients}	manage-clients	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
928001fe-b8b2-417d-8c6a-d79b4dc3debd	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_manage-events}	manage-events	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
4255f549-298a-4052-8919-d3b4054635b1	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_manage-identity-providers}	manage-identity-providers	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
65868ac8-63ec-4ede-a9c4-95ba7f52bc10	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_manage-authorization}	manage-authorization	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
ceb55e40-27dd-4c51-aa99-7ed04e20cb17	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_query-users}	query-users	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
1c5f38de-a1fe-4150-8bec-a24b7ba3c4da	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_query-clients}	query-clients	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
ac09856d-4d38-4af5-a9ef-56db668010f5	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_query-realms}	query-realms	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
77a42733-ab1f-4996-8573-223a980d4e7e	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_query-groups}	query-groups	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
6b042f3c-b82e-4e60-8efb-961cc5bb6a18	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_realm-admin}	realm-admin	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
b0219297-4967-4508-914d-eccb2b150360	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_create-client}	create-client	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
9b7d36a1-d3d5-4071-ad11-39053cc6fe1e	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_view-realm}	view-realm	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
c53f571c-5618-41e0-b45b-fa2d07b9f462	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_view-users}	view-users	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
9b47a21b-ad29-4286-949c-bbc7f4892fc9	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_view-clients}	view-clients	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
5aacf348-adf4-4b4e-a25b-370dfb5fc838	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_view-events}	view-events	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
64ab9867-dd1e-4589-adc1-941b852c618e	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_view-identity-providers}	view-identity-providers	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
7580e50e-5328-49c3-b261-f12761d0724e	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_view-authorization}	view-authorization	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
3ee68063-6fea-4e3f-8d0e-93752e91030f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_manage-realm}	manage-realm	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
1fa019c6-f295-44a3-b84a-4af8c14b0eb1	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_manage-users}	manage-users	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
d1cb561f-0d6f-415f-ac51-0f4c8c9ad4d2	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_manage-clients}	manage-clients	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
db96df6d-ba11-4e39-b976-92b92064c1cc	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_manage-events}	manage-events	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
31909272-dddb-4112-8577-0db3c1a7f5e3	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_manage-identity-providers}	manage-identity-providers	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
4d1c9d79-dd24-4168-bc38-db10c0468768	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_manage-authorization}	manage-authorization	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
aac20644-f3a3-4d62-88bd-de5615501116	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_query-users}	query-users	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
8cb66f25-41c9-4574-8776-16117e31b6b9	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_query-clients}	query-clients	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
c371afba-1447-47c1-a87e-08380bcc3073	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_query-realms}	query-realms	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
fe091d6c-b2cb-4adc-bb1b-323db3640f7c	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_query-groups}	query-groups	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
3f807fd7-6174-44cf-b199-359f6232320e	c40bb8d7-0215-4550-8dd1-758bb382ac19	t	${role_view-profile}	view-profile	3f237d26-0988-482a-b1c2-14ce1e4b950f	c40bb8d7-0215-4550-8dd1-758bb382ac19	\N
b264cfad-a71e-4ffd-8ada-a3dfc01628d6	c40bb8d7-0215-4550-8dd1-758bb382ac19	t	${role_manage-account}	manage-account	3f237d26-0988-482a-b1c2-14ce1e4b950f	c40bb8d7-0215-4550-8dd1-758bb382ac19	\N
dc332a66-bd3e-46fa-beef-09262155e199	c40bb8d7-0215-4550-8dd1-758bb382ac19	t	${role_manage-account-links}	manage-account-links	3f237d26-0988-482a-b1c2-14ce1e4b950f	c40bb8d7-0215-4550-8dd1-758bb382ac19	\N
c3209ca8-1eb7-4a0e-ac59-e5c9957d3831	c40bb8d7-0215-4550-8dd1-758bb382ac19	t	${role_view-applications}	view-applications	3f237d26-0988-482a-b1c2-14ce1e4b950f	c40bb8d7-0215-4550-8dd1-758bb382ac19	\N
63eff15a-18b1-40bb-bbb6-e0f2a4ae7452	c40bb8d7-0215-4550-8dd1-758bb382ac19	t	${role_view-consent}	view-consent	3f237d26-0988-482a-b1c2-14ce1e4b950f	c40bb8d7-0215-4550-8dd1-758bb382ac19	\N
92ed1938-ab02-4436-ac42-8487ccdab8ea	c40bb8d7-0215-4550-8dd1-758bb382ac19	t	${role_manage-consent}	manage-consent	3f237d26-0988-482a-b1c2-14ce1e4b950f	c40bb8d7-0215-4550-8dd1-758bb382ac19	\N
44f5ac06-3d80-4179-92eb-135e44936344	c40bb8d7-0215-4550-8dd1-758bb382ac19	t	${role_view-groups}	view-groups	3f237d26-0988-482a-b1c2-14ce1e4b950f	c40bb8d7-0215-4550-8dd1-758bb382ac19	\N
2c8ec5a2-63de-4660-9528-fb69fc6fd392	c40bb8d7-0215-4550-8dd1-758bb382ac19	t	${role_delete-account}	delete-account	3f237d26-0988-482a-b1c2-14ce1e4b950f	c40bb8d7-0215-4550-8dd1-758bb382ac19	\N
c24efa94-f09d-4b5d-9e6e-983bb6b88a41	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	t	${role_impersonation}	impersonation	beec1c98-131e-4539-bb19-21867eb81576	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	\N
5cac8d15-14f8-4c1e-8a8f-fd76b9e5c66d	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	t	${role_impersonation}	impersonation	3f237d26-0988-482a-b1c2-14ce1e4b950f	b0efdd8b-4e8f-4a31-b96a-54bf8c0e73b3	\N
b9d3e61b-3dfb-4e11-8bfa-5c2221d7a7a9	31419541-a326-4108-9e0a-a76318440af7	t	${role_read-token}	read-token	3f237d26-0988-482a-b1c2-14ce1e4b950f	31419541-a326-4108-9e0a-a76318440af7	\N
a6f65cb7-29ba-48a1-a3b2-0f9e1c9ed89c	3f237d26-0988-482a-b1c2-14ce1e4b950f	f	${role_offline-access}	offline_access	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N	\N
70937752-b8ea-4de2-80b2-01e0c3956701	3f237d26-0988-482a-b1c2-14ce1e4b950f	f	${role_uma_authorization}	uma_authorization	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N	\N
3905cfad-7099-45cc-a96d-685320385613	3f237d26-0988-482a-b1c2-14ce1e4b950f	f		ADMIN	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N	\N
0d833f8d-98cb-42be-9a07-4c1a0adf287b	3f237d26-0988-482a-b1c2-14ce1e4b950f	f		MANAGER	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N	\N
7c9ad2b9-d89b-4ff6-b625-3637de83d666	3f237d26-0988-482a-b1c2-14ce1e4b950f	f		EMPLOYE	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N	\N
0b84e58a-40f9-4c28-8277-fec564415174	3f237d26-0988-482a-b1c2-14ce1e4b950f	f		RESPONSABLE	3f237d26-0988-482a-b1c2-14ce1e4b950f	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.migration_model (id, version, update_time) FROM stdin;
9zbe1	23.0.6	1720703116
tt6wv	25.0.1	1721156538
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.org (id, enabled, realm_id, group_id, name, description) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
3e299b31-2d40-4a2f-8258-dfa647514b72	audience resolve	openid-connect	oidc-audience-resolve-mapper	01a41349-3ba2-42c9-ac22-e0ca3825646a	\N
cadb9789-b17a-46f6-83f7-7852ca06eb56	locale	openid-connect	oidc-usermodel-attribute-mapper	fe9194f3-05e6-491e-bbc9-9cdd7909a908	\N
e98448ae-3a06-431d-bd10-1c34970f88cf	role list	saml	saml-role-list-mapper	\N	b1241b05-3cc2-42f0-ad64-8e284154f84e
930b63a3-d7d5-4d5e-957a-d1e8f4319121	full name	openid-connect	oidc-full-name-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
f4651a29-3559-43f2-8ba5-2f0a9d7cb019	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
be6d580c-e3a5-4caa-bdac-a3493ddf377e	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
21ef8fcc-bce1-4dc5-8f7e-efda625e302a	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
8db82341-fa2c-451a-a5b6-caa9bc8bc965	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
59a0c9c8-de63-427f-94b8-187aedaf46fd	username	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
34fea3a3-ebf7-4012-a2c6-74208abdcc25	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
c20c1e4d-7cd2-49d4-a59a-17fea1a88284	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
0049a2f4-1562-451a-8351-87d63239aecb	website	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
9476d311-7456-441a-917d-ba92fca6a5cc	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
cfb0aa50-1944-410c-b897-7ae0162ec513	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
a6dbd42a-40fc-4563-9e2f-1ad2d200a3ea	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
8109db6b-3eeb-4db6-b318-ffc53c1e431a	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
344e7cbf-f10a-4d07-9a9d-ce0c2022dfb7	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	44e47a36-d5ce-4786-a838-fe715bd920cd
55b04f2f-e41a-4de8-98fd-551068526d77	email	openid-connect	oidc-usermodel-attribute-mapper	\N	10db96a7-cdd1-4640-866f-c1fb74376f56
3490e1ae-9f54-481b-af2d-e8ac3faa709f	email verified	openid-connect	oidc-usermodel-property-mapper	\N	10db96a7-cdd1-4640-866f-c1fb74376f56
d80d837e-2286-443b-b8ce-48ad639220f4	address	openid-connect	oidc-address-mapper	\N	d40894c3-a63e-414f-b77e-f55e36ec2517
aae5a64c-1d4c-41a3-8758-a2e4e106cd00	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	1c3296d1-1a84-4636-9b77-6b295ce40cd0
f1d1ca6a-32ce-45c7-ae62-a25e1a54b4e1	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	1c3296d1-1a84-4636-9b77-6b295ce40cd0
03226126-7515-4ac2-be26-7c3d119ccc95	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	2810fac0-79f6-4901-bb80-b4f43d14da21
d3e8edf1-18a7-4c57-af7e-7ba807034418	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	2810fac0-79f6-4901-bb80-b4f43d14da21
b3d29148-75b1-4076-a89f-3d7081d6720e	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	2810fac0-79f6-4901-bb80-b4f43d14da21
a1b98ae7-5588-423d-8496-2c7101e66378	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	458d374f-641a-4337-9732-419e2fe4f723
1ba4ce24-f005-42c8-95f9-ac7f8d9e0fb4	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	0fd78dd8-5193-49c1-9c96-49e9e9514b0e
ee787bd2-6aae-4d4c-9bb0-d06965162db5	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	0fd78dd8-5193-49c1-9c96-49e9e9514b0e
415e4e59-83bd-4816-848b-6b91e8db29b2	acr loa level	openid-connect	oidc-acr-mapper	\N	823578f0-ea54-4b92-8bab-7452e561cb62
632ffdcd-2c8d-45bb-a95d-ad3b5a9c83c3	audience resolve	openid-connect	oidc-audience-resolve-mapper	565f1b69-aa96-4c24-9f10-f5d921f0021e	\N
66d755fc-5b82-4e7c-aa09-2f4bce65e3e4	role list	saml	saml-role-list-mapper	\N	d0bffa34-9e1b-4fde-8d17-94be72dbd245
b203e92d-4921-45dd-8b37-694224052c52	full name	openid-connect	oidc-full-name-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
3fd303df-a25b-4669-9eb1-920fa8efc8ec	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
1709ca04-a132-45cc-afd1-d1613e1f8954	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
e626b7dd-f6c1-4962-9185-372b3a8226d7	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
747468f1-987b-4b97-8b1c-ba652542ad5e	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
67e15c38-1867-45a3-8f02-216796f1882f	username	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
d3159949-654d-4588-81f1-af52d236015e	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
d389c900-8239-43e6-89d5-a8c719193280	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
be8f8275-9e5c-43c8-80d3-240319f37832	website	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
c8e77fcc-1f51-410a-851c-8063819f64d6	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
bbc47f79-5bd1-4521-ac39-0d6c8711542d	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
024c16d3-7567-46ea-9c26-f4e22cad8dc5	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
8b176aef-cc3c-47a2-9a73-3d8f27ef276d	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
836220d7-11d6-4ee1-9cb1-19e6ac36ff94	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	90153c46-3b23-4d63-bbc5-9a532f66d2d2
31a6cd9c-f4df-4d28-aa05-ae2288874ab7	email	openid-connect	oidc-usermodel-attribute-mapper	\N	c7767e38-79ac-46c4-8663-f85874c53b0d
c5ce2711-1cd8-465c-8002-02a51e96bf49	email verified	openid-connect	oidc-usermodel-property-mapper	\N	c7767e38-79ac-46c4-8663-f85874c53b0d
e33c1128-c22c-4f0e-b2b7-801750a6e27c	address	openid-connect	oidc-address-mapper	\N	19478448-6652-4156-9da5-0553a62f542c
dee93477-3a09-4f59-a661-d1f7d6addc39	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	0516ee30-7eac-4173-a7e1-ab491ad2da7e
b3659003-8094-49de-bcdd-83bb526bbc5b	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	0516ee30-7eac-4173-a7e1-ab491ad2da7e
b44f4889-d9aa-4932-a51b-1e69bfa7f31b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	95efc217-3bef-4624-a9f0-b6cf64db3c68
2c8ce211-15d4-42af-baaa-2e460ea4cec1	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	95efc217-3bef-4624-a9f0-b6cf64db3c68
305a0421-7889-4da6-8ce3-6ee1649a6cb3	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	95efc217-3bef-4624-a9f0-b6cf64db3c68
14f6abcb-53a3-452b-9e0a-043d87f056c9	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	8a26ad4d-325f-4896-8e08-88716f5c1416
322a25c1-870d-4dc5-9b58-41732059d844	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	828ee37b-7285-4c85-9f29-827af6b2f189
dd0ecf20-f0ae-48f0-a5d4-33032a6666d3	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	828ee37b-7285-4c85-9f29-827af6b2f189
1a5af2e6-6cf8-4020-98b0-f2bb323cc88a	acr loa level	openid-connect	oidc-acr-mapper	\N	af6132c7-bf30-4a86-be75-c3cf0d1b26d2
576cd95a-1300-48f0-aa3e-21aa9323e41e	locale	openid-connect	oidc-usermodel-attribute-mapper	3a4802dd-0117-4eae-969d-d768b001c0ca	\N
68a44464-b6ff-413b-89d9-7ec8ec15f9f1	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	4a12a751-36cc-4225-bee4-024f20c2382f
2fd0148b-0f4a-4d75-9652-d4794637e3cf	sub	openid-connect	oidc-sub-mapper	\N	4a12a751-36cc-4225-bee4-024f20c2382f
88b97066-4572-46a2-8dd2-8468628f1980	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	c6931fbd-fa93-4bfb-a65d-178745dca064
bf734cbc-fe76-4b33-a140-fa8310c5668f	sub	openid-connect	oidc-sub-mapper	\N	c6931fbd-fa93-4bfb-a65d-178745dca064
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
cadb9789-b17a-46f6-83f7-7852ca06eb56	true	introspection.token.claim
cadb9789-b17a-46f6-83f7-7852ca06eb56	true	userinfo.token.claim
cadb9789-b17a-46f6-83f7-7852ca06eb56	locale	user.attribute
cadb9789-b17a-46f6-83f7-7852ca06eb56	true	id.token.claim
cadb9789-b17a-46f6-83f7-7852ca06eb56	true	access.token.claim
cadb9789-b17a-46f6-83f7-7852ca06eb56	locale	claim.name
cadb9789-b17a-46f6-83f7-7852ca06eb56	String	jsonType.label
e98448ae-3a06-431d-bd10-1c34970f88cf	false	single
e98448ae-3a06-431d-bd10-1c34970f88cf	Basic	attribute.nameformat
e98448ae-3a06-431d-bd10-1c34970f88cf	Role	attribute.name
0049a2f4-1562-451a-8351-87d63239aecb	true	introspection.token.claim
0049a2f4-1562-451a-8351-87d63239aecb	true	userinfo.token.claim
0049a2f4-1562-451a-8351-87d63239aecb	website	user.attribute
0049a2f4-1562-451a-8351-87d63239aecb	true	id.token.claim
0049a2f4-1562-451a-8351-87d63239aecb	true	access.token.claim
0049a2f4-1562-451a-8351-87d63239aecb	website	claim.name
0049a2f4-1562-451a-8351-87d63239aecb	String	jsonType.label
21ef8fcc-bce1-4dc5-8f7e-efda625e302a	true	introspection.token.claim
21ef8fcc-bce1-4dc5-8f7e-efda625e302a	true	userinfo.token.claim
21ef8fcc-bce1-4dc5-8f7e-efda625e302a	middleName	user.attribute
21ef8fcc-bce1-4dc5-8f7e-efda625e302a	true	id.token.claim
21ef8fcc-bce1-4dc5-8f7e-efda625e302a	true	access.token.claim
21ef8fcc-bce1-4dc5-8f7e-efda625e302a	middle_name	claim.name
21ef8fcc-bce1-4dc5-8f7e-efda625e302a	String	jsonType.label
344e7cbf-f10a-4d07-9a9d-ce0c2022dfb7	true	introspection.token.claim
344e7cbf-f10a-4d07-9a9d-ce0c2022dfb7	true	userinfo.token.claim
344e7cbf-f10a-4d07-9a9d-ce0c2022dfb7	updatedAt	user.attribute
344e7cbf-f10a-4d07-9a9d-ce0c2022dfb7	true	id.token.claim
344e7cbf-f10a-4d07-9a9d-ce0c2022dfb7	true	access.token.claim
344e7cbf-f10a-4d07-9a9d-ce0c2022dfb7	updated_at	claim.name
344e7cbf-f10a-4d07-9a9d-ce0c2022dfb7	long	jsonType.label
34fea3a3-ebf7-4012-a2c6-74208abdcc25	true	introspection.token.claim
34fea3a3-ebf7-4012-a2c6-74208abdcc25	true	userinfo.token.claim
34fea3a3-ebf7-4012-a2c6-74208abdcc25	profile	user.attribute
34fea3a3-ebf7-4012-a2c6-74208abdcc25	true	id.token.claim
34fea3a3-ebf7-4012-a2c6-74208abdcc25	true	access.token.claim
34fea3a3-ebf7-4012-a2c6-74208abdcc25	profile	claim.name
34fea3a3-ebf7-4012-a2c6-74208abdcc25	String	jsonType.label
59a0c9c8-de63-427f-94b8-187aedaf46fd	true	introspection.token.claim
59a0c9c8-de63-427f-94b8-187aedaf46fd	true	userinfo.token.claim
59a0c9c8-de63-427f-94b8-187aedaf46fd	username	user.attribute
59a0c9c8-de63-427f-94b8-187aedaf46fd	true	id.token.claim
59a0c9c8-de63-427f-94b8-187aedaf46fd	true	access.token.claim
59a0c9c8-de63-427f-94b8-187aedaf46fd	preferred_username	claim.name
59a0c9c8-de63-427f-94b8-187aedaf46fd	String	jsonType.label
8109db6b-3eeb-4db6-b318-ffc53c1e431a	true	introspection.token.claim
8109db6b-3eeb-4db6-b318-ffc53c1e431a	true	userinfo.token.claim
8109db6b-3eeb-4db6-b318-ffc53c1e431a	locale	user.attribute
8109db6b-3eeb-4db6-b318-ffc53c1e431a	true	id.token.claim
8109db6b-3eeb-4db6-b318-ffc53c1e431a	true	access.token.claim
8109db6b-3eeb-4db6-b318-ffc53c1e431a	locale	claim.name
8109db6b-3eeb-4db6-b318-ffc53c1e431a	String	jsonType.label
8db82341-fa2c-451a-a5b6-caa9bc8bc965	true	introspection.token.claim
8db82341-fa2c-451a-a5b6-caa9bc8bc965	true	userinfo.token.claim
8db82341-fa2c-451a-a5b6-caa9bc8bc965	nickname	user.attribute
8db82341-fa2c-451a-a5b6-caa9bc8bc965	true	id.token.claim
8db82341-fa2c-451a-a5b6-caa9bc8bc965	true	access.token.claim
8db82341-fa2c-451a-a5b6-caa9bc8bc965	nickname	claim.name
8db82341-fa2c-451a-a5b6-caa9bc8bc965	String	jsonType.label
930b63a3-d7d5-4d5e-957a-d1e8f4319121	true	introspection.token.claim
930b63a3-d7d5-4d5e-957a-d1e8f4319121	true	userinfo.token.claim
930b63a3-d7d5-4d5e-957a-d1e8f4319121	true	id.token.claim
930b63a3-d7d5-4d5e-957a-d1e8f4319121	true	access.token.claim
9476d311-7456-441a-917d-ba92fca6a5cc	true	introspection.token.claim
9476d311-7456-441a-917d-ba92fca6a5cc	true	userinfo.token.claim
9476d311-7456-441a-917d-ba92fca6a5cc	gender	user.attribute
9476d311-7456-441a-917d-ba92fca6a5cc	true	id.token.claim
9476d311-7456-441a-917d-ba92fca6a5cc	true	access.token.claim
9476d311-7456-441a-917d-ba92fca6a5cc	gender	claim.name
9476d311-7456-441a-917d-ba92fca6a5cc	String	jsonType.label
a6dbd42a-40fc-4563-9e2f-1ad2d200a3ea	true	introspection.token.claim
a6dbd42a-40fc-4563-9e2f-1ad2d200a3ea	true	userinfo.token.claim
a6dbd42a-40fc-4563-9e2f-1ad2d200a3ea	zoneinfo	user.attribute
a6dbd42a-40fc-4563-9e2f-1ad2d200a3ea	true	id.token.claim
a6dbd42a-40fc-4563-9e2f-1ad2d200a3ea	true	access.token.claim
a6dbd42a-40fc-4563-9e2f-1ad2d200a3ea	zoneinfo	claim.name
a6dbd42a-40fc-4563-9e2f-1ad2d200a3ea	String	jsonType.label
be6d580c-e3a5-4caa-bdac-a3493ddf377e	true	introspection.token.claim
be6d580c-e3a5-4caa-bdac-a3493ddf377e	true	userinfo.token.claim
be6d580c-e3a5-4caa-bdac-a3493ddf377e	firstName	user.attribute
be6d580c-e3a5-4caa-bdac-a3493ddf377e	true	id.token.claim
be6d580c-e3a5-4caa-bdac-a3493ddf377e	true	access.token.claim
be6d580c-e3a5-4caa-bdac-a3493ddf377e	given_name	claim.name
be6d580c-e3a5-4caa-bdac-a3493ddf377e	String	jsonType.label
c20c1e4d-7cd2-49d4-a59a-17fea1a88284	true	introspection.token.claim
c20c1e4d-7cd2-49d4-a59a-17fea1a88284	true	userinfo.token.claim
c20c1e4d-7cd2-49d4-a59a-17fea1a88284	picture	user.attribute
c20c1e4d-7cd2-49d4-a59a-17fea1a88284	true	id.token.claim
c20c1e4d-7cd2-49d4-a59a-17fea1a88284	true	access.token.claim
c20c1e4d-7cd2-49d4-a59a-17fea1a88284	picture	claim.name
c20c1e4d-7cd2-49d4-a59a-17fea1a88284	String	jsonType.label
cfb0aa50-1944-410c-b897-7ae0162ec513	true	introspection.token.claim
cfb0aa50-1944-410c-b897-7ae0162ec513	true	userinfo.token.claim
cfb0aa50-1944-410c-b897-7ae0162ec513	birthdate	user.attribute
cfb0aa50-1944-410c-b897-7ae0162ec513	true	id.token.claim
cfb0aa50-1944-410c-b897-7ae0162ec513	true	access.token.claim
cfb0aa50-1944-410c-b897-7ae0162ec513	birthdate	claim.name
cfb0aa50-1944-410c-b897-7ae0162ec513	String	jsonType.label
f4651a29-3559-43f2-8ba5-2f0a9d7cb019	true	introspection.token.claim
f4651a29-3559-43f2-8ba5-2f0a9d7cb019	true	userinfo.token.claim
f4651a29-3559-43f2-8ba5-2f0a9d7cb019	lastName	user.attribute
f4651a29-3559-43f2-8ba5-2f0a9d7cb019	true	id.token.claim
f4651a29-3559-43f2-8ba5-2f0a9d7cb019	true	access.token.claim
f4651a29-3559-43f2-8ba5-2f0a9d7cb019	family_name	claim.name
f4651a29-3559-43f2-8ba5-2f0a9d7cb019	String	jsonType.label
3490e1ae-9f54-481b-af2d-e8ac3faa709f	true	introspection.token.claim
3490e1ae-9f54-481b-af2d-e8ac3faa709f	true	userinfo.token.claim
3490e1ae-9f54-481b-af2d-e8ac3faa709f	emailVerified	user.attribute
3490e1ae-9f54-481b-af2d-e8ac3faa709f	true	id.token.claim
3490e1ae-9f54-481b-af2d-e8ac3faa709f	true	access.token.claim
3490e1ae-9f54-481b-af2d-e8ac3faa709f	email_verified	claim.name
3490e1ae-9f54-481b-af2d-e8ac3faa709f	boolean	jsonType.label
55b04f2f-e41a-4de8-98fd-551068526d77	true	introspection.token.claim
55b04f2f-e41a-4de8-98fd-551068526d77	true	userinfo.token.claim
55b04f2f-e41a-4de8-98fd-551068526d77	email	user.attribute
55b04f2f-e41a-4de8-98fd-551068526d77	true	id.token.claim
55b04f2f-e41a-4de8-98fd-551068526d77	true	access.token.claim
55b04f2f-e41a-4de8-98fd-551068526d77	email	claim.name
55b04f2f-e41a-4de8-98fd-551068526d77	String	jsonType.label
d80d837e-2286-443b-b8ce-48ad639220f4	formatted	user.attribute.formatted
d80d837e-2286-443b-b8ce-48ad639220f4	country	user.attribute.country
d80d837e-2286-443b-b8ce-48ad639220f4	true	introspection.token.claim
d80d837e-2286-443b-b8ce-48ad639220f4	postal_code	user.attribute.postal_code
d80d837e-2286-443b-b8ce-48ad639220f4	true	userinfo.token.claim
d80d837e-2286-443b-b8ce-48ad639220f4	street	user.attribute.street
d80d837e-2286-443b-b8ce-48ad639220f4	true	id.token.claim
d80d837e-2286-443b-b8ce-48ad639220f4	region	user.attribute.region
d80d837e-2286-443b-b8ce-48ad639220f4	true	access.token.claim
d80d837e-2286-443b-b8ce-48ad639220f4	locality	user.attribute.locality
aae5a64c-1d4c-41a3-8758-a2e4e106cd00	true	introspection.token.claim
aae5a64c-1d4c-41a3-8758-a2e4e106cd00	true	userinfo.token.claim
aae5a64c-1d4c-41a3-8758-a2e4e106cd00	phoneNumber	user.attribute
aae5a64c-1d4c-41a3-8758-a2e4e106cd00	true	id.token.claim
aae5a64c-1d4c-41a3-8758-a2e4e106cd00	true	access.token.claim
aae5a64c-1d4c-41a3-8758-a2e4e106cd00	phone_number	claim.name
aae5a64c-1d4c-41a3-8758-a2e4e106cd00	String	jsonType.label
f1d1ca6a-32ce-45c7-ae62-a25e1a54b4e1	true	introspection.token.claim
f1d1ca6a-32ce-45c7-ae62-a25e1a54b4e1	true	userinfo.token.claim
f1d1ca6a-32ce-45c7-ae62-a25e1a54b4e1	phoneNumberVerified	user.attribute
f1d1ca6a-32ce-45c7-ae62-a25e1a54b4e1	true	id.token.claim
f1d1ca6a-32ce-45c7-ae62-a25e1a54b4e1	true	access.token.claim
f1d1ca6a-32ce-45c7-ae62-a25e1a54b4e1	phone_number_verified	claim.name
f1d1ca6a-32ce-45c7-ae62-a25e1a54b4e1	boolean	jsonType.label
03226126-7515-4ac2-be26-7c3d119ccc95	true	introspection.token.claim
03226126-7515-4ac2-be26-7c3d119ccc95	true	multivalued
03226126-7515-4ac2-be26-7c3d119ccc95	foo	user.attribute
03226126-7515-4ac2-be26-7c3d119ccc95	true	access.token.claim
03226126-7515-4ac2-be26-7c3d119ccc95	realm_access.roles	claim.name
03226126-7515-4ac2-be26-7c3d119ccc95	String	jsonType.label
b3d29148-75b1-4076-a89f-3d7081d6720e	true	introspection.token.claim
b3d29148-75b1-4076-a89f-3d7081d6720e	true	access.token.claim
d3e8edf1-18a7-4c57-af7e-7ba807034418	true	introspection.token.claim
d3e8edf1-18a7-4c57-af7e-7ba807034418	true	multivalued
d3e8edf1-18a7-4c57-af7e-7ba807034418	foo	user.attribute
d3e8edf1-18a7-4c57-af7e-7ba807034418	true	access.token.claim
d3e8edf1-18a7-4c57-af7e-7ba807034418	resource_access.${client_id}.roles	claim.name
d3e8edf1-18a7-4c57-af7e-7ba807034418	String	jsonType.label
a1b98ae7-5588-423d-8496-2c7101e66378	true	introspection.token.claim
a1b98ae7-5588-423d-8496-2c7101e66378	true	access.token.claim
1ba4ce24-f005-42c8-95f9-ac7f8d9e0fb4	true	introspection.token.claim
1ba4ce24-f005-42c8-95f9-ac7f8d9e0fb4	true	userinfo.token.claim
1ba4ce24-f005-42c8-95f9-ac7f8d9e0fb4	username	user.attribute
1ba4ce24-f005-42c8-95f9-ac7f8d9e0fb4	true	id.token.claim
1ba4ce24-f005-42c8-95f9-ac7f8d9e0fb4	true	access.token.claim
1ba4ce24-f005-42c8-95f9-ac7f8d9e0fb4	upn	claim.name
1ba4ce24-f005-42c8-95f9-ac7f8d9e0fb4	String	jsonType.label
ee787bd2-6aae-4d4c-9bb0-d06965162db5	true	introspection.token.claim
ee787bd2-6aae-4d4c-9bb0-d06965162db5	true	multivalued
ee787bd2-6aae-4d4c-9bb0-d06965162db5	foo	user.attribute
ee787bd2-6aae-4d4c-9bb0-d06965162db5	true	id.token.claim
ee787bd2-6aae-4d4c-9bb0-d06965162db5	true	access.token.claim
ee787bd2-6aae-4d4c-9bb0-d06965162db5	groups	claim.name
ee787bd2-6aae-4d4c-9bb0-d06965162db5	String	jsonType.label
415e4e59-83bd-4816-848b-6b91e8db29b2	true	introspection.token.claim
415e4e59-83bd-4816-848b-6b91e8db29b2	true	id.token.claim
415e4e59-83bd-4816-848b-6b91e8db29b2	true	access.token.claim
66d755fc-5b82-4e7c-aa09-2f4bce65e3e4	false	single
66d755fc-5b82-4e7c-aa09-2f4bce65e3e4	Basic	attribute.nameformat
66d755fc-5b82-4e7c-aa09-2f4bce65e3e4	Role	attribute.name
024c16d3-7567-46ea-9c26-f4e22cad8dc5	true	introspection.token.claim
024c16d3-7567-46ea-9c26-f4e22cad8dc5	true	userinfo.token.claim
024c16d3-7567-46ea-9c26-f4e22cad8dc5	zoneinfo	user.attribute
024c16d3-7567-46ea-9c26-f4e22cad8dc5	true	id.token.claim
024c16d3-7567-46ea-9c26-f4e22cad8dc5	true	access.token.claim
024c16d3-7567-46ea-9c26-f4e22cad8dc5	zoneinfo	claim.name
024c16d3-7567-46ea-9c26-f4e22cad8dc5	String	jsonType.label
1709ca04-a132-45cc-afd1-d1613e1f8954	true	introspection.token.claim
1709ca04-a132-45cc-afd1-d1613e1f8954	true	userinfo.token.claim
1709ca04-a132-45cc-afd1-d1613e1f8954	firstName	user.attribute
1709ca04-a132-45cc-afd1-d1613e1f8954	true	id.token.claim
1709ca04-a132-45cc-afd1-d1613e1f8954	true	access.token.claim
1709ca04-a132-45cc-afd1-d1613e1f8954	given_name	claim.name
1709ca04-a132-45cc-afd1-d1613e1f8954	String	jsonType.label
3fd303df-a25b-4669-9eb1-920fa8efc8ec	true	introspection.token.claim
3fd303df-a25b-4669-9eb1-920fa8efc8ec	true	userinfo.token.claim
3fd303df-a25b-4669-9eb1-920fa8efc8ec	lastName	user.attribute
3fd303df-a25b-4669-9eb1-920fa8efc8ec	true	id.token.claim
3fd303df-a25b-4669-9eb1-920fa8efc8ec	true	access.token.claim
3fd303df-a25b-4669-9eb1-920fa8efc8ec	family_name	claim.name
3fd303df-a25b-4669-9eb1-920fa8efc8ec	String	jsonType.label
67e15c38-1867-45a3-8f02-216796f1882f	true	introspection.token.claim
67e15c38-1867-45a3-8f02-216796f1882f	true	userinfo.token.claim
67e15c38-1867-45a3-8f02-216796f1882f	username	user.attribute
67e15c38-1867-45a3-8f02-216796f1882f	true	id.token.claim
67e15c38-1867-45a3-8f02-216796f1882f	true	access.token.claim
67e15c38-1867-45a3-8f02-216796f1882f	preferred_username	claim.name
67e15c38-1867-45a3-8f02-216796f1882f	String	jsonType.label
747468f1-987b-4b97-8b1c-ba652542ad5e	true	introspection.token.claim
747468f1-987b-4b97-8b1c-ba652542ad5e	true	userinfo.token.claim
747468f1-987b-4b97-8b1c-ba652542ad5e	nickname	user.attribute
747468f1-987b-4b97-8b1c-ba652542ad5e	true	id.token.claim
747468f1-987b-4b97-8b1c-ba652542ad5e	true	access.token.claim
747468f1-987b-4b97-8b1c-ba652542ad5e	nickname	claim.name
747468f1-987b-4b97-8b1c-ba652542ad5e	String	jsonType.label
836220d7-11d6-4ee1-9cb1-19e6ac36ff94	true	introspection.token.claim
836220d7-11d6-4ee1-9cb1-19e6ac36ff94	true	userinfo.token.claim
836220d7-11d6-4ee1-9cb1-19e6ac36ff94	updatedAt	user.attribute
836220d7-11d6-4ee1-9cb1-19e6ac36ff94	true	id.token.claim
836220d7-11d6-4ee1-9cb1-19e6ac36ff94	true	access.token.claim
836220d7-11d6-4ee1-9cb1-19e6ac36ff94	updated_at	claim.name
836220d7-11d6-4ee1-9cb1-19e6ac36ff94	long	jsonType.label
8b176aef-cc3c-47a2-9a73-3d8f27ef276d	true	introspection.token.claim
8b176aef-cc3c-47a2-9a73-3d8f27ef276d	true	userinfo.token.claim
8b176aef-cc3c-47a2-9a73-3d8f27ef276d	locale	user.attribute
8b176aef-cc3c-47a2-9a73-3d8f27ef276d	true	id.token.claim
8b176aef-cc3c-47a2-9a73-3d8f27ef276d	true	access.token.claim
8b176aef-cc3c-47a2-9a73-3d8f27ef276d	locale	claim.name
8b176aef-cc3c-47a2-9a73-3d8f27ef276d	String	jsonType.label
b203e92d-4921-45dd-8b37-694224052c52	true	introspection.token.claim
b203e92d-4921-45dd-8b37-694224052c52	true	userinfo.token.claim
b203e92d-4921-45dd-8b37-694224052c52	true	id.token.claim
b203e92d-4921-45dd-8b37-694224052c52	true	access.token.claim
bbc47f79-5bd1-4521-ac39-0d6c8711542d	true	introspection.token.claim
bbc47f79-5bd1-4521-ac39-0d6c8711542d	true	userinfo.token.claim
bbc47f79-5bd1-4521-ac39-0d6c8711542d	birthdate	user.attribute
bbc47f79-5bd1-4521-ac39-0d6c8711542d	true	id.token.claim
bbc47f79-5bd1-4521-ac39-0d6c8711542d	true	access.token.claim
bbc47f79-5bd1-4521-ac39-0d6c8711542d	birthdate	claim.name
bbc47f79-5bd1-4521-ac39-0d6c8711542d	String	jsonType.label
be8f8275-9e5c-43c8-80d3-240319f37832	true	introspection.token.claim
be8f8275-9e5c-43c8-80d3-240319f37832	true	userinfo.token.claim
be8f8275-9e5c-43c8-80d3-240319f37832	website	user.attribute
be8f8275-9e5c-43c8-80d3-240319f37832	true	id.token.claim
be8f8275-9e5c-43c8-80d3-240319f37832	true	access.token.claim
be8f8275-9e5c-43c8-80d3-240319f37832	website	claim.name
be8f8275-9e5c-43c8-80d3-240319f37832	String	jsonType.label
c8e77fcc-1f51-410a-851c-8063819f64d6	true	introspection.token.claim
c8e77fcc-1f51-410a-851c-8063819f64d6	true	userinfo.token.claim
c8e77fcc-1f51-410a-851c-8063819f64d6	gender	user.attribute
c8e77fcc-1f51-410a-851c-8063819f64d6	true	id.token.claim
c8e77fcc-1f51-410a-851c-8063819f64d6	true	access.token.claim
c8e77fcc-1f51-410a-851c-8063819f64d6	gender	claim.name
c8e77fcc-1f51-410a-851c-8063819f64d6	String	jsonType.label
d3159949-654d-4588-81f1-af52d236015e	true	introspection.token.claim
d3159949-654d-4588-81f1-af52d236015e	true	userinfo.token.claim
d3159949-654d-4588-81f1-af52d236015e	profile	user.attribute
d3159949-654d-4588-81f1-af52d236015e	true	id.token.claim
d3159949-654d-4588-81f1-af52d236015e	true	access.token.claim
d3159949-654d-4588-81f1-af52d236015e	profile	claim.name
d3159949-654d-4588-81f1-af52d236015e	String	jsonType.label
d389c900-8239-43e6-89d5-a8c719193280	true	introspection.token.claim
d389c900-8239-43e6-89d5-a8c719193280	true	userinfo.token.claim
d389c900-8239-43e6-89d5-a8c719193280	picture	user.attribute
d389c900-8239-43e6-89d5-a8c719193280	true	id.token.claim
d389c900-8239-43e6-89d5-a8c719193280	true	access.token.claim
d389c900-8239-43e6-89d5-a8c719193280	picture	claim.name
d389c900-8239-43e6-89d5-a8c719193280	String	jsonType.label
e626b7dd-f6c1-4962-9185-372b3a8226d7	true	introspection.token.claim
e626b7dd-f6c1-4962-9185-372b3a8226d7	true	userinfo.token.claim
e626b7dd-f6c1-4962-9185-372b3a8226d7	middleName	user.attribute
e626b7dd-f6c1-4962-9185-372b3a8226d7	true	id.token.claim
e626b7dd-f6c1-4962-9185-372b3a8226d7	true	access.token.claim
e626b7dd-f6c1-4962-9185-372b3a8226d7	middle_name	claim.name
e626b7dd-f6c1-4962-9185-372b3a8226d7	String	jsonType.label
31a6cd9c-f4df-4d28-aa05-ae2288874ab7	true	introspection.token.claim
31a6cd9c-f4df-4d28-aa05-ae2288874ab7	true	userinfo.token.claim
31a6cd9c-f4df-4d28-aa05-ae2288874ab7	email	user.attribute
31a6cd9c-f4df-4d28-aa05-ae2288874ab7	true	id.token.claim
31a6cd9c-f4df-4d28-aa05-ae2288874ab7	true	access.token.claim
31a6cd9c-f4df-4d28-aa05-ae2288874ab7	email	claim.name
31a6cd9c-f4df-4d28-aa05-ae2288874ab7	String	jsonType.label
c5ce2711-1cd8-465c-8002-02a51e96bf49	true	introspection.token.claim
c5ce2711-1cd8-465c-8002-02a51e96bf49	true	userinfo.token.claim
c5ce2711-1cd8-465c-8002-02a51e96bf49	emailVerified	user.attribute
c5ce2711-1cd8-465c-8002-02a51e96bf49	true	id.token.claim
c5ce2711-1cd8-465c-8002-02a51e96bf49	true	access.token.claim
c5ce2711-1cd8-465c-8002-02a51e96bf49	email_verified	claim.name
c5ce2711-1cd8-465c-8002-02a51e96bf49	boolean	jsonType.label
e33c1128-c22c-4f0e-b2b7-801750a6e27c	formatted	user.attribute.formatted
e33c1128-c22c-4f0e-b2b7-801750a6e27c	country	user.attribute.country
e33c1128-c22c-4f0e-b2b7-801750a6e27c	true	introspection.token.claim
e33c1128-c22c-4f0e-b2b7-801750a6e27c	postal_code	user.attribute.postal_code
e33c1128-c22c-4f0e-b2b7-801750a6e27c	true	userinfo.token.claim
e33c1128-c22c-4f0e-b2b7-801750a6e27c	street	user.attribute.street
e33c1128-c22c-4f0e-b2b7-801750a6e27c	true	id.token.claim
e33c1128-c22c-4f0e-b2b7-801750a6e27c	region	user.attribute.region
e33c1128-c22c-4f0e-b2b7-801750a6e27c	true	access.token.claim
e33c1128-c22c-4f0e-b2b7-801750a6e27c	locality	user.attribute.locality
b3659003-8094-49de-bcdd-83bb526bbc5b	true	introspection.token.claim
b3659003-8094-49de-bcdd-83bb526bbc5b	true	userinfo.token.claim
b3659003-8094-49de-bcdd-83bb526bbc5b	phoneNumberVerified	user.attribute
b3659003-8094-49de-bcdd-83bb526bbc5b	true	id.token.claim
b3659003-8094-49de-bcdd-83bb526bbc5b	true	access.token.claim
b3659003-8094-49de-bcdd-83bb526bbc5b	phone_number_verified	claim.name
b3659003-8094-49de-bcdd-83bb526bbc5b	boolean	jsonType.label
dee93477-3a09-4f59-a661-d1f7d6addc39	true	introspection.token.claim
dee93477-3a09-4f59-a661-d1f7d6addc39	true	userinfo.token.claim
dee93477-3a09-4f59-a661-d1f7d6addc39	phoneNumber	user.attribute
dee93477-3a09-4f59-a661-d1f7d6addc39	true	id.token.claim
dee93477-3a09-4f59-a661-d1f7d6addc39	true	access.token.claim
dee93477-3a09-4f59-a661-d1f7d6addc39	phone_number	claim.name
dee93477-3a09-4f59-a661-d1f7d6addc39	String	jsonType.label
2c8ce211-15d4-42af-baaa-2e460ea4cec1	true	introspection.token.claim
2c8ce211-15d4-42af-baaa-2e460ea4cec1	true	multivalued
2c8ce211-15d4-42af-baaa-2e460ea4cec1	foo	user.attribute
2c8ce211-15d4-42af-baaa-2e460ea4cec1	true	access.token.claim
2c8ce211-15d4-42af-baaa-2e460ea4cec1	resource_access.${client_id}.roles	claim.name
2c8ce211-15d4-42af-baaa-2e460ea4cec1	String	jsonType.label
305a0421-7889-4da6-8ce3-6ee1649a6cb3	true	introspection.token.claim
305a0421-7889-4da6-8ce3-6ee1649a6cb3	true	access.token.claim
b44f4889-d9aa-4932-a51b-1e69bfa7f31b	true	introspection.token.claim
b44f4889-d9aa-4932-a51b-1e69bfa7f31b	true	multivalued
b44f4889-d9aa-4932-a51b-1e69bfa7f31b	foo	user.attribute
b44f4889-d9aa-4932-a51b-1e69bfa7f31b	true	access.token.claim
b44f4889-d9aa-4932-a51b-1e69bfa7f31b	realm_access.roles	claim.name
b44f4889-d9aa-4932-a51b-1e69bfa7f31b	String	jsonType.label
14f6abcb-53a3-452b-9e0a-043d87f056c9	true	introspection.token.claim
14f6abcb-53a3-452b-9e0a-043d87f056c9	true	access.token.claim
322a25c1-870d-4dc5-9b58-41732059d844	true	introspection.token.claim
322a25c1-870d-4dc5-9b58-41732059d844	true	userinfo.token.claim
322a25c1-870d-4dc5-9b58-41732059d844	username	user.attribute
322a25c1-870d-4dc5-9b58-41732059d844	true	id.token.claim
322a25c1-870d-4dc5-9b58-41732059d844	true	access.token.claim
322a25c1-870d-4dc5-9b58-41732059d844	upn	claim.name
322a25c1-870d-4dc5-9b58-41732059d844	String	jsonType.label
dd0ecf20-f0ae-48f0-a5d4-33032a6666d3	true	introspection.token.claim
dd0ecf20-f0ae-48f0-a5d4-33032a6666d3	true	multivalued
dd0ecf20-f0ae-48f0-a5d4-33032a6666d3	foo	user.attribute
dd0ecf20-f0ae-48f0-a5d4-33032a6666d3	true	id.token.claim
dd0ecf20-f0ae-48f0-a5d4-33032a6666d3	true	access.token.claim
dd0ecf20-f0ae-48f0-a5d4-33032a6666d3	groups	claim.name
dd0ecf20-f0ae-48f0-a5d4-33032a6666d3	String	jsonType.label
1a5af2e6-6cf8-4020-98b0-f2bb323cc88a	true	introspection.token.claim
1a5af2e6-6cf8-4020-98b0-f2bb323cc88a	true	id.token.claim
1a5af2e6-6cf8-4020-98b0-f2bb323cc88a	true	access.token.claim
576cd95a-1300-48f0-aa3e-21aa9323e41e	true	introspection.token.claim
576cd95a-1300-48f0-aa3e-21aa9323e41e	true	userinfo.token.claim
576cd95a-1300-48f0-aa3e-21aa9323e41e	locale	user.attribute
576cd95a-1300-48f0-aa3e-21aa9323e41e	true	id.token.claim
576cd95a-1300-48f0-aa3e-21aa9323e41e	true	access.token.claim
576cd95a-1300-48f0-aa3e-21aa9323e41e	locale	claim.name
576cd95a-1300-48f0-aa3e-21aa9323e41e	String	jsonType.label
2fd0148b-0f4a-4d75-9652-d4794637e3cf	true	introspection.token.claim
2fd0148b-0f4a-4d75-9652-d4794637e3cf	true	access.token.claim
68a44464-b6ff-413b-89d9-7ec8ec15f9f1	AUTH_TIME	user.session.note
68a44464-b6ff-413b-89d9-7ec8ec15f9f1	true	introspection.token.claim
68a44464-b6ff-413b-89d9-7ec8ec15f9f1	true	id.token.claim
68a44464-b6ff-413b-89d9-7ec8ec15f9f1	true	access.token.claim
68a44464-b6ff-413b-89d9-7ec8ec15f9f1	auth_time	claim.name
68a44464-b6ff-413b-89d9-7ec8ec15f9f1	long	jsonType.label
88b97066-4572-46a2-8dd2-8468628f1980	AUTH_TIME	user.session.note
88b97066-4572-46a2-8dd2-8468628f1980	true	introspection.token.claim
88b97066-4572-46a2-8dd2-8468628f1980	true	id.token.claim
88b97066-4572-46a2-8dd2-8468628f1980	true	access.token.claim
88b97066-4572-46a2-8dd2-8468628f1980	auth_time	claim.name
88b97066-4572-46a2-8dd2-8468628f1980	long	jsonType.label
bf734cbc-fe76-4b33-a140-fa8310c5668f	true	introspection.token.claim
bf734cbc-fe76-4b33-a140-fa8310c5668f	true	access.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
3f237d26-0988-482a-b1c2-14ce1e4b950f	60	300	1800				t	f	0	keycloak	BilanCarbone	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	fccd0375-ab73-4f1b-abf5-b63cd4f03f50	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	df5f1c24-9bd9-4127-b0a8-89397cc094e6	d9906c0c-53e1-46a7-8760-26ebb6a1b638	24664842-4926-4d66-b1de-9e663a4562a1	1352d643-b386-40c1-a7c8-4bfbbc2a73b2	77c540dc-d8c3-47c2-aea9-6132dfb6244a	2592000	f	900	t	f	2a224daf-b933-484e-a88c-1a4fcbf53f97	0	f	0	0	3c4e2f83-7e42-4a2f-9c34-21cdfb854a70
beec1c98-131e-4539-bb19-21867eb81576	60	300	60				t	f	0	keycloak	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	556acc1e-30c6-4cec-bc2d-91c41bf9184b	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	a78536a9-5f41-4649-abca-691e8a054a16	3f7a51ac-e397-4d40-ab85-0fa956c669af	6dcb5189-5e57-4961-bc89-e953047135d1	f2673826-cef8-4136-9604-f207bd7a6d63	89663f6c-1ec6-4ae7-9ec8-3a8ca4223cdb	2592000	f	900	t	f	e11efc06-b844-42a8-9234-d6c5a43fa05e	0	f	0	0	6c27489a-09f0-4f82-adb7-422c45318e5d
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	beec1c98-131e-4539-bb19-21867eb81576	
_browser_header.xContentTypeOptions	beec1c98-131e-4539-bb19-21867eb81576	nosniff
_browser_header.referrerPolicy	beec1c98-131e-4539-bb19-21867eb81576	no-referrer
_browser_header.xRobotsTag	beec1c98-131e-4539-bb19-21867eb81576	none
_browser_header.xFrameOptions	beec1c98-131e-4539-bb19-21867eb81576	SAMEORIGIN
_browser_header.contentSecurityPolicy	beec1c98-131e-4539-bb19-21867eb81576	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	beec1c98-131e-4539-bb19-21867eb81576	1; mode=block
_browser_header.strictTransportSecurity	beec1c98-131e-4539-bb19-21867eb81576	max-age=31536000; includeSubDomains
bruteForceProtected	beec1c98-131e-4539-bb19-21867eb81576	false
permanentLockout	beec1c98-131e-4539-bb19-21867eb81576	false
maxFailureWaitSeconds	beec1c98-131e-4539-bb19-21867eb81576	900
minimumQuickLoginWaitSeconds	beec1c98-131e-4539-bb19-21867eb81576	60
waitIncrementSeconds	beec1c98-131e-4539-bb19-21867eb81576	60
quickLoginCheckMilliSeconds	beec1c98-131e-4539-bb19-21867eb81576	1000
maxDeltaTimeSeconds	beec1c98-131e-4539-bb19-21867eb81576	43200
failureFactor	beec1c98-131e-4539-bb19-21867eb81576	30
realmReusableOtpCode	beec1c98-131e-4539-bb19-21867eb81576	false
displayName	beec1c98-131e-4539-bb19-21867eb81576	Keycloak
displayNameHtml	beec1c98-131e-4539-bb19-21867eb81576	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	beec1c98-131e-4539-bb19-21867eb81576	RS256
offlineSessionMaxLifespanEnabled	beec1c98-131e-4539-bb19-21867eb81576	false
offlineSessionMaxLifespan	beec1c98-131e-4539-bb19-21867eb81576	5184000
bruteForceProtected	3f237d26-0988-482a-b1c2-14ce1e4b950f	false
permanentLockout	3f237d26-0988-482a-b1c2-14ce1e4b950f	false
maxFailureWaitSeconds	3f237d26-0988-482a-b1c2-14ce1e4b950f	900
minimumQuickLoginWaitSeconds	3f237d26-0988-482a-b1c2-14ce1e4b950f	60
waitIncrementSeconds	3f237d26-0988-482a-b1c2-14ce1e4b950f	60
quickLoginCheckMilliSeconds	3f237d26-0988-482a-b1c2-14ce1e4b950f	1000
maxDeltaTimeSeconds	3f237d26-0988-482a-b1c2-14ce1e4b950f	43200
failureFactor	3f237d26-0988-482a-b1c2-14ce1e4b950f	30
realmReusableOtpCode	3f237d26-0988-482a-b1c2-14ce1e4b950f	false
defaultSignatureAlgorithm	3f237d26-0988-482a-b1c2-14ce1e4b950f	RS256
offlineSessionMaxLifespanEnabled	3f237d26-0988-482a-b1c2-14ce1e4b950f	false
offlineSessionMaxLifespan	3f237d26-0988-482a-b1c2-14ce1e4b950f	5184000
actionTokenGeneratedByAdminLifespan	3f237d26-0988-482a-b1c2-14ce1e4b950f	43200
actionTokenGeneratedByUserLifespan	3f237d26-0988-482a-b1c2-14ce1e4b950f	300
oauth2DeviceCodeLifespan	3f237d26-0988-482a-b1c2-14ce1e4b950f	600
oauth2DevicePollingInterval	3f237d26-0988-482a-b1c2-14ce1e4b950f	5
webAuthnPolicyRpEntityName	3f237d26-0988-482a-b1c2-14ce1e4b950f	keycloak
webAuthnPolicySignatureAlgorithms	3f237d26-0988-482a-b1c2-14ce1e4b950f	ES256
webAuthnPolicyRpId	3f237d26-0988-482a-b1c2-14ce1e4b950f	
webAuthnPolicyAttestationConveyancePreference	3f237d26-0988-482a-b1c2-14ce1e4b950f	not specified
webAuthnPolicyAuthenticatorAttachment	3f237d26-0988-482a-b1c2-14ce1e4b950f	not specified
webAuthnPolicyRequireResidentKey	3f237d26-0988-482a-b1c2-14ce1e4b950f	not specified
webAuthnPolicyUserVerificationRequirement	3f237d26-0988-482a-b1c2-14ce1e4b950f	not specified
webAuthnPolicyCreateTimeout	3f237d26-0988-482a-b1c2-14ce1e4b950f	0
webAuthnPolicyAvoidSameAuthenticatorRegister	3f237d26-0988-482a-b1c2-14ce1e4b950f	false
webAuthnPolicyRpEntityNamePasswordless	3f237d26-0988-482a-b1c2-14ce1e4b950f	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	3f237d26-0988-482a-b1c2-14ce1e4b950f	ES256
webAuthnPolicyRpIdPasswordless	3f237d26-0988-482a-b1c2-14ce1e4b950f	
webAuthnPolicyAttestationConveyancePreferencePasswordless	3f237d26-0988-482a-b1c2-14ce1e4b950f	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	3f237d26-0988-482a-b1c2-14ce1e4b950f	not specified
webAuthnPolicyRequireResidentKeyPasswordless	3f237d26-0988-482a-b1c2-14ce1e4b950f	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	3f237d26-0988-482a-b1c2-14ce1e4b950f	not specified
webAuthnPolicyCreateTimeoutPasswordless	3f237d26-0988-482a-b1c2-14ce1e4b950f	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	3f237d26-0988-482a-b1c2-14ce1e4b950f	false
cibaBackchannelTokenDeliveryMode	3f237d26-0988-482a-b1c2-14ce1e4b950f	poll
cibaExpiresIn	3f237d26-0988-482a-b1c2-14ce1e4b950f	120
cibaInterval	3f237d26-0988-482a-b1c2-14ce1e4b950f	5
cibaAuthRequestedUserHint	3f237d26-0988-482a-b1c2-14ce1e4b950f	login_hint
parRequestUriLifespan	3f237d26-0988-482a-b1c2-14ce1e4b950f	60
firstBrokerLoginFlowId	beec1c98-131e-4539-bb19-21867eb81576	ba6f3019-3970-4e1d-965a-18b12b3d9983
firstBrokerLoginFlowId	3f237d26-0988-482a-b1c2-14ce1e4b950f	1f998112-efa9-49c8-a132-6f166b109262
maxTemporaryLockouts	3f237d26-0988-482a-b1c2-14ce1e4b950f	0
organizationsEnabled	3f237d26-0988-482a-b1c2-14ce1e4b950f	false
clientSessionIdleTimeout	3f237d26-0988-482a-b1c2-14ce1e4b950f	0
clientSessionMaxLifespan	3f237d26-0988-482a-b1c2-14ce1e4b950f	0
clientOfflineSessionIdleTimeout	3f237d26-0988-482a-b1c2-14ce1e4b950f	0
clientOfflineSessionMaxLifespan	3f237d26-0988-482a-b1c2-14ce1e4b950f	0
client-policies.profiles	3f237d26-0988-482a-b1c2-14ce1e4b950f	{"profiles":[]}
client-policies.policies	3f237d26-0988-482a-b1c2-14ce1e4b950f	{"policies":[]}
shortVerificationUri	3f237d26-0988-482a-b1c2-14ce1e4b950f	
actionTokenGeneratedByUserLifespan.verify-email	3f237d26-0988-482a-b1c2-14ce1e4b950f	
actionTokenGeneratedByUserLifespan.idp-verify-account-via-email	3f237d26-0988-482a-b1c2-14ce1e4b950f	
actionTokenGeneratedByUserLifespan.reset-credentials	3f237d26-0988-482a-b1c2-14ce1e4b950f	
actionTokenGeneratedByUserLifespan.execute-actions	3f237d26-0988-482a-b1c2-14ce1e4b950f	
_browser_header.contentSecurityPolicyReportOnly	3f237d26-0988-482a-b1c2-14ce1e4b950f	
_browser_header.xContentTypeOptions	3f237d26-0988-482a-b1c2-14ce1e4b950f	nosniff
_browser_header.referrerPolicy	3f237d26-0988-482a-b1c2-14ce1e4b950f	no-referrer
_browser_header.xRobotsTag	3f237d26-0988-482a-b1c2-14ce1e4b950f	none
_browser_header.xFrameOptions	3f237d26-0988-482a-b1c2-14ce1e4b950f	SAMEORIGIN
_browser_header.contentSecurityPolicy	3f237d26-0988-482a-b1c2-14ce1e4b950f	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	3f237d26-0988-482a-b1c2-14ce1e4b950f	1; mode=block
_browser_header.strictTransportSecurity	3f237d26-0988-482a-b1c2-14ce1e4b950f	max-age=31536000; includeSubDomains
cibaBackchannelTokenDeliveryMode	beec1c98-131e-4539-bb19-21867eb81576	poll
cibaExpiresIn	beec1c98-131e-4539-bb19-21867eb81576	120
cibaAuthRequestedUserHint	beec1c98-131e-4539-bb19-21867eb81576	login_hint
parRequestUriLifespan	beec1c98-131e-4539-bb19-21867eb81576	60
cibaInterval	beec1c98-131e-4539-bb19-21867eb81576	5
maxTemporaryLockouts	beec1c98-131e-4539-bb19-21867eb81576	0
actionTokenGeneratedByAdminLifespan	beec1c98-131e-4539-bb19-21867eb81576	43200
actionTokenGeneratedByUserLifespan	beec1c98-131e-4539-bb19-21867eb81576	300
webAuthnPolicyRpEntityName	beec1c98-131e-4539-bb19-21867eb81576	keycloak
webAuthnPolicySignatureAlgorithms	beec1c98-131e-4539-bb19-21867eb81576	ES256
webAuthnPolicyRpId	beec1c98-131e-4539-bb19-21867eb81576	
webAuthnPolicyAttestationConveyancePreference	beec1c98-131e-4539-bb19-21867eb81576	not specified
webAuthnPolicyAuthenticatorAttachment	beec1c98-131e-4539-bb19-21867eb81576	not specified
webAuthnPolicyRequireResidentKey	beec1c98-131e-4539-bb19-21867eb81576	not specified
webAuthnPolicyUserVerificationRequirement	beec1c98-131e-4539-bb19-21867eb81576	not specified
webAuthnPolicyCreateTimeout	beec1c98-131e-4539-bb19-21867eb81576	0
webAuthnPolicyAvoidSameAuthenticatorRegister	beec1c98-131e-4539-bb19-21867eb81576	false
webAuthnPolicyRpEntityNamePasswordless	beec1c98-131e-4539-bb19-21867eb81576	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	beec1c98-131e-4539-bb19-21867eb81576	ES256
webAuthnPolicyRpIdPasswordless	beec1c98-131e-4539-bb19-21867eb81576	
webAuthnPolicyAttestationConveyancePreferencePasswordless	beec1c98-131e-4539-bb19-21867eb81576	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	beec1c98-131e-4539-bb19-21867eb81576	not specified
webAuthnPolicyRequireResidentKeyPasswordless	beec1c98-131e-4539-bb19-21867eb81576	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	beec1c98-131e-4539-bb19-21867eb81576	not specified
webAuthnPolicyCreateTimeoutPasswordless	beec1c98-131e-4539-bb19-21867eb81576	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	beec1c98-131e-4539-bb19-21867eb81576	false
client-policies.profiles	beec1c98-131e-4539-bb19-21867eb81576	{"profiles":[]}
client-policies.policies	beec1c98-131e-4539-bb19-21867eb81576	{"policies":[]}
organizationsEnabled	beec1c98-131e-4539-bb19-21867eb81576	false
oauth2DeviceCodeLifespan	beec1c98-131e-4539-bb19-21867eb81576	600
oauth2DevicePollingInterval	beec1c98-131e-4539-bb19-21867eb81576	5
clientSessionIdleTimeout	beec1c98-131e-4539-bb19-21867eb81576	0
clientSessionMaxLifespan	beec1c98-131e-4539-bb19-21867eb81576	0
clientOfflineSessionIdleTimeout	beec1c98-131e-4539-bb19-21867eb81576	0
clientOfflineSessionMaxLifespan	beec1c98-131e-4539-bb19-21867eb81576	0
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
beec1c98-131e-4539-bb19-21867eb81576	jboss-logging
3f237d26-0988-482a-b1c2-14ce1e4b950f	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	beec1c98-131e-4539-bb19-21867eb81576
password	password	t	t	3f237d26-0988-482a-b1c2-14ce1e4b950f
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.redirect_uris (client_id, value) FROM stdin;
7262b5df-0bda-4bc1-b12d-7ee3ae5a8393	/realms/master/account/*
01a41349-3ba2-42c9-ac22-e0ca3825646a	/realms/master/account/*
fe9194f3-05e6-491e-bbc9-9cdd7909a908	/admin/master/console/*
c40bb8d7-0215-4550-8dd1-758bb382ac19	/realms/BilanCarbone/account/*
565f1b69-aa96-4c24-9f10-f5d921f0021e	/realms/BilanCarbone/account/*
3a4802dd-0117-4eae-969d-d768b001c0ca	/admin/BilanCarbone/console/*
a9ff1805-83cc-4742-96b5-201d1b8c3014	http://localhost:5173/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
c0cc9d32-200c-42ab-a9c6-0168a8fc2e39	VERIFY_EMAIL	Verify Email	beec1c98-131e-4539-bb19-21867eb81576	t	f	VERIFY_EMAIL	50
66f0b95d-61e5-48ad-ab1a-32a44fa74f0b	UPDATE_PROFILE	Update Profile	beec1c98-131e-4539-bb19-21867eb81576	t	f	UPDATE_PROFILE	40
f2136c6d-2bed-4dfb-a9ce-6b6cffd308ac	CONFIGURE_TOTP	Configure OTP	beec1c98-131e-4539-bb19-21867eb81576	t	f	CONFIGURE_TOTP	10
b6088188-ebe8-4807-ae40-aa701efd4f6c	UPDATE_PASSWORD	Update Password	beec1c98-131e-4539-bb19-21867eb81576	t	f	UPDATE_PASSWORD	30
10c190ea-5afd-4412-8616-0898e38ebb2a	TERMS_AND_CONDITIONS	Terms and Conditions	beec1c98-131e-4539-bb19-21867eb81576	f	f	TERMS_AND_CONDITIONS	20
a9c2726e-f0c0-4df0-8d74-5a93461a6633	delete_account	Delete Account	beec1c98-131e-4539-bb19-21867eb81576	f	f	delete_account	60
2380979e-54e8-4ee3-9a71-d6cdea3b69d2	update_user_locale	Update User Locale	beec1c98-131e-4539-bb19-21867eb81576	t	f	update_user_locale	1000
ce9eeb04-6c7c-46d7-afa0-fdfe9f8e1101	webauthn-register	Webauthn Register	beec1c98-131e-4539-bb19-21867eb81576	t	f	webauthn-register	70
8d8ce490-1e75-4f68-aed8-f72fc1838c40	webauthn-register-passwordless	Webauthn Register Passwordless	beec1c98-131e-4539-bb19-21867eb81576	t	f	webauthn-register-passwordless	80
f7e0cd4d-48a3-43d3-9808-db8ec0d02a35	VERIFY_EMAIL	Verify Email	3f237d26-0988-482a-b1c2-14ce1e4b950f	t	f	VERIFY_EMAIL	50
6094ed69-151f-4f07-ae6b-6548ff76cf77	UPDATE_PROFILE	Update Profile	3f237d26-0988-482a-b1c2-14ce1e4b950f	t	f	UPDATE_PROFILE	40
3f115b5f-db55-4ef8-94ce-79f130fb099d	CONFIGURE_TOTP	Configure OTP	3f237d26-0988-482a-b1c2-14ce1e4b950f	t	f	CONFIGURE_TOTP	10
02865f1a-006d-43d4-bddb-a5681f9b75f9	UPDATE_PASSWORD	Update Password	3f237d26-0988-482a-b1c2-14ce1e4b950f	t	f	UPDATE_PASSWORD	30
cdfb59a1-da46-413e-a27a-84b693039703	TERMS_AND_CONDITIONS	Terms and Conditions	3f237d26-0988-482a-b1c2-14ce1e4b950f	f	f	TERMS_AND_CONDITIONS	20
7b3ae0a7-288d-4bb1-b854-416b92ccdf72	delete_account	Delete Account	3f237d26-0988-482a-b1c2-14ce1e4b950f	f	f	delete_account	60
ecd535b2-5948-4f2d-bbf2-39715686462d	update_user_locale	Update User Locale	3f237d26-0988-482a-b1c2-14ce1e4b950f	t	f	update_user_locale	1000
5f61055c-5cdb-4679-b114-c93fb5ba805c	webauthn-register	Webauthn Register	3f237d26-0988-482a-b1c2-14ce1e4b950f	t	f	webauthn-register	70
8038f2e3-d113-4b1a-9d0d-e2d7cca75736	webauthn-register-passwordless	Webauthn Register Passwordless	3f237d26-0988-482a-b1c2-14ce1e4b950f	t	f	webauthn-register-passwordless	80
4d6312f1-4001-405e-b7d8-0e7b26ad9085	delete_credential	Delete Credential	beec1c98-131e-4539-bb19-21867eb81576	t	f	delete_credential	100
63e2336c-da42-444e-b007-450938f71c93	delete_credential	Delete Credential	3f237d26-0988-482a-b1c2-14ce1e4b950f	t	f	delete_credential	100
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
01a41349-3ba2-42c9-ac22-e0ca3825646a	71019e50-8f57-4708-b0ae-450a5da85ca5
01a41349-3ba2-42c9-ac22-e0ca3825646a	c784d174-b11d-406a-b566-20e679991519
565f1b69-aa96-4c24-9f10-f5d921f0021e	b264cfad-a71e-4ffd-8ada-a3dfc01628d6
565f1b69-aa96-4c24-9f10-f5d921f0021e	44f5ac06-3d80-4179-92eb-135e44936344
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: type; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.type (id, update_date, created_date, is_deleted, active, name, parent_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
entreprise	admin	5db6d25f-748f-462d-9ab0-5adf0c1f5953	e3f03451-b5fa-4ba6-b9db-8d905f04b7ad	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
6df8a143-0b2c-43cf-96e7-06fc76c8ea94	\N	f9bc3905-20ef-4c29-a685-072d4dd5cf60	f	t	\N	\N	\N	beec1c98-131e-4539-bb19-21867eb81576	admin	1720703117276	\N	0
5db6d25f-748f-462d-9ab0-5adf0c1f5953	mrchalabihossam@gmail.com	mrchalabihossam@gmail.com	f	t	\N	Hossam	Chalabi	3f237d26-0988-482a-b1c2-14ce1e4b950f	admin	1720777274573	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
6c27489a-09f0-4f82-adb7-422c45318e5d	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
e7e163dd-4893-438a-abae-b5a59e640a97	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
2e96d65d-6aa8-495c-9cc4-c1c1c02b0620	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
b33f016d-ce02-4d82-afbe-0503e52fd425	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
f9b952e1-f7ff-48db-ac5c-9856cac33c6e	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
a7b852a3-12b4-4bbf-b5e1-548827c3f4e4	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
162f97e3-636d-423b-be39-bb76d2a839f0	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
62c268d3-a127-425b-b451-1823bb996a72	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
2a3625d9-9b0d-4d68-b5dc-8bb4e668c0d7	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
4942b676-bfa6-464d-8fa4-0f1ca1847916	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
4dfacfc7-d6c1-460c-8b17-6e01cd8b3c09	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
cc76babc-8f2b-4567-a58a-6d767a1c2d4f	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
928001fe-b8b2-417d-8c6a-d79b4dc3debd	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
4255f549-298a-4052-8919-d3b4054635b1	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
65868ac8-63ec-4ede-a9c4-95ba7f52bc10	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
ceb55e40-27dd-4c51-aa99-7ed04e20cb17	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
1c5f38de-a1fe-4150-8bec-a24b7ba3c4da	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
ac09856d-4d38-4af5-a9ef-56db668010f5	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
77a42733-ab1f-4996-8573-223a980d4e7e	6df8a143-0b2c-43cf-96e7-06fc76c8ea94
3905cfad-7099-45cc-a96d-685320385613	5db6d25f-748f-462d-9ab0-5adf0c1f5953
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.utilisateur (id, entreprise_id) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.web_origins (client_id, value) FROM stdin;
fe9194f3-05e6-491e-bbc9-9cdd7909a908	+
3a4802dd-0117-4eae-969d-d768b001c0ca	+
a9ff1805-83cc-4742-96b5-201d1b8c3014	*
\.


--
-- Name: demande_utilisateur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.demande_utilisateur_id_seq', 27, true);


--
-- Name: entreprise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.entreprise_id_seq', 3, true);


--
-- Name: facteur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.facteur_id_seq', 1, false);


--
-- Name: type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.type_id_seq', 1, false);


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: demande_utilisateur demande_utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.demande_utilisateur
    ADD CONSTRAINT demande_utilisateur_pkey PRIMARY KEY (id);


--
-- Name: entreprise entreprise_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.entreprise
    ADD CONSTRAINT entreprise_pkey PRIMARY KEY (id);


--
-- Name: facteur facteur_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.facteur
    ADD CONSTRAINT facteur_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: type type_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT type_pkey PRIMARY KEY (id);


--
-- Name: entreprise uk3imhgd19qjk5lovj8i1iuxo08; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.entreprise
    ADD CONSTRAINT uk3imhgd19qjk5lovj8i1iuxo08 UNIQUE (nom_entreprise);


--
-- Name: demande_utilisateur uk8660t53dexxdfswgern42xwdq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.demande_utilisateur
    ADD CONSTRAINT uk8660t53dexxdfswgern42xwdq UNIQUE (nom_utilisateur);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: demande_utilisateur ukp5wcgim5rj3lasopp6gpt31jf; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.demande_utilisateur
    ADD CONSTRAINT ukp5wcgim5rj3lasopp6gpt31jf UNIQUE (email);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: facteur fk457hoxnl01ng4bxqpuwrpmear; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.facteur
    ADD CONSTRAINT fk457hoxnl01ng4bxqpuwrpmear FOREIGN KEY (type_id) REFERENCES public.type(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: utilisateur fk8fjtucbyo2t6agaejym2j764f; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT fk8fjtucbyo2t6agaejym2j764f FOREIGN KEY (entreprise_id) REFERENCES public.entreprise(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- Name: demande_utilisateur fkslq6atjci86fguk0kbh67os33; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.demande_utilisateur
    ADD CONSTRAINT fkslq6atjci86fguk0kbh67os33 FOREIGN KEY (entreprise_id) REFERENCES public.entreprise(id);


--
-- Name: type fkyk5ic9puu6d8j4vdp2rg5bfs; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT fkyk5ic9puu6d8j4vdp2rg5bfs FOREIGN KEY (parent_id) REFERENCES public.type(id);


--
-- PostgreSQL database dump complete
--


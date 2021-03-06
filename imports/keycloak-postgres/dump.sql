--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE IF EXISTS keycloak_db;




--
-- Drop roles
--

DROP ROLE IF EXISTS postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:pcXce7obQ1xsUuMnZ5gWjQ==$hAWXWzVBqSy8aLg9zjuox1hurXzYA1EIlibUS8ROx48=:Bqvg0v2Yahr8Qdbmcq+fyHDaZagAgZ+4eRXLVXpN4+k=';






--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Debian 14.1-1.pgdg110+1)
-- Dumped by pg_dump version 14.1 (Debian 14.1-1.pgdg110+1)

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "keycloak_db" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Debian 14.1-1.pgdg110+1)
-- Dumped by pg_dump version 14.1 (Debian 14.1-1.pgdg110+1)

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

--
-- Name: keycloak_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE keycloak_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE keycloak_db OWNER TO postgres;

\connect keycloak_db

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
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
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
834ecbe0-2039-45a9-84b0-a685c85cb9eb	33c17a47-b7ad-4853-8036-21ef8fa0da9f
6aa3a39c-4413-4058-a1b6-310e1e46de4d	da0190b1-eb03-49b8-97e4-26496e2106be
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
443b57fc-818e-4e67-882d-ae95ec02130f	\N	auth-cookie	master	155e7d4d-48cc-4bf3-b7c6-299f71719f53	2	10	f	\N	\N
b71b9139-9efd-45eb-8307-6d1ecd1b22c2	\N	auth-spnego	master	155e7d4d-48cc-4bf3-b7c6-299f71719f53	3	20	f	\N	\N
d3cf5fbc-179e-4802-8ec6-417b453378e1	\N	identity-provider-redirector	master	155e7d4d-48cc-4bf3-b7c6-299f71719f53	2	25	f	\N	\N
65cded08-ad92-4e35-b19a-48fddeccd695	\N	\N	master	155e7d4d-48cc-4bf3-b7c6-299f71719f53	2	30	t	ca09edf4-bf02-4f75-8169-7c50e15ba802	\N
6e6ccd15-549c-4080-8779-dbb825329dea	\N	auth-username-password-form	master	ca09edf4-bf02-4f75-8169-7c50e15ba802	0	10	f	\N	\N
c02e15ab-3a0a-47fd-b1a7-9ea6ed30eafd	\N	\N	master	ca09edf4-bf02-4f75-8169-7c50e15ba802	1	20	t	ae56c65e-2f02-4cb6-b434-dc602e6c72b4	\N
9e4f086b-9ae0-4b32-bcdf-40029649b027	\N	conditional-user-configured	master	ae56c65e-2f02-4cb6-b434-dc602e6c72b4	0	10	f	\N	\N
eabe55be-fb51-409b-a8d1-4a0f90794d15	\N	auth-otp-form	master	ae56c65e-2f02-4cb6-b434-dc602e6c72b4	0	20	f	\N	\N
907341ad-b7ad-45a7-a9ee-685951bdf019	\N	direct-grant-validate-username	master	287f8272-e95d-4056-8c30-3ad8fdbfd620	0	10	f	\N	\N
a50b689a-864a-4d51-8f62-ea1eb56f7687	\N	direct-grant-validate-password	master	287f8272-e95d-4056-8c30-3ad8fdbfd620	0	20	f	\N	\N
adb8591b-0546-41dc-967e-aeb14826b80b	\N	\N	master	287f8272-e95d-4056-8c30-3ad8fdbfd620	1	30	t	41a119c7-7c45-4820-90a8-ad7eeae49ebf	\N
f543f43f-5dca-4361-bd53-6ef23d1ee090	\N	conditional-user-configured	master	41a119c7-7c45-4820-90a8-ad7eeae49ebf	0	10	f	\N	\N
89630102-7bcf-40ac-9b12-45faa84c97af	\N	direct-grant-validate-otp	master	41a119c7-7c45-4820-90a8-ad7eeae49ebf	0	20	f	\N	\N
bfe6bae3-90d3-4e91-8da2-0ba77681c42c	\N	registration-page-form	master	1804d43d-cfe8-465b-97fa-fc7fd2284257	0	10	t	6bc2da38-c331-40e6-875e-1a810d40e709	\N
b337394f-a685-479e-bfe1-a2e6a4dd808f	\N	registration-user-creation	master	6bc2da38-c331-40e6-875e-1a810d40e709	0	20	f	\N	\N
4d66c4b3-6434-4990-92e9-1091c75c6031	\N	registration-profile-action	master	6bc2da38-c331-40e6-875e-1a810d40e709	0	40	f	\N	\N
8391f48f-e8fc-485b-ac42-a6d863c94aae	\N	registration-password-action	master	6bc2da38-c331-40e6-875e-1a810d40e709	0	50	f	\N	\N
86394217-9d43-4939-bd10-72140c1645d6	\N	registration-recaptcha-action	master	6bc2da38-c331-40e6-875e-1a810d40e709	3	60	f	\N	\N
ab49efaf-c6d0-4bb5-9c7a-0d1e2281a8b3	\N	reset-credentials-choose-user	master	0ccb7aaa-f173-41e3-8f2d-962f30772218	0	10	f	\N	\N
ea69ed78-8bfa-4762-9ef7-f9e02fd23cbe	\N	reset-credential-email	master	0ccb7aaa-f173-41e3-8f2d-962f30772218	0	20	f	\N	\N
8b086285-af93-49cf-b570-4ed43ab07977	\N	reset-password	master	0ccb7aaa-f173-41e3-8f2d-962f30772218	0	30	f	\N	\N
d49670ec-44d0-40ae-92d3-84b7315e8893	\N	\N	master	0ccb7aaa-f173-41e3-8f2d-962f30772218	1	40	t	039024f0-645b-4709-a9a3-975a6fd23108	\N
567cd501-fbc2-4cb6-9936-3796d41e6bd8	\N	conditional-user-configured	master	039024f0-645b-4709-a9a3-975a6fd23108	0	10	f	\N	\N
f0f1ad64-f89b-4af6-b63c-a11b6f33ca8a	\N	reset-otp	master	039024f0-645b-4709-a9a3-975a6fd23108	0	20	f	\N	\N
5775cf42-444b-4105-a785-d606d4a60d5b	\N	client-secret	master	f7a63f43-ee7b-4afa-8027-b171fc0e1d4a	2	10	f	\N	\N
67f98b32-d8e1-43c4-9b00-2f1ce527ea20	\N	client-jwt	master	f7a63f43-ee7b-4afa-8027-b171fc0e1d4a	2	20	f	\N	\N
29dfda77-d662-4437-bb8b-b6f4a8b73fa5	\N	client-secret-jwt	master	f7a63f43-ee7b-4afa-8027-b171fc0e1d4a	2	30	f	\N	\N
f2111bf5-6c91-4fb1-9bbb-79b1c867b152	\N	client-x509	master	f7a63f43-ee7b-4afa-8027-b171fc0e1d4a	2	40	f	\N	\N
87bc81cb-db88-43ea-8f84-2be48e0a7ede	\N	idp-review-profile	master	ccff9f55-4248-4560-8d0e-8760ee837268	0	10	f	\N	52312830-ae75-4a33-8986-f4b11ff9cb6e
2eaa8977-df08-4aef-895d-2164c190535b	\N	\N	master	ccff9f55-4248-4560-8d0e-8760ee837268	0	20	t	66dc71e4-2a6b-49c9-8c32-9159ba63dfb8	\N
946fc8a6-59e9-4fe3-ac93-ecb111c812fd	\N	idp-create-user-if-unique	master	66dc71e4-2a6b-49c9-8c32-9159ba63dfb8	2	10	f	\N	c281650b-5f3d-4bb1-be37-2b77621169d6
e5d407ca-957a-4c96-b857-9d75116ccb25	\N	\N	master	66dc71e4-2a6b-49c9-8c32-9159ba63dfb8	2	20	t	f69f3098-08ff-4233-846c-6a88406ccf13	\N
0ceb3faf-ab38-423a-8e32-de2944e5d46b	\N	idp-confirm-link	master	f69f3098-08ff-4233-846c-6a88406ccf13	0	10	f	\N	\N
72458a0b-7f6b-4383-b1e0-974e910a767e	\N	\N	master	f69f3098-08ff-4233-846c-6a88406ccf13	0	20	t	4c37e966-46e8-4e74-962a-5c8a7fdca6d8	\N
f2b17575-16c3-4e0c-bbc5-207fdcd15ade	\N	idp-email-verification	master	4c37e966-46e8-4e74-962a-5c8a7fdca6d8	2	10	f	\N	\N
f5a49f5d-76df-472e-a23b-5296286f0f39	\N	\N	master	4c37e966-46e8-4e74-962a-5c8a7fdca6d8	2	20	t	019cc985-59c1-4b97-8f97-d313d3f9a419	\N
368a24b0-fb6f-4d72-ad20-b92ff4bb983a	\N	idp-username-password-form	master	019cc985-59c1-4b97-8f97-d313d3f9a419	0	10	f	\N	\N
632ff160-4fed-4da7-a2d5-5f31294fa29e	\N	\N	master	019cc985-59c1-4b97-8f97-d313d3f9a419	1	20	t	e01f2dd6-89a6-432d-8e96-dc9830ac6397	\N
dba81c91-440b-4542-be0a-6588714a6a68	\N	conditional-user-configured	master	e01f2dd6-89a6-432d-8e96-dc9830ac6397	0	10	f	\N	\N
4a2f9a34-7a73-464e-9815-829e2a809cc6	\N	auth-otp-form	master	e01f2dd6-89a6-432d-8e96-dc9830ac6397	0	20	f	\N	\N
8c4694be-b1a5-4bd4-9b44-41ea771411c6	\N	http-basic-authenticator	master	dc9ee195-bb68-46ec-aa8f-3e47dc52dd67	0	10	f	\N	\N
326e5107-2adc-47c8-aa1a-f0765d8334a8	\N	docker-http-basic-authenticator	master	c9a950d4-4411-491e-8ae5-304eda4e4167	0	10	f	\N	\N
f952d615-ef56-4c3f-bb2e-5d8742fd2013	\N	no-cookie-redirect	master	8e62c425-2f2f-4e60-adb6-82bdfbc37613	0	10	f	\N	\N
b6d7cdf4-4c71-4633-b113-82405331beee	\N	\N	master	8e62c425-2f2f-4e60-adb6-82bdfbc37613	0	20	t	b43d10f6-70f6-4177-926d-5d88651a0419	\N
deb54e52-346f-438f-9b57-6ec4bb814d6c	\N	basic-auth	master	b43d10f6-70f6-4177-926d-5d88651a0419	0	10	f	\N	\N
7bb85ff6-72cc-4d9a-bd76-22504cc764dc	\N	basic-auth-otp	master	b43d10f6-70f6-4177-926d-5d88651a0419	3	20	f	\N	\N
784640b7-c27e-4825-8525-7d84cabcddfc	\N	auth-spnego	master	b43d10f6-70f6-4177-926d-5d88651a0419	3	30	f	\N	\N
57b41b5a-e5ee-41a7-a537-02b1f77f3abb	\N	auth-cookie	WAYD	c95e0473-d50f-4749-aa15-cd415beb2c32	2	10	f	\N	\N
29be48e4-ac62-4d4a-92e0-5b0931d5f715	\N	auth-spnego	WAYD	c95e0473-d50f-4749-aa15-cd415beb2c32	3	20	f	\N	\N
8dabe8c7-bde5-4b9f-9f30-efb09d31822a	\N	identity-provider-redirector	WAYD	c95e0473-d50f-4749-aa15-cd415beb2c32	2	25	f	\N	\N
605ddab7-40bf-4829-bce3-fbc3aac75077	\N	\N	WAYD	c95e0473-d50f-4749-aa15-cd415beb2c32	2	30	t	fc4cfc58-2642-4686-9f84-7818c268508b	\N
712ecf82-907b-4225-823a-27e0e015ec59	\N	auth-username-password-form	WAYD	fc4cfc58-2642-4686-9f84-7818c268508b	0	10	f	\N	\N
bfd6155f-c391-4b98-ac18-a6c768ba44e3	\N	\N	WAYD	fc4cfc58-2642-4686-9f84-7818c268508b	1	20	t	e6d95373-a577-4f78-8438-3519a4815e14	\N
f7cb4ee0-9558-4f65-8b62-88b7d5aa5695	\N	conditional-user-configured	WAYD	e6d95373-a577-4f78-8438-3519a4815e14	0	10	f	\N	\N
b6b48183-99e3-441b-a51c-ad9f0c49d8ac	\N	auth-otp-form	WAYD	e6d95373-a577-4f78-8438-3519a4815e14	0	20	f	\N	\N
f8a880d1-da46-43c6-8f62-cb71e765a396	\N	direct-grant-validate-username	WAYD	a4dc6c0a-fd1a-4f27-bcef-6928cb0ca21e	0	10	f	\N	\N
f7bab51e-fb9d-4983-9bea-b581ca27a6fb	\N	direct-grant-validate-password	WAYD	a4dc6c0a-fd1a-4f27-bcef-6928cb0ca21e	0	20	f	\N	\N
c5d3882b-0a72-4a6e-8423-7554dee100f1	\N	\N	WAYD	a4dc6c0a-fd1a-4f27-bcef-6928cb0ca21e	1	30	t	93b115b8-fe0a-471b-9622-b2f6cb325245	\N
db595376-995d-4164-9d08-cbab936868d6	\N	conditional-user-configured	WAYD	93b115b8-fe0a-471b-9622-b2f6cb325245	0	10	f	\N	\N
e372a234-c366-4f03-86b6-86215a59fd22	\N	direct-grant-validate-otp	WAYD	93b115b8-fe0a-471b-9622-b2f6cb325245	0	20	f	\N	\N
5e0e3fd8-4c18-4130-b6ed-826c336a5ca9	\N	registration-page-form	WAYD	7034377f-66ea-48a5-88de-8dcd7dce1255	0	10	t	85842c14-7b19-434e-9c67-7bfa1ad867f2	\N
9d2f07f7-ad86-4531-a21e-c4230758637f	\N	registration-user-creation	WAYD	85842c14-7b19-434e-9c67-7bfa1ad867f2	0	20	f	\N	\N
ce9b368d-f1ca-4dea-a082-249211256d65	\N	registration-profile-action	WAYD	85842c14-7b19-434e-9c67-7bfa1ad867f2	0	40	f	\N	\N
dae88079-cc6a-43cf-88d4-abfd846bd11e	\N	registration-password-action	WAYD	85842c14-7b19-434e-9c67-7bfa1ad867f2	0	50	f	\N	\N
563ebe35-1b72-43f1-aff5-ae92816a9fa6	\N	registration-recaptcha-action	WAYD	85842c14-7b19-434e-9c67-7bfa1ad867f2	3	60	f	\N	\N
0e4ebd37-5d33-4df6-bdf5-fdc64aac6627	\N	reset-credentials-choose-user	WAYD	a29b3489-8dfe-4564-b0fd-0947e49f1c3a	0	10	f	\N	\N
dc8f216f-456f-4d3a-a4f4-f40ac2b57a89	\N	reset-credential-email	WAYD	a29b3489-8dfe-4564-b0fd-0947e49f1c3a	0	20	f	\N	\N
3231087a-1485-43b1-a961-30ebc1bf1cec	\N	reset-password	WAYD	a29b3489-8dfe-4564-b0fd-0947e49f1c3a	0	30	f	\N	\N
c078c329-4cd7-4761-9610-e565d0c48706	\N	\N	WAYD	a29b3489-8dfe-4564-b0fd-0947e49f1c3a	1	40	t	013d73ec-5085-4c59-965b-b8c48270a1cd	\N
66ec384f-dc0f-45d7-be97-3bc989078cd7	\N	conditional-user-configured	WAYD	013d73ec-5085-4c59-965b-b8c48270a1cd	0	10	f	\N	\N
bae61538-3208-40ba-b631-71e59d297e21	\N	reset-otp	WAYD	013d73ec-5085-4c59-965b-b8c48270a1cd	0	20	f	\N	\N
ae11feb2-8881-4039-9d07-7ec45c704d16	\N	client-secret	WAYD	131d2d0b-9ddd-44a0-b431-2ca31391d8d2	2	10	f	\N	\N
070083a0-dd61-408c-83b8-582a0b3fe7c7	\N	client-jwt	WAYD	131d2d0b-9ddd-44a0-b431-2ca31391d8d2	2	20	f	\N	\N
6d0d5cae-712c-4de8-9343-8facb9984bb5	\N	client-secret-jwt	WAYD	131d2d0b-9ddd-44a0-b431-2ca31391d8d2	2	30	f	\N	\N
e949c416-2317-47fc-8f54-050ad68489b7	\N	client-x509	WAYD	131d2d0b-9ddd-44a0-b431-2ca31391d8d2	2	40	f	\N	\N
25ddd024-41b3-4621-a7ba-5df406203f97	\N	idp-review-profile	WAYD	08c7e870-8082-4624-b468-8e31dc60b8b7	0	10	f	\N	59e5ff8b-5e10-4ee7-a240-bd410190f8ce
4396ece6-a9cb-4da3-8fdb-bf9f61a9b3f4	\N	\N	WAYD	08c7e870-8082-4624-b468-8e31dc60b8b7	0	20	t	5ea1a39b-b217-4e9f-93ff-c227a8c13622	\N
4d7a64b9-aa5c-4115-95c7-83edb9c64abe	\N	idp-create-user-if-unique	WAYD	5ea1a39b-b217-4e9f-93ff-c227a8c13622	2	10	f	\N	1c3ba42e-f066-4761-86b3-7e0f86391980
a0843861-a976-41b0-8af0-1bc76de37f9e	\N	\N	WAYD	5ea1a39b-b217-4e9f-93ff-c227a8c13622	2	20	t	3b18e552-92e5-4a7f-a55c-fdb6fb8b4906	\N
1b2054a2-44d0-4bc6-abf6-63472f93a025	\N	idp-confirm-link	WAYD	3b18e552-92e5-4a7f-a55c-fdb6fb8b4906	0	10	f	\N	\N
ee5c3847-e67a-4ddc-a0ae-d7d67ad17112	\N	\N	WAYD	3b18e552-92e5-4a7f-a55c-fdb6fb8b4906	0	20	t	9495fa87-ddf0-4ac1-9cce-53b888eb7502	\N
929feed4-b397-4332-9f6d-1432271900a0	\N	idp-email-verification	WAYD	9495fa87-ddf0-4ac1-9cce-53b888eb7502	2	10	f	\N	\N
fecea452-0246-4bab-9eef-2b8aead3873b	\N	\N	WAYD	9495fa87-ddf0-4ac1-9cce-53b888eb7502	2	20	t	c5913a8b-5300-4805-bbc8-7cf44f079a1f	\N
5c3085e7-d3eb-4199-b421-defe7ad15bc1	\N	idp-username-password-form	WAYD	c5913a8b-5300-4805-bbc8-7cf44f079a1f	0	10	f	\N	\N
630f2906-9c17-4581-aa3e-2b2dfe9b609d	\N	\N	WAYD	c5913a8b-5300-4805-bbc8-7cf44f079a1f	1	20	t	df93634e-3f0c-49f2-8837-74f8e0a2079b	\N
68b044a9-fa6c-4dae-ac07-105e06dc11b2	\N	conditional-user-configured	WAYD	df93634e-3f0c-49f2-8837-74f8e0a2079b	0	10	f	\N	\N
5499b2b3-f643-458c-bcf2-9b2ac56645ea	\N	auth-otp-form	WAYD	df93634e-3f0c-49f2-8837-74f8e0a2079b	0	20	f	\N	\N
bd29185c-3de1-421d-93ff-94e2d56aafc5	\N	http-basic-authenticator	WAYD	ab5d446f-3cd6-4cd3-aa3e-9022091e857d	0	10	f	\N	\N
1dd6583a-41ff-4fd0-8d7f-801f99677bab	\N	docker-http-basic-authenticator	WAYD	bba31e7e-06ca-43ae-889a-7d57a6c66fa4	0	10	f	\N	\N
df04c90d-18c8-4d40-bcda-c6a6e119667d	\N	no-cookie-redirect	WAYD	102fe6ec-6dc5-4c5d-8ccf-fff87e9d370f	0	10	f	\N	\N
510b4103-5f65-422e-823e-54b3caf4b344	\N	\N	WAYD	102fe6ec-6dc5-4c5d-8ccf-fff87e9d370f	0	20	t	44cffb4b-cf36-4855-b3dc-5c7e52177342	\N
b0cec64d-686d-4c0c-b7ab-3a62b366efee	\N	basic-auth	WAYD	44cffb4b-cf36-4855-b3dc-5c7e52177342	0	10	f	\N	\N
e3f6ba8a-99d9-4bad-9b10-1f271cd4f245	\N	basic-auth-otp	WAYD	44cffb4b-cf36-4855-b3dc-5c7e52177342	3	20	f	\N	\N
86ff6797-fb39-49e3-a87d-85b4e95acf06	\N	auth-spnego	WAYD	44cffb4b-cf36-4855-b3dc-5c7e52177342	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
155e7d4d-48cc-4bf3-b7c6-299f71719f53	browser	browser based authentication	master	basic-flow	t	t
ca09edf4-bf02-4f75-8169-7c50e15ba802	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
ae56c65e-2f02-4cb6-b434-dc602e6c72b4	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
287f8272-e95d-4056-8c30-3ad8fdbfd620	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
41a119c7-7c45-4820-90a8-ad7eeae49ebf	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
1804d43d-cfe8-465b-97fa-fc7fd2284257	registration	registration flow	master	basic-flow	t	t
6bc2da38-c331-40e6-875e-1a810d40e709	registration form	registration form	master	form-flow	f	t
0ccb7aaa-f173-41e3-8f2d-962f30772218	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
039024f0-645b-4709-a9a3-975a6fd23108	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
f7a63f43-ee7b-4afa-8027-b171fc0e1d4a	clients	Base authentication for clients	master	client-flow	t	t
ccff9f55-4248-4560-8d0e-8760ee837268	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
66dc71e4-2a6b-49c9-8c32-9159ba63dfb8	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
f69f3098-08ff-4233-846c-6a88406ccf13	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
4c37e966-46e8-4e74-962a-5c8a7fdca6d8	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
019cc985-59c1-4b97-8f97-d313d3f9a419	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
e01f2dd6-89a6-432d-8e96-dc9830ac6397	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
dc9ee195-bb68-46ec-aa8f-3e47dc52dd67	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
c9a950d4-4411-491e-8ae5-304eda4e4167	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
8e62c425-2f2f-4e60-adb6-82bdfbc37613	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
b43d10f6-70f6-4177-926d-5d88651a0419	Authentication Options	Authentication options.	master	basic-flow	f	t
c95e0473-d50f-4749-aa15-cd415beb2c32	browser	browser based authentication	WAYD	basic-flow	t	t
fc4cfc58-2642-4686-9f84-7818c268508b	forms	Username, password, otp and other auth forms.	WAYD	basic-flow	f	t
e6d95373-a577-4f78-8438-3519a4815e14	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	WAYD	basic-flow	f	t
a4dc6c0a-fd1a-4f27-bcef-6928cb0ca21e	direct grant	OpenID Connect Resource Owner Grant	WAYD	basic-flow	t	t
93b115b8-fe0a-471b-9622-b2f6cb325245	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	WAYD	basic-flow	f	t
7034377f-66ea-48a5-88de-8dcd7dce1255	registration	registration flow	WAYD	basic-flow	t	t
85842c14-7b19-434e-9c67-7bfa1ad867f2	registration form	registration form	WAYD	form-flow	f	t
a29b3489-8dfe-4564-b0fd-0947e49f1c3a	reset credentials	Reset credentials for a user if they forgot their password or something	WAYD	basic-flow	t	t
013d73ec-5085-4c59-965b-b8c48270a1cd	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	WAYD	basic-flow	f	t
131d2d0b-9ddd-44a0-b431-2ca31391d8d2	clients	Base authentication for clients	WAYD	client-flow	t	t
08c7e870-8082-4624-b468-8e31dc60b8b7	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	WAYD	basic-flow	t	t
5ea1a39b-b217-4e9f-93ff-c227a8c13622	User creation or linking	Flow for the existing/non-existing user alternatives	WAYD	basic-flow	f	t
3b18e552-92e5-4a7f-a55c-fdb6fb8b4906	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	WAYD	basic-flow	f	t
9495fa87-ddf0-4ac1-9cce-53b888eb7502	Account verification options	Method with which to verity the existing account	WAYD	basic-flow	f	t
c5913a8b-5300-4805-bbc8-7cf44f079a1f	Verify Existing Account by Re-authentication	Reauthentication of existing account	WAYD	basic-flow	f	t
df93634e-3f0c-49f2-8837-74f8e0a2079b	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	WAYD	basic-flow	f	t
ab5d446f-3cd6-4cd3-aa3e-9022091e857d	saml ecp	SAML ECP Profile Authentication Flow	WAYD	basic-flow	t	t
bba31e7e-06ca-43ae-889a-7d57a6c66fa4	docker auth	Used by Docker clients to authenticate against the IDP	WAYD	basic-flow	t	t
102fe6ec-6dc5-4c5d-8ccf-fff87e9d370f	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	WAYD	basic-flow	t	t
44cffb4b-cf36-4855-b3dc-5c7e52177342	Authentication Options	Authentication options.	WAYD	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
52312830-ae75-4a33-8986-f4b11ff9cb6e	review profile config	master
c281650b-5f3d-4bb1-be37-2b77621169d6	create unique user config	master
59e5ff8b-5e10-4ee7-a240-bd410190f8ce	review profile config	WAYD
1c3ba42e-f066-4761-86b3-7e0f86391980	create unique user config	WAYD
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
52312830-ae75-4a33-8986-f4b11ff9cb6e	missing	update.profile.on.first.login
c281650b-5f3d-4bb1-be37-2b77621169d6	false	require.password.update.after.registration
59e5ff8b-5e10-4ee7-a240-bd410190f8ce	missing	update.profile.on.first.login
1c3ba42e-f066-4761-86b3-7e0f86391980	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
89a05317-0b45-43f5-a267-534025915d0c	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
3bb62974-3793-4ce9-8394-eae365f6de40	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
fdea54ca-8fee-41fc-ad78-6540be507a83	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
c68246db-bb4f-4c9e-a771-0ead82f8362a	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d83f6ef0-8303-4fb5-93bd-1bd5f9095be2	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	f	WAYD-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	WAYD Realm	f	client-secret	\N	\N	\N	t	f	f	f
8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	f	realm-management	0	f	\N	\N	t	\N	f	WAYD	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
f30380e2-97f9-45d9-9e54-80aca4bb0aa3	t	f	account	0	t	\N	/realms/WAYD/account/	f	\N	f	WAYD	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
55827f0e-432e-4a17-9122-832dd12da738	t	f	account-console	0	t	\N	/realms/WAYD/account/	f	\N	f	WAYD	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
af992157-4226-467a-b68b-27fea93abe0d	t	f	broker	0	f	\N	\N	t	\N	f	WAYD	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
19b2001f-f020-4955-a632-7867490abc98	t	f	security-admin-console	0	t	\N	/admin/WAYD/console/	f	\N	f	WAYD	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
0a876099-5c08-40d4-972b-bdf0efc838be	t	f	admin-cli	0	t	\N	\N	f	\N	f	WAYD	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
5363183d-d4f0-4de6-81b0-65b43452bf8a	t	t	wayd-frontend	0	t	\N	\N	f	http://localhost:3000	f	WAYD	openid-connect	-1	f	f	\N	f	client-secret	http://localhost:3000	\N	\N	t	f	t	f
65c14276-8921-4060-8c93-941f468d53cb	t	t	user-service	0	f	w2I3mMBLDlEZXEyKpwMq13i3adL7fz6j	\N	f	\N	f	WAYD	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	f	f	t	f
9ed1cc96-2f27-43ad-933d-022f22f6d83d	t	t	moderation-service	0	f	NM643A0hIBn1oExQxpUuexy9uQv36ZgV	\N	f	\N	f	WAYD	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	f	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
3bb62974-3793-4ce9-8394-eae365f6de40	S256	pkce.code.challenge.method
c68246db-bb4f-4c9e-a771-0ead82f8362a	S256	pkce.code.challenge.method
55827f0e-432e-4a17-9122-832dd12da738	S256	pkce.code.challenge.method
19b2001f-f020-4955-a632-7867490abc98	S256	pkce.code.challenge.method
65c14276-8921-4060-8c93-941f468d53cb	true	backchannel.logout.session.required
65c14276-8921-4060-8c93-941f468d53cb	false	backchannel.logout.revoke.offline.tokens
65c14276-8921-4060-8c93-941f468d53cb	false	saml.artifact.binding
65c14276-8921-4060-8c93-941f468d53cb	false	saml.server.signature
65c14276-8921-4060-8c93-941f468d53cb	false	saml.server.signature.keyinfo.ext
65c14276-8921-4060-8c93-941f468d53cb	false	saml.assertion.signature
65c14276-8921-4060-8c93-941f468d53cb	false	saml.client.signature
65c14276-8921-4060-8c93-941f468d53cb	false	saml.encrypt
65c14276-8921-4060-8c93-941f468d53cb	false	saml.authnstatement
65c14276-8921-4060-8c93-941f468d53cb	false	saml.onetimeuse.condition
65c14276-8921-4060-8c93-941f468d53cb	false	saml_force_name_id_format
65c14276-8921-4060-8c93-941f468d53cb	false	saml.multivalued.roles
65c14276-8921-4060-8c93-941f468d53cb	false	saml.force.post.binding
65c14276-8921-4060-8c93-941f468d53cb	false	exclude.session.state.from.auth.response
65c14276-8921-4060-8c93-941f468d53cb	false	oauth2.device.authorization.grant.enabled
65c14276-8921-4060-8c93-941f468d53cb	false	oidc.ciba.grant.enabled
65c14276-8921-4060-8c93-941f468d53cb	true	use.refresh.tokens
65c14276-8921-4060-8c93-941f468d53cb	false	id.token.as.detached.signature
65c14276-8921-4060-8c93-941f468d53cb	false	tls.client.certificate.bound.access.tokens
65c14276-8921-4060-8c93-941f468d53cb	false	require.pushed.authorization.requests
65c14276-8921-4060-8c93-941f468d53cb	false	client_credentials.use_refresh_token
65c14276-8921-4060-8c93-941f468d53cb	false	display.on.consent.screen
9ed1cc96-2f27-43ad-933d-022f22f6d83d	true	backchannel.logout.session.required
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	backchannel.logout.revoke.offline.tokens
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	saml.artifact.binding
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	saml.server.signature
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	saml.server.signature.keyinfo.ext
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	saml.assertion.signature
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	saml.client.signature
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	saml.encrypt
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	saml.authnstatement
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	saml.onetimeuse.condition
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	saml_force_name_id_format
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	saml.multivalued.roles
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	saml.force.post.binding
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	exclude.session.state.from.auth.response
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	oauth2.device.authorization.grant.enabled
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	oidc.ciba.grant.enabled
9ed1cc96-2f27-43ad-933d-022f22f6d83d	true	use.refresh.tokens
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	id.token.as.detached.signature
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	tls.client.certificate.bound.access.tokens
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	require.pushed.authorization.requests
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	client_credentials.use_refresh_token
9ed1cc96-2f27-43ad-933d-022f22f6d83d	false	display.on.consent.screen
5363183d-d4f0-4de6-81b0-65b43452bf8a	true	backchannel.logout.session.required
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	backchannel.logout.revoke.offline.tokens
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	saml.artifact.binding
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	saml.server.signature
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	saml.server.signature.keyinfo.ext
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	saml.assertion.signature
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	saml.client.signature
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	saml.encrypt
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	saml.authnstatement
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	saml.onetimeuse.condition
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	saml_force_name_id_format
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	saml.multivalued.roles
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	saml.force.post.binding
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	exclude.session.state.from.auth.response
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	oauth2.device.authorization.grant.enabled
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	oidc.ciba.grant.enabled
5363183d-d4f0-4de6-81b0-65b43452bf8a	true	use.refresh.tokens
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	id.token.as.detached.signature
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	tls.client.certificate.bound.access.tokens
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	require.pushed.authorization.requests
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	client_credentials.use_refresh_token
5363183d-d4f0-4de6-81b0-65b43452bf8a	false	display.on.consent.screen
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
aa64c861-103d-4606-8512-fcf0826f282b	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
d6155016-18ed-4609-8860-3f15a61f075d	role_list	master	SAML role list	saml
45fd5274-de26-4e67-ad3f-dc15ea4d524c	profile	master	OpenID Connect built-in scope: profile	openid-connect
2e38a36a-6336-4d67-837e-1987ce47a43e	email	master	OpenID Connect built-in scope: email	openid-connect
a027a281-d7bd-43f1-a540-9efa40d9c61d	address	master	OpenID Connect built-in scope: address	openid-connect
efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8	phone	master	OpenID Connect built-in scope: phone	openid-connect
b995fac5-a75b-4c5b-9c2b-33bbd55925bd	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
06291250-febe-4f67-9820-1fb963a42946	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
37ccda3e-2940-4dba-af04-ff0331a2c105	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
dae0d07f-beab-4a6c-b22f-636678b23b5c	offline_access	WAYD	OpenID Connect built-in scope: offline_access	openid-connect
438498d7-d078-42cc-9a5b-a2f45df8c5db	role_list	WAYD	SAML role list	saml
2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	profile	WAYD	OpenID Connect built-in scope: profile	openid-connect
e38fad3b-7ce8-485a-9ba5-a0f9c8793876	email	WAYD	OpenID Connect built-in scope: email	openid-connect
af8db3a3-8743-4322-b602-8e26fcfdfda1	address	WAYD	OpenID Connect built-in scope: address	openid-connect
9dbade99-8bf1-4568-80da-12e85444461b	phone	WAYD	OpenID Connect built-in scope: phone	openid-connect
5504ac1a-a39b-4887-9b52-b8668026b428	roles	WAYD	OpenID Connect scope for add user roles to the access token	openid-connect
737f2954-2ac0-4d6b-9c56-5af59f6973a6	web-origins	WAYD	OpenID Connect scope for add allowed web origins to the access token	openid-connect
0f038f49-a281-4713-aaba-32e677f951cd	microprofile-jwt	WAYD	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
aa64c861-103d-4606-8512-fcf0826f282b	true	display.on.consent.screen
aa64c861-103d-4606-8512-fcf0826f282b	${offlineAccessScopeConsentText}	consent.screen.text
d6155016-18ed-4609-8860-3f15a61f075d	true	display.on.consent.screen
d6155016-18ed-4609-8860-3f15a61f075d	${samlRoleListScopeConsentText}	consent.screen.text
45fd5274-de26-4e67-ad3f-dc15ea4d524c	true	display.on.consent.screen
45fd5274-de26-4e67-ad3f-dc15ea4d524c	${profileScopeConsentText}	consent.screen.text
45fd5274-de26-4e67-ad3f-dc15ea4d524c	true	include.in.token.scope
2e38a36a-6336-4d67-837e-1987ce47a43e	true	display.on.consent.screen
2e38a36a-6336-4d67-837e-1987ce47a43e	${emailScopeConsentText}	consent.screen.text
2e38a36a-6336-4d67-837e-1987ce47a43e	true	include.in.token.scope
a027a281-d7bd-43f1-a540-9efa40d9c61d	true	display.on.consent.screen
a027a281-d7bd-43f1-a540-9efa40d9c61d	${addressScopeConsentText}	consent.screen.text
a027a281-d7bd-43f1-a540-9efa40d9c61d	true	include.in.token.scope
efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8	true	display.on.consent.screen
efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8	${phoneScopeConsentText}	consent.screen.text
efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8	true	include.in.token.scope
b995fac5-a75b-4c5b-9c2b-33bbd55925bd	true	display.on.consent.screen
b995fac5-a75b-4c5b-9c2b-33bbd55925bd	${rolesScopeConsentText}	consent.screen.text
b995fac5-a75b-4c5b-9c2b-33bbd55925bd	false	include.in.token.scope
06291250-febe-4f67-9820-1fb963a42946	false	display.on.consent.screen
06291250-febe-4f67-9820-1fb963a42946		consent.screen.text
06291250-febe-4f67-9820-1fb963a42946	false	include.in.token.scope
37ccda3e-2940-4dba-af04-ff0331a2c105	false	display.on.consent.screen
37ccda3e-2940-4dba-af04-ff0331a2c105	true	include.in.token.scope
dae0d07f-beab-4a6c-b22f-636678b23b5c	true	display.on.consent.screen
dae0d07f-beab-4a6c-b22f-636678b23b5c	${offlineAccessScopeConsentText}	consent.screen.text
438498d7-d078-42cc-9a5b-a2f45df8c5db	true	display.on.consent.screen
438498d7-d078-42cc-9a5b-a2f45df8c5db	${samlRoleListScopeConsentText}	consent.screen.text
2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	true	display.on.consent.screen
2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	${profileScopeConsentText}	consent.screen.text
2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	true	include.in.token.scope
e38fad3b-7ce8-485a-9ba5-a0f9c8793876	true	display.on.consent.screen
e38fad3b-7ce8-485a-9ba5-a0f9c8793876	${emailScopeConsentText}	consent.screen.text
e38fad3b-7ce8-485a-9ba5-a0f9c8793876	true	include.in.token.scope
af8db3a3-8743-4322-b602-8e26fcfdfda1	true	display.on.consent.screen
af8db3a3-8743-4322-b602-8e26fcfdfda1	${addressScopeConsentText}	consent.screen.text
af8db3a3-8743-4322-b602-8e26fcfdfda1	true	include.in.token.scope
9dbade99-8bf1-4568-80da-12e85444461b	true	display.on.consent.screen
9dbade99-8bf1-4568-80da-12e85444461b	${phoneScopeConsentText}	consent.screen.text
9dbade99-8bf1-4568-80da-12e85444461b	true	include.in.token.scope
5504ac1a-a39b-4887-9b52-b8668026b428	true	display.on.consent.screen
5504ac1a-a39b-4887-9b52-b8668026b428	${rolesScopeConsentText}	consent.screen.text
5504ac1a-a39b-4887-9b52-b8668026b428	false	include.in.token.scope
737f2954-2ac0-4d6b-9c56-5af59f6973a6	false	display.on.consent.screen
737f2954-2ac0-4d6b-9c56-5af59f6973a6		consent.screen.text
737f2954-2ac0-4d6b-9c56-5af59f6973a6	false	include.in.token.scope
0f038f49-a281-4713-aaba-32e677f951cd	false	display.on.consent.screen
0f038f49-a281-4713-aaba-32e677f951cd	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
89a05317-0b45-43f5-a267-534025915d0c	b995fac5-a75b-4c5b-9c2b-33bbd55925bd	t
89a05317-0b45-43f5-a267-534025915d0c	2e38a36a-6336-4d67-837e-1987ce47a43e	t
89a05317-0b45-43f5-a267-534025915d0c	45fd5274-de26-4e67-ad3f-dc15ea4d524c	t
89a05317-0b45-43f5-a267-534025915d0c	06291250-febe-4f67-9820-1fb963a42946	t
89a05317-0b45-43f5-a267-534025915d0c	aa64c861-103d-4606-8512-fcf0826f282b	f
89a05317-0b45-43f5-a267-534025915d0c	a027a281-d7bd-43f1-a540-9efa40d9c61d	f
89a05317-0b45-43f5-a267-534025915d0c	37ccda3e-2940-4dba-af04-ff0331a2c105	f
89a05317-0b45-43f5-a267-534025915d0c	efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8	f
3bb62974-3793-4ce9-8394-eae365f6de40	b995fac5-a75b-4c5b-9c2b-33bbd55925bd	t
3bb62974-3793-4ce9-8394-eae365f6de40	2e38a36a-6336-4d67-837e-1987ce47a43e	t
3bb62974-3793-4ce9-8394-eae365f6de40	45fd5274-de26-4e67-ad3f-dc15ea4d524c	t
3bb62974-3793-4ce9-8394-eae365f6de40	06291250-febe-4f67-9820-1fb963a42946	t
3bb62974-3793-4ce9-8394-eae365f6de40	aa64c861-103d-4606-8512-fcf0826f282b	f
3bb62974-3793-4ce9-8394-eae365f6de40	a027a281-d7bd-43f1-a540-9efa40d9c61d	f
3bb62974-3793-4ce9-8394-eae365f6de40	37ccda3e-2940-4dba-af04-ff0331a2c105	f
3bb62974-3793-4ce9-8394-eae365f6de40	efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8	f
d83f6ef0-8303-4fb5-93bd-1bd5f9095be2	b995fac5-a75b-4c5b-9c2b-33bbd55925bd	t
d83f6ef0-8303-4fb5-93bd-1bd5f9095be2	2e38a36a-6336-4d67-837e-1987ce47a43e	t
d83f6ef0-8303-4fb5-93bd-1bd5f9095be2	45fd5274-de26-4e67-ad3f-dc15ea4d524c	t
d83f6ef0-8303-4fb5-93bd-1bd5f9095be2	06291250-febe-4f67-9820-1fb963a42946	t
d83f6ef0-8303-4fb5-93bd-1bd5f9095be2	aa64c861-103d-4606-8512-fcf0826f282b	f
d83f6ef0-8303-4fb5-93bd-1bd5f9095be2	a027a281-d7bd-43f1-a540-9efa40d9c61d	f
d83f6ef0-8303-4fb5-93bd-1bd5f9095be2	37ccda3e-2940-4dba-af04-ff0331a2c105	f
d83f6ef0-8303-4fb5-93bd-1bd5f9095be2	efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8	f
fdea54ca-8fee-41fc-ad78-6540be507a83	b995fac5-a75b-4c5b-9c2b-33bbd55925bd	t
fdea54ca-8fee-41fc-ad78-6540be507a83	2e38a36a-6336-4d67-837e-1987ce47a43e	t
fdea54ca-8fee-41fc-ad78-6540be507a83	45fd5274-de26-4e67-ad3f-dc15ea4d524c	t
fdea54ca-8fee-41fc-ad78-6540be507a83	06291250-febe-4f67-9820-1fb963a42946	t
fdea54ca-8fee-41fc-ad78-6540be507a83	aa64c861-103d-4606-8512-fcf0826f282b	f
fdea54ca-8fee-41fc-ad78-6540be507a83	a027a281-d7bd-43f1-a540-9efa40d9c61d	f
fdea54ca-8fee-41fc-ad78-6540be507a83	37ccda3e-2940-4dba-af04-ff0331a2c105	f
fdea54ca-8fee-41fc-ad78-6540be507a83	efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8	f
9ec85d13-9c05-4026-85f9-2a00cdc30ece	b995fac5-a75b-4c5b-9c2b-33bbd55925bd	t
9ec85d13-9c05-4026-85f9-2a00cdc30ece	2e38a36a-6336-4d67-837e-1987ce47a43e	t
9ec85d13-9c05-4026-85f9-2a00cdc30ece	45fd5274-de26-4e67-ad3f-dc15ea4d524c	t
9ec85d13-9c05-4026-85f9-2a00cdc30ece	06291250-febe-4f67-9820-1fb963a42946	t
9ec85d13-9c05-4026-85f9-2a00cdc30ece	aa64c861-103d-4606-8512-fcf0826f282b	f
9ec85d13-9c05-4026-85f9-2a00cdc30ece	a027a281-d7bd-43f1-a540-9efa40d9c61d	f
9ec85d13-9c05-4026-85f9-2a00cdc30ece	37ccda3e-2940-4dba-af04-ff0331a2c105	f
9ec85d13-9c05-4026-85f9-2a00cdc30ece	efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8	f
c68246db-bb4f-4c9e-a771-0ead82f8362a	b995fac5-a75b-4c5b-9c2b-33bbd55925bd	t
c68246db-bb4f-4c9e-a771-0ead82f8362a	2e38a36a-6336-4d67-837e-1987ce47a43e	t
c68246db-bb4f-4c9e-a771-0ead82f8362a	45fd5274-de26-4e67-ad3f-dc15ea4d524c	t
c68246db-bb4f-4c9e-a771-0ead82f8362a	06291250-febe-4f67-9820-1fb963a42946	t
c68246db-bb4f-4c9e-a771-0ead82f8362a	aa64c861-103d-4606-8512-fcf0826f282b	f
c68246db-bb4f-4c9e-a771-0ead82f8362a	a027a281-d7bd-43f1-a540-9efa40d9c61d	f
c68246db-bb4f-4c9e-a771-0ead82f8362a	37ccda3e-2940-4dba-af04-ff0331a2c105	f
c68246db-bb4f-4c9e-a771-0ead82f8362a	efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8	f
f30380e2-97f9-45d9-9e54-80aca4bb0aa3	5504ac1a-a39b-4887-9b52-b8668026b428	t
f30380e2-97f9-45d9-9e54-80aca4bb0aa3	737f2954-2ac0-4d6b-9c56-5af59f6973a6	t
f30380e2-97f9-45d9-9e54-80aca4bb0aa3	e38fad3b-7ce8-485a-9ba5-a0f9c8793876	t
f30380e2-97f9-45d9-9e54-80aca4bb0aa3	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	t
f30380e2-97f9-45d9-9e54-80aca4bb0aa3	dae0d07f-beab-4a6c-b22f-636678b23b5c	f
f30380e2-97f9-45d9-9e54-80aca4bb0aa3	af8db3a3-8743-4322-b602-8e26fcfdfda1	f
f30380e2-97f9-45d9-9e54-80aca4bb0aa3	9dbade99-8bf1-4568-80da-12e85444461b	f
f30380e2-97f9-45d9-9e54-80aca4bb0aa3	0f038f49-a281-4713-aaba-32e677f951cd	f
55827f0e-432e-4a17-9122-832dd12da738	5504ac1a-a39b-4887-9b52-b8668026b428	t
55827f0e-432e-4a17-9122-832dd12da738	737f2954-2ac0-4d6b-9c56-5af59f6973a6	t
55827f0e-432e-4a17-9122-832dd12da738	e38fad3b-7ce8-485a-9ba5-a0f9c8793876	t
55827f0e-432e-4a17-9122-832dd12da738	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	t
55827f0e-432e-4a17-9122-832dd12da738	dae0d07f-beab-4a6c-b22f-636678b23b5c	f
55827f0e-432e-4a17-9122-832dd12da738	af8db3a3-8743-4322-b602-8e26fcfdfda1	f
55827f0e-432e-4a17-9122-832dd12da738	9dbade99-8bf1-4568-80da-12e85444461b	f
55827f0e-432e-4a17-9122-832dd12da738	0f038f49-a281-4713-aaba-32e677f951cd	f
0a876099-5c08-40d4-972b-bdf0efc838be	5504ac1a-a39b-4887-9b52-b8668026b428	t
0a876099-5c08-40d4-972b-bdf0efc838be	737f2954-2ac0-4d6b-9c56-5af59f6973a6	t
0a876099-5c08-40d4-972b-bdf0efc838be	e38fad3b-7ce8-485a-9ba5-a0f9c8793876	t
0a876099-5c08-40d4-972b-bdf0efc838be	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	t
0a876099-5c08-40d4-972b-bdf0efc838be	dae0d07f-beab-4a6c-b22f-636678b23b5c	f
0a876099-5c08-40d4-972b-bdf0efc838be	af8db3a3-8743-4322-b602-8e26fcfdfda1	f
0a876099-5c08-40d4-972b-bdf0efc838be	9dbade99-8bf1-4568-80da-12e85444461b	f
0a876099-5c08-40d4-972b-bdf0efc838be	0f038f49-a281-4713-aaba-32e677f951cd	f
af992157-4226-467a-b68b-27fea93abe0d	5504ac1a-a39b-4887-9b52-b8668026b428	t
af992157-4226-467a-b68b-27fea93abe0d	737f2954-2ac0-4d6b-9c56-5af59f6973a6	t
af992157-4226-467a-b68b-27fea93abe0d	e38fad3b-7ce8-485a-9ba5-a0f9c8793876	t
af992157-4226-467a-b68b-27fea93abe0d	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	t
af992157-4226-467a-b68b-27fea93abe0d	dae0d07f-beab-4a6c-b22f-636678b23b5c	f
af992157-4226-467a-b68b-27fea93abe0d	af8db3a3-8743-4322-b602-8e26fcfdfda1	f
af992157-4226-467a-b68b-27fea93abe0d	9dbade99-8bf1-4568-80da-12e85444461b	f
af992157-4226-467a-b68b-27fea93abe0d	0f038f49-a281-4713-aaba-32e677f951cd	f
8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	5504ac1a-a39b-4887-9b52-b8668026b428	t
8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	737f2954-2ac0-4d6b-9c56-5af59f6973a6	t
8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	e38fad3b-7ce8-485a-9ba5-a0f9c8793876	t
8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	t
8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	dae0d07f-beab-4a6c-b22f-636678b23b5c	f
8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	af8db3a3-8743-4322-b602-8e26fcfdfda1	f
8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	9dbade99-8bf1-4568-80da-12e85444461b	f
8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	0f038f49-a281-4713-aaba-32e677f951cd	f
19b2001f-f020-4955-a632-7867490abc98	5504ac1a-a39b-4887-9b52-b8668026b428	t
19b2001f-f020-4955-a632-7867490abc98	737f2954-2ac0-4d6b-9c56-5af59f6973a6	t
19b2001f-f020-4955-a632-7867490abc98	e38fad3b-7ce8-485a-9ba5-a0f9c8793876	t
19b2001f-f020-4955-a632-7867490abc98	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	t
19b2001f-f020-4955-a632-7867490abc98	dae0d07f-beab-4a6c-b22f-636678b23b5c	f
19b2001f-f020-4955-a632-7867490abc98	af8db3a3-8743-4322-b602-8e26fcfdfda1	f
19b2001f-f020-4955-a632-7867490abc98	9dbade99-8bf1-4568-80da-12e85444461b	f
19b2001f-f020-4955-a632-7867490abc98	0f038f49-a281-4713-aaba-32e677f951cd	f
65c14276-8921-4060-8c93-941f468d53cb	5504ac1a-a39b-4887-9b52-b8668026b428	t
65c14276-8921-4060-8c93-941f468d53cb	737f2954-2ac0-4d6b-9c56-5af59f6973a6	t
65c14276-8921-4060-8c93-941f468d53cb	e38fad3b-7ce8-485a-9ba5-a0f9c8793876	t
65c14276-8921-4060-8c93-941f468d53cb	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	t
65c14276-8921-4060-8c93-941f468d53cb	dae0d07f-beab-4a6c-b22f-636678b23b5c	f
65c14276-8921-4060-8c93-941f468d53cb	af8db3a3-8743-4322-b602-8e26fcfdfda1	f
65c14276-8921-4060-8c93-941f468d53cb	9dbade99-8bf1-4568-80da-12e85444461b	f
65c14276-8921-4060-8c93-941f468d53cb	0f038f49-a281-4713-aaba-32e677f951cd	f
9ed1cc96-2f27-43ad-933d-022f22f6d83d	5504ac1a-a39b-4887-9b52-b8668026b428	t
9ed1cc96-2f27-43ad-933d-022f22f6d83d	737f2954-2ac0-4d6b-9c56-5af59f6973a6	t
9ed1cc96-2f27-43ad-933d-022f22f6d83d	e38fad3b-7ce8-485a-9ba5-a0f9c8793876	t
9ed1cc96-2f27-43ad-933d-022f22f6d83d	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	t
9ed1cc96-2f27-43ad-933d-022f22f6d83d	dae0d07f-beab-4a6c-b22f-636678b23b5c	f
9ed1cc96-2f27-43ad-933d-022f22f6d83d	af8db3a3-8743-4322-b602-8e26fcfdfda1	f
9ed1cc96-2f27-43ad-933d-022f22f6d83d	9dbade99-8bf1-4568-80da-12e85444461b	f
9ed1cc96-2f27-43ad-933d-022f22f6d83d	0f038f49-a281-4713-aaba-32e677f951cd	f
5363183d-d4f0-4de6-81b0-65b43452bf8a	5504ac1a-a39b-4887-9b52-b8668026b428	t
5363183d-d4f0-4de6-81b0-65b43452bf8a	737f2954-2ac0-4d6b-9c56-5af59f6973a6	t
5363183d-d4f0-4de6-81b0-65b43452bf8a	e38fad3b-7ce8-485a-9ba5-a0f9c8793876	t
5363183d-d4f0-4de6-81b0-65b43452bf8a	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	t
5363183d-d4f0-4de6-81b0-65b43452bf8a	dae0d07f-beab-4a6c-b22f-636678b23b5c	f
5363183d-d4f0-4de6-81b0-65b43452bf8a	af8db3a3-8743-4322-b602-8e26fcfdfda1	f
5363183d-d4f0-4de6-81b0-65b43452bf8a	9dbade99-8bf1-4568-80da-12e85444461b	f
5363183d-d4f0-4de6-81b0-65b43452bf8a	0f038f49-a281-4713-aaba-32e677f951cd	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
aa64c861-103d-4606-8512-fcf0826f282b	88913bdd-ee17-46cf-9a76-50ac4f63ca9f
dae0d07f-beab-4a6c-b22f-636678b23b5c	19af3c56-dc3a-416b-8f58-9dbccca14129
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
ecfc7aaf-f4be-46af-8604-fc6475eec6db	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
aae25968-dd00-46cc-9d05-d13590468fc0	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
5e8d14b0-de4b-467f-8c53-d7d5eae0127f	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
2ebfe368-2fa2-43b3-a798-bf50f2f8d649	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
30572a37-eebb-4ad5-8a3d-2534ebf0f98c	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
efbbe0be-0f37-4f31-bc3c-743fa693b2e4	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
8e3c38fe-9913-4011-8fd4-453f1f5d0dba	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
82d7c4ab-767a-460c-a531-68b0ee065a43	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
ed80b0a0-34f9-42e3-ad4c-0ea51b969468	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
813ce313-73df-4cc8-836c-b5423e533e3f	rsa-enc-generated	master	rsa-enc-generated	org.keycloak.keys.KeyProvider	master	\N
f3f1be7a-f383-4208-97e6-4eeab7b7f55e	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
f24e18a0-8e0f-459f-9d1a-a8eb606ba2d8	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
6eead4d7-d43b-4c64-9013-0b894b227e1b	rsa-generated	WAYD	rsa-generated	org.keycloak.keys.KeyProvider	WAYD	\N
b4c1599f-fa03-4659-958b-3cd1e6202a42	rsa-enc-generated	WAYD	rsa-enc-generated	org.keycloak.keys.KeyProvider	WAYD	\N
2139b71d-8086-4675-aa45-3162385708bd	hmac-generated	WAYD	hmac-generated	org.keycloak.keys.KeyProvider	WAYD	\N
730e8059-2362-4c83-ac29-3c7783419da3	aes-generated	WAYD	aes-generated	org.keycloak.keys.KeyProvider	WAYD	\N
7c735339-be8a-4a0f-8c2b-8661edd446ab	Trusted Hosts	WAYD	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	WAYD	anonymous
61cdc34c-c81d-43b6-a696-cccc478d1c8e	Consent Required	WAYD	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	WAYD	anonymous
fd41c07c-1d57-4126-80c9-231b3c30198d	Full Scope Disabled	WAYD	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	WAYD	anonymous
5ced8b62-7e04-4881-ad61-a35755585f8e	Max Clients Limit	WAYD	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	WAYD	anonymous
46f421df-94c6-45e6-a412-445db3126865	Allowed Protocol Mapper Types	WAYD	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	WAYD	anonymous
e230185d-0696-4195-99f0-b104e2c43455	Allowed Client Scopes	WAYD	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	WAYD	anonymous
46351133-9b3c-4a67-bd32-76903b01f394	Allowed Protocol Mapper Types	WAYD	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	WAYD	authenticated
aa2a2b34-1fc0-4e9b-a029-503eaefddb83	Allowed Client Scopes	WAYD	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	WAYD	authenticated
1ca817ed-57ed-4396-849c-821622615051	\N	WAYD	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	WAYD	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
7bea2983-bf0b-4e61-913c-c6eec6493468	30572a37-eebb-4ad5-8a3d-2534ebf0f98c	allowed-protocol-mapper-types	oidc-address-mapper
6ca7eeda-4112-4017-a94c-30f3c5016026	30572a37-eebb-4ad5-8a3d-2534ebf0f98c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
80939efe-39c2-4f13-bcab-b16c8465dc6e	30572a37-eebb-4ad5-8a3d-2534ebf0f98c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7883b6fb-5265-4e86-9e1d-937275e31fc0	30572a37-eebb-4ad5-8a3d-2534ebf0f98c	allowed-protocol-mapper-types	saml-user-property-mapper
2dda977a-391b-4f9d-b308-470130e2e1de	30572a37-eebb-4ad5-8a3d-2534ebf0f98c	allowed-protocol-mapper-types	oidc-full-name-mapper
a5365694-e2de-4a73-929e-8f3335202c51	30572a37-eebb-4ad5-8a3d-2534ebf0f98c	allowed-protocol-mapper-types	saml-role-list-mapper
c78f3774-e99e-471a-b76c-2c0d4b288fd4	30572a37-eebb-4ad5-8a3d-2534ebf0f98c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d7e74ad8-8817-454b-accc-4f14c5c99e5e	30572a37-eebb-4ad5-8a3d-2534ebf0f98c	allowed-protocol-mapper-types	saml-user-attribute-mapper
3f3e1c8f-daa1-4960-b129-22a308f794e4	82d7c4ab-767a-460c-a531-68b0ee065a43	allow-default-scopes	true
160a9b61-c3b1-4dcc-8b80-f3c6d6719ff0	ecfc7aaf-f4be-46af-8604-fc6475eec6db	client-uris-must-match	true
f98d894d-a96e-4deb-b473-19e3fc5dc905	ecfc7aaf-f4be-46af-8604-fc6475eec6db	host-sending-registration-request-must-match	true
5b4b16f9-2d2e-4bcb-97e4-111eefdcfee2	efbbe0be-0f37-4f31-bc3c-743fa693b2e4	allow-default-scopes	true
9fef2645-6350-4ce9-897a-0da32a4777ab	8e3c38fe-9913-4011-8fd4-453f1f5d0dba	allowed-protocol-mapper-types	saml-user-attribute-mapper
c19c71e6-17a6-4c0b-86a0-5b5f753e6a81	8e3c38fe-9913-4011-8fd4-453f1f5d0dba	allowed-protocol-mapper-types	oidc-address-mapper
f7834c5b-00b5-4b01-98b2-3bf4f2e1e224	8e3c38fe-9913-4011-8fd4-453f1f5d0dba	allowed-protocol-mapper-types	saml-role-list-mapper
1ed8ff4e-1578-447e-8e62-d1eaa46fd28e	8e3c38fe-9913-4011-8fd4-453f1f5d0dba	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
73f632d1-0b06-4ee3-afdc-851babf6e1d0	8e3c38fe-9913-4011-8fd4-453f1f5d0dba	allowed-protocol-mapper-types	saml-user-property-mapper
4c6f54a5-ac4d-454f-b75d-33e321ec256b	8e3c38fe-9913-4011-8fd4-453f1f5d0dba	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
8e508fae-2ddb-40b9-bdc6-bebe55e43dc4	8e3c38fe-9913-4011-8fd4-453f1f5d0dba	allowed-protocol-mapper-types	oidc-full-name-mapper
b3af684b-79c9-4241-a1d4-5748b53f2e18	8e3c38fe-9913-4011-8fd4-453f1f5d0dba	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5b587d2d-a547-45ba-a814-aa19036869fd	2ebfe368-2fa2-43b3-a798-bf50f2f8d649	max-clients	200
a7c35380-bc8d-44d9-a72e-9c5ea5665444	f3f1be7a-f383-4208-97e6-4eeab7b7f55e	kid	20342cb4-fd4d-48f9-98b5-aaddd0399b83
6b26c39d-c007-4e7d-9721-cd5846349909	f3f1be7a-f383-4208-97e6-4eeab7b7f55e	algorithm	HS256
1fa39c0c-48fa-4497-bdde-419773ebd3f7	f3f1be7a-f383-4208-97e6-4eeab7b7f55e	priority	100
8457ca26-f0ad-41cb-8377-c653c715e62f	f3f1be7a-f383-4208-97e6-4eeab7b7f55e	secret	pTGEFReshtFZpRZ7nRQhEpk8KFMnQzGB8cwjLgAR_vFzkZiFBNafkllHwQykPxgwIosbqLVUcI4ZMaM7pyPG1A
3c870c52-2f7a-496a-a646-c8a9ce4f8d1b	ed80b0a0-34f9-42e3-ad4c-0ea51b969468	priority	100
9696752a-5069-4ec9-91cb-149e5b60986d	ed80b0a0-34f9-42e3-ad4c-0ea51b969468	privateKey	MIIEpAIBAAKCAQEAjsKsg8p8BrsBJ2vwFDdqqn4NbTTyZiTzuxcjjxSgNdcXygP+eBFOKH+R4Sr8V7BLkErFnpsTXoet+NP+lRUbw3wzj0Ypz3zle4U03yHOssYWA7M18AUdQz9rirKBMC5wKGfA8+siHz0sScqumScEn5uZR2slhO+mqm5hezo8zer2Sy75aHiv5YpWXy85YgixLI3hhd9xYJ50K5/X/kJH6SmrmENTeLyeA2xqetjSJ6NsmslMeGRMdYNMBL9yb6FPExn1UTw8zG1cSMI9iRjHYokdLASiyESl007X3rWb+zb34I/9l9Cs6Yhr4n8W0ooklrKJM+jEUYqgwwAw9t8IpQIDAQABAoIBAEZoWLD+8kBXhnAs2dD+q8q+NF0B2fLqkpJZDR6J66HiHUdyxNPupP9wO0Az9RRCTGIznldk4B6lB/ZKh6p7KKA25y7oScKdNIjA35yUjd65ty3H+vgPbak25BEZjIF4xbQHx7AE7WU+xFL4dTfveGZHVUdV3sE7eJVhrw4ZYNelJzI2HIvmcb/liX1q/hhRPXqDmZ2YyIYFu97HIbTkfY8wP4aK2W51qNzK/YQjR6GOZ4AWYhRM4RbMEovHpvWEdzni/a4rxDI2ujd/wzAj+zAYStPa4FrZBvSfUPSYQR79xTMVeXspKEpRcgkm4KXFItpx+sNsvCwStp3VC+SNL1kCgYEAy9Sk0vg25XQKNJ26Xu2cPMJBaoErVCqNuB0vot81qCwHYFaDLbrbZH7CFDMm2ulFCU4z1g8ftpjgfkS2k0SdG2Ac9IptJK56LkKB6RD3WB7SU+bAfUdezOoJ22tPsP7woGmy0UlpBeUEkGhdY2hTAtz7tI7Nd5EehJGRbPxs2KcCgYEAs0yZZg3lFBl2zn1q0HLwnVFPPGocqUBoQTlr+WbqpG4fX6c9BOTOrkKIMrV+9fxQJ5eO71U84DhgIsSQQWsEWr5UFQ8oSixnsymz5cagm7p9sHqWiCUnacKt+yL/Wi03FezKuuoIpRLKH5pQASfMI61aFxXM+KGzStbf5rxbsdMCgYEAjv1ar2FPaYIREr4/mw6HVxxTNbrtwXqktq9K1rBNfO9+MTgfiDoYZJSD5BXKQTH5q0CAHr+3WKpAenQLvJ4atLSlO2vMizoXHlKrveuYCOp+VDuBd6FUwN3CEnpiimEePvpHZohgM7FolUGRmgX6jfymWxD+1M0qIofYBCPE2+sCgYAGKfL4FDA04a846Azc/6aP8fSkYg18MA+ldmDk4Qnd/z8q3af2XBtS2EywWZb0w+jJg6dRSP/fwXBkoZdH+HLc38AqPSwoaKBkA2IA2zQ4Rk/92ikEoypYs22hvZFDu1wyb8KEbHlBm4TBU1++umyFKXd4ZbJ3Na/hOcPWvdD1KwKBgQCc2I+QMkt0ZoVdPHwkiigds/b9wlBxRucmlEGlFvaCQyfahX6ZJVtVhY1X2fUQ3dcMOibVCLRhTT4DdKu7OWbdgrUdkWeGXittDVguIYoSuyROReW7WVlR+tG5DBZICd3unHAf4ITCvwqsJfJ4KgPcXNn5yyj7TGIRQke6+SIoVw==
ed71cb64-a11d-4970-b369-81be74ddc1b0	ed80b0a0-34f9-42e3-ad4c-0ea51b969468	keyUse	SIG
3740f48b-e50c-45fc-881c-28be27948729	ed80b0a0-34f9-42e3-ad4c-0ea51b969468	certificate	MIICmzCCAYMCBgF+sMiF0zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwMTMxMTUzNTM4WhcNMzIwMTMxMTUzNzE4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCOwqyDynwGuwEna/AUN2qqfg1tNPJmJPO7FyOPFKA11xfKA/54EU4of5HhKvxXsEuQSsWemxNeh6340/6VFRvDfDOPRinPfOV7hTTfIc6yxhYDszXwBR1DP2uKsoEwLnAoZ8Dz6yIfPSxJyq6ZJwSfm5lHayWE76aqbmF7OjzN6vZLLvloeK/lilZfLzliCLEsjeGF33FgnnQrn9f+QkfpKauYQ1N4vJ4DbGp62NIno2yayUx4ZEx1g0wEv3JvoU8TGfVRPDzMbVxIwj2JGMdiiR0sBKLIRKXTTtfetZv7Nvfgj/2X0KzpiGvifxbSiiSWsokz6MRRiqDDADD23wilAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIIPP43iU0CTlZ0s4w2N+T8WC+VqtcMbE/b6r1SdjZ5hrc5+HuYpkWZiGM+PbPZQMuaeSCc+UBPwPNzLsWGBPrOzNgO1z6TBzsJpRzdnxiWoeK9wltwLNuHGBG1Pojf72jSFY2REYHiiuskqxsrsU3zWYVvpdRDfoVqtkOqZ2AyHy52Uwh9sHbvJzEorgUngdvP2l9/DpCO+Oliu6qCSZ2hy81ec3ULI5LjEmVEdA5QVsM8iXs/x4mf9TtxMsfE7DSlNGUwbk20hHSTBMFYgzMdY1LUSFnsuWaFV4QdBA0D98WGbl1h1Yl5nfJPG+eVud+dOyU9D8JVpcnT1vpKpwXo=
bfd62892-7e9a-490e-9a67-471190525215	813ce313-73df-4cc8-836c-b5423e533e3f	privateKey	MIIEogIBAAKCAQEAgZ8m040Cw+WMsLwewVsXb2oDTV7X6Yh0u5tGNXsUCgpODfWv/LCtK4TGLoJTFBxc5IDGklkFVxiRr4Nbytc/NmEtfWvlR3pKS7rwUTx6aqXQBwQJEE4RT+HaEcc1GP5uunFVyRmApnbG22Azw9nsvVRHtQzlPnV6HOKstyxuKXe8NFpdtmDHk5hA0vp6priGRcQJcZwtXZ9cnMoahbwpUUQBzM+Td7v/HJxZ67Gmuq9xGmyFwwQIc/DumGDBsKNEXHnjkJexMFnd2cLZciTTxJwTaLOBpsbcVyC4xSwDl+KoZqKmfDlcddKiFP2USmFBfE4aYL98ydbVtPN4JXp9PwIDAQABAoIBAGFffXtOYtVmi9n4d+Io2+IGcZSduvTkXUzRyFxEqTkhpKE3/4yD7JLUm0w0+tQQunethX5LAYf8HPUMaNhn+kSPm+ysMQERDN72/7EHDa8wAKZEkcp92uN3dqoETA8Kk4Pbv+XiEpL6h0glbL2j6AQSXAvWNCBHgARTBAxWhCsBggeeMSyyOp2b+JPE0w+fzJHuYQejD+8CLfP69hBoP0CMJbBLlMNwW/Msw14z/lstrZVFUwcQLPTqcXxNwDyMs+xtvB1R8itkCIHyvgTtB+YfDZjXCrskenFtOGqn0gOpDJD381P2u1lTRzb2uvXuU7TIkbGhIDJ+LyQgsn2AIgECgYEA117tZvk6ZYRbrSAL80T9jDfLpguF5pcNS2dqKOwqlzTXzoMybhCPIAZ7yt+KEo02rqgna7RhoqoaftwRnRcWbICWopnOGipFppV1uJT8FBUx1U7sZzNTHbFBykK6U/m1aEcZJ19bTr5RkhaeQXzPLvWMMTXjPT9QW1tPC5rRqO8CgYEAmhMS+yzIqgbMpMGBQSO7qYKOi41VzOFEIGbUyNtjEJv9LpBTUsBA7OEAaQ1dQmX71Xu9R5XQd+YrbnPZBRjxLWwPoxR/y8j6vK9m1jIL+pKs8q6tiwGkOFX2Am+j3yW7WfIWaVYOJULzdPFSKw1AfQDpUB0I6n54U2bJ1CHmULECgYBg16mOfRD6JvsGLPvSproP++LRxiqulkt/FYBR6Gf6V+OWU74wabfB4ch2X+/5CZCGFsyrDJA+kZiaZKBy77fAkE2rzdc0Qr/Q+THXDv8OlL00umloulZsapE3vquEKSueOSIhZypqjP+m3g7JSbLr3bPtSNrmZnreqX8wq6wM9wKBgF44t+zesEA6ND+1DmRVg9ffvWheIFBQmibue8XxVB2+JxCotivu4kV6O5QC1jtavq0JJPF4DqqkGX9MXTUe0a6jXNSwHo7y81McONlYdbbgp98pL3vInzLMbsuClkZKfs48m7QDKldjIBst0L//NKa9PfD+MIuml9L5EwglSwGhAoGAHAvVXpNo6tAPoyzyiQ0SNeOGs5XLLHpB0BNqtIdL5PTwkd7DI1BDBu/V2jqeoPjy84bDERn0nqTfa7AHiJqruDl7wOsDQpBW8Q7OZD3y7PRqmK3px1PGYxTbBcU6GEADvfTYAefaYjGTumOm+LSukceFWMu2LneyiBih3Y2amYM=
7fcaacbc-6e6d-4d35-89c4-42ac842620d4	813ce313-73df-4cc8-836c-b5423e533e3f	algorithm	RSA-OAEP
cbadc521-03d7-4584-a2a4-7294a301d7b7	813ce313-73df-4cc8-836c-b5423e533e3f	priority	100
6c54c7b9-76bf-441d-a4ef-31d9cfdbb37f	813ce313-73df-4cc8-836c-b5423e533e3f	keyUse	ENC
28ee9a8d-4c15-4473-8ee9-a097d6067e92	813ce313-73df-4cc8-836c-b5423e533e3f	certificate	MIICmzCCAYMCBgF+sMiGRzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwMTMxMTUzNTM4WhcNMzIwMTMxMTUzNzE4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCBnybTjQLD5YywvB7BWxdvagNNXtfpiHS7m0Y1exQKCk4N9a/8sK0rhMYuglMUHFzkgMaSWQVXGJGvg1vK1z82YS19a+VHekpLuvBRPHpqpdAHBAkQThFP4doRxzUY/m66cVXJGYCmdsbbYDPD2ey9VEe1DOU+dXoc4qy3LG4pd7w0Wl22YMeTmEDS+nqmuIZFxAlxnC1dn1ycyhqFvClRRAHMz5N3u/8cnFnrsaa6r3EabIXDBAhz8O6YYMGwo0RceeOQl7EwWd3ZwtlyJNPEnBNos4GmxtxXILjFLAOX4qhmoqZ8OVx10qIU/ZRKYUF8Thpgv3zJ1tW083glen0/AgMBAAEwDQYJKoZIhvcNAQELBQADggEBABJU2i1ek8VrUHRn8nMrmujQAS7iTbHH06e2AT5pBDxU15R4msTW5uYc6uu6BFpPTHG0V/vcoQMebeYBGJ0uX19KzXhTCyMvtC1di1r+d2NYgwyCFv6J7eMd2wiRdsvGuWdugXB9D75dy55kphTMPbF8r4KpR7cBCn+HE7rB51WHBkUq4shp1uPsdFSfA/b8hb5JZbXTcMmTxgmJyhjIFBA1OJQrGV3VwW3Xf4/UftLHQSlfphrQV7c1pJaRWOdhSdPO/GPAihBHtIYPnxmWETt3AB2pI2O5T1MjYmPEUj3f/8AbiSvYY5BupcMp2ykH0CmRDKY7mJvsrLQbp6Utn1I=
f4cf78a9-8c19-44ff-b076-af3a0806a858	f24e18a0-8e0f-459f-9d1a-a8eb606ba2d8	priority	100
03c2d88c-a35f-4c4c-b955-b45be6995300	f24e18a0-8e0f-459f-9d1a-a8eb606ba2d8	secret	WYrYuAriJcyieqixYNcu9Q
ae302ed8-c68e-4144-8741-c183ed59c9cc	f24e18a0-8e0f-459f-9d1a-a8eb606ba2d8	kid	79c262ac-bb1f-4b75-95fc-b25faf6c8d85
dfd1a117-3a7d-4967-ac7a-6da7b663362b	b4c1599f-fa03-4659-958b-3cd1e6202a42	priority	100
5228afb3-0c85-4e4d-ab04-11b50ec32741	b4c1599f-fa03-4659-958b-3cd1e6202a42	keyUse	ENC
ea661546-c33d-42ff-90de-dcb1c3ad6eee	b4c1599f-fa03-4659-958b-3cd1e6202a42	algorithm	RSA-OAEP
d596e370-3637-4b4e-ac1f-0dd413f171ba	b4c1599f-fa03-4659-958b-3cd1e6202a42	privateKey	MIIEogIBAAKCAQEAm5kAAccdEO12ZFprgh/qgjYGPtjkLcJgeCDY7cHhln4uvnBwIWy9QbIP2pGT87Q0LuJ/6+r8jjsfSWKpVJlrJe/dR69aRj4FARSXBJXQhz8BTsFXE+rIQyEQgCzPfA4J1cpvnh8h48d2+qZx1h4SDvTBmzw8J7yQRtPsJvWpw5Epc0yLAwPC0/WBx/BmRm9dcmQFECeck3b+HZwlO99t9t3lFFKYZPkwUd/gRckbt2AV5Y443zycG56QhQaig9jN2VqPHRM9zLrYZgRL4JH9DMlTiy7isQaM9Ju9v1ymiz8G1jgUh4UwQSWxHrEuxroL9d9Z1W2SOtB1uUkwTgq4lwIDAQABAoIBAGdOVerYQDwU7R4Dyo1Ck3iQVeU0K4sWGuanKF/y8cvxSye1jz0h7SXJCy2aqhiL9HmMeFIyWiw0pLkcgEBi+/jcIJaPneg1FS16dindLe4drsiTJTVcFEo9ka8IEVnUGEORfDoHgYCx1hTknYADxwmXB1QB0g6v6zqbSZc0U9o7ZS8o9ShhzZ/AdrkMO1qyRq70AEGGJAjJ3dGmnKs75n7JlelEkdJZBTq+koAI5IwGwDGiWoxbSf9NXxjPNMc60lxpw1pG+yB33v5nVDyDmFwpqaCj7ETnL+cjZy/77YGWBt15PlnDbrvO79iDQwLSAVx/zxIvJ+BVM/agXuXvmoECgYEA1OJ/fBqxsl6Z+aDG6dcBhVhsYRLg5m/YmMHZhIbmsx0TnEsEPsByr+qDzyUkcO9hHxIGD8uZOgu58AtZ9Uc8VLw8viANpqUBYpyNlwv/rDPeSgvQqA8QW4GlNPvOMgeks5kDcHwrt9UUpNksSoL/Ek071EwePY/6UwWirJBVYz8CgYEAuxxR54EPhcna27xlSG6Yhrbr7OlUO/VREn+9pgPCW1XD8xtUf3G5DfXnl1M4hrLX35KcX/cIrpQb/NUW7BS/VzrKslLb83UuDKX8FH708Mi3CmDV8Jc1wMeGGZIR+fcJ31afFb3drhVhy1JZqblSjhJAVFbRIXX/Mz86If3qzKkCgYBvPrkN2kk3g5YEy46GjfNegjmIdLwPzyypjssjJPeTa8NerhjWzexgnzUn3ynu1jizatC+Gk/E9HHCzbvBn+sYAJHhbJCVn65coKCg6QU/MI+dtBTibZTHrLTvPhKfND1OGMyiUFDsLK4wAsjRWyj9oFx+cRRwaTePgOdkM7xbMwKBgDP+O5gr2cdgfuteX3qQGNweSlKrx5ddpKiSTH2sP76nh2qvZnx/el+xvCflnSh429mpYMCd4ZC5YUmRYOw7G6w+jwKcWbg+EIy9Nt3vJVsfOxWsMObI7cvi5ZWHbG1cQycHZ+9fshDkqicYfAfYkmMeGTgWY8h7hG2WHS5C45L5AoGAHGvJuYi8U2fiM5W4lRLs0LM+Ke3Dn1g3FGQLL9SpGzN7prXQ7oubS+17V8zA2XDuFs4No6/WEUNG1eVafNGJFK6KO7fgXXE7pgmReMLG9izwnX0Gr2g8WvVF/5SXy//XXsmjjZbdK6L4Q6SOn4wSlNreZAEXf0i97qbvhvmOjyg=
20817019-9116-47d1-9638-5bf6d52abab2	b4c1599f-fa03-4659-958b-3cd1e6202a42	certificate	MIIClzCCAX8CBgF+sM2DEjANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARXQVlEMB4XDTIyMDEzMTE1NDEwNVoXDTMyMDEzMTE1NDI0NVowDzENMAsGA1UEAwwEV0FZRDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJuZAAHHHRDtdmRaa4If6oI2Bj7Y5C3CYHgg2O3B4ZZ+Lr5wcCFsvUGyD9qRk/O0NC7if+vq/I47H0liqVSZayXv3UevWkY+BQEUlwSV0Ic/AU7BVxPqyEMhEIAsz3wOCdXKb54fIePHdvqmcdYeEg70wZs8PCe8kEbT7Cb1qcORKXNMiwMDwtP1gcfwZkZvXXJkBRAnnJN2/h2cJTvfbfbd5RRSmGT5MFHf4EXJG7dgFeWOON88nBuekIUGooPYzdlajx0TPcy62GYES+CR/QzJU4su4rEGjPSbvb9cpos/BtY4FIeFMEElsR6xLsa6C/XfWdVtkjrQdblJME4KuJcCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAfEHz9tnvmFma+FazKUHl/3UM0zkpF7S2EFT0eo2PAx3eS3V8EeMg4wXuAl8TP6PP+9+6r6ZRJt6QOG1S7mkirG7C0xALI5DYtV1ZClM8X9VSg4sIybVImyjGw0US6Nd55ph0jAxGlYhOo4hmzS1hXgGFCq784EQGpfkkVJOJeu8jPMSHCZ/tHf5TzcQbipm55vkUvJCviq3/QD0HK1AJBW5ydIDXJ15ADz2barQ4biKJlu/NSmV7cZnLcWFiZWz37e8oWYJ68UOHgIDSIq4KfgV7Q+IjKnTMN9wq6n7Ctc6nux/BkOkzafe6HT12Sj44z50jCv5Oy1W0/GnLrgGfug==
83c70b26-baa7-40ad-a8af-63e5c70e89f2	6eead4d7-d43b-4c64-9013-0b894b227e1b	keyUse	SIG
b91cbb22-d37f-4760-b007-be42bd67eb5b	6eead4d7-d43b-4c64-9013-0b894b227e1b	certificate	MIIClzCCAX8CBgF+sM2CHzANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARXQVlEMB4XDTIyMDEzMTE1NDEwNVoXDTMyMDEzMTE1NDI0NVowDzENMAsGA1UEAwwEV0FZRDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6+gGKyJNErKuG/68nZWT9eHiWBc/2pgBAsd4uKoFnU6zHWO0TEoVc4Wx6CxOQAqk8mW9UMbWXdpmHJxqIn4cu10cIUuwYq+8094ieaQT7R1eWux9bY0jTS37tKI3Qyuw2uoJljrPtnRm7qGtZeXgrh0KO7vagaLqytF830Bl6Hgh/Vk61OLOnAwRz97ctZTPjhIwhLr/nIEFWFjUg7pe3CSAi7AH2frFRULmyfoXobIJ0bopzTm3KcCLajKeoyYFW0yHKMcDt10emcIcMdd+cbGrEKpK+7C72F83UhHbLsgQEaJDX9t871m4WiOKLkUwHNgjsAtk/SNf0M4HMA3zcCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAalWfusZXhT2vYihqTXszvDJoCP6M8O+pHsxyYXjKKa2K9soXHPI8jMPuNQ9M1ZgkGK/hG0zxHwTVL+weJnSFjSC98cRexaBb/pzwgS9i9WlUhWJucOnS3qOxFTODBNg2wg/jyI5HFRfsI1nImA2AmKpWNYyoS6BFWP797kYpfJnI2GmxBbcGGxKC26jMSQ+rhr743tRYLrJj05xiFmZsCCvAsV3xD0MrQn6GlGmfoLml7XCE5m44TJGLSInHSshugsKqjG2/fksUMYKcAlmKbBNEPr33/bOKyOwfX+y5O+X5Cic5IhHQ9EyNHnyY9VA34wrAOgEI+kdz/nhAYko+Dw==
ddc92aee-9065-450a-8aeb-f05c2365a9ff	6eead4d7-d43b-4c64-9013-0b894b227e1b	privateKey	MIIEpAIBAAKCAQEAvr6AYrIk0Ssq4b/rydlZP14eJYFz/amAECx3i4qgWdTrMdY7RMShVzhbHoLE5ACqTyZb1QxtZd2mYcnGoifhy7XRwhS7Bir7zT3iJ5pBPtHV5a7H1tjSNNLfu0ojdDK7Da6gmWOs+2dGbuoa1l5eCuHQo7u9qBourK0XzfQGXoeCH9WTrU4s6cDBHP3ty1lM+OEjCEuv+cgQVYWNSDul7cJICLsAfZ+sVFQubJ+hehsgnRuinNObcpwItqMp6jJgVbTIcoxwO3XR6Zwhwx135xsasQqkr7sLvYXzdSEdsuyBARokNf23zvWbhaI4ouRTAc2COwC2T9I1/QzgcwDfNwIDAQABAoIBAQCL2fsh4gGShzb6rA/CQCTqjCRIVYDo5EUsFp5T5oEpPC5xrORpyE2POJe+aBzaGw7D15kPPPxc6sWZ/yovLFSmWpn/1dlGbW+PjSbq6HOcDpfovlxxTynYZyB5HqOeB7AUGQxRSr7C2XbPzb99m1USX3zs/7LPtNqx6nuAmsGsviIc7jM6werZeSUGCkmVi+YOvhUaay79wwVV2GriygENOBhkK8gicr5P+TrfMxRqx6SmqEfZaTXA/W5mF4RwITnIaUx5exlGnAfAnBI689TVFH6zPGWY4f5dLy0gt4Mg5BhD55UIc5b//P2Dyn9NMPy2da3zQvykiM95xrHTNv7BAoGBAPZIE36RrFCCpZE413p+9orZ8/UCsOlnKUYd5xU6q3q/JKNwDovY8Xc9aKcsikg1f51d8HDYIep6+fqY0A47KPe/Nvgg+dsv2iiFiyqThT7P1nlEIXl1Sa8yGd6A4E+1bf61ANxMi8LIf01T1clBgOx0NnLtdEn6JS2CRszySaOXAoGBAMZFY6oiQlUhja/QHy95AKFHEds2EaOiV5iACLhcukYtHNPFgU4g2Q8i/rbO5FSxOPAS0lDC1EBCY9NrMumw1CHdbHTwiANuUqeXkILKyLjSg0IvHrUg1xeTstIu1pD8eFa0zIqb3Zb2TEtIDVzpOfZkfYWllrIIqXgG+y8+lZVhAoGAXUk/2Rlko7pY7IETXZrp1/5moc+7Iy2oPJ7nAOuQOJZeUmoHmIE8NWZVVb1RQ7i/9eO3R4cWkbKzLXDknf9arT0InUQgYB3oDKFI7X+jYP9oxdZAt7jtiCb6FYXLcWXPnEMDaG62IbnAPpIa0Hi3VNlQJog7HCpcGrjWCJtduVECgYAVO1UC4QxNZXxwuU69nK2Ol7e3y8Bzz2yl7gABDhz8atRNcTb5kNbtoge4t8sHrrq0Kq/O6i4ke3eJKk+XatIsljOJCkDmbSf4vmhBOUnpUNGxgq49IzklUzGxBEcB26dfUZkdtrcx9UoSPbMAohEM65Htf9/1TKwpKEY5tu/5wQKBgQDZm72kwaEQjVA6IIpLvpxDjfn461naNJfTZfnqcAAHLPuvoXqwwMm+j4jl+TJaexLCEsKgn97TZ6UgYHRq8KtWuAS8EFtP2wcPrNrAMja02OEa+U+vKQ6HlGkicr2TDSf4brR6vwUteVdFlZmpr8PeuXkX8Vn6LvkRnXO4EFqFWQ==
3798775d-c927-49df-9ced-09372434d3fc	6eead4d7-d43b-4c64-9013-0b894b227e1b	priority	100
d919cb82-a75d-46a7-94ef-f96f24018095	2139b71d-8086-4675-aa45-3162385708bd	algorithm	HS256
940a96b2-d73a-4d51-b5ea-68fd18267523	2139b71d-8086-4675-aa45-3162385708bd	priority	100
2e5259b8-83f1-4c48-88d7-e6631f82f4c8	2139b71d-8086-4675-aa45-3162385708bd	kid	962060c4-b6c2-4b15-8814-af0eafbd6169
18cc9a59-9ab6-4078-9683-b3022a21edd3	2139b71d-8086-4675-aa45-3162385708bd	secret	dwBsRaFFWr-3Uul-X6bFwybHQcEUb1Q2q2322_CLb1tm4Vg86Hhq2g49IQ5yc9QorWZmwsh_jkESH6vwI7L87Q
0082f2e3-fcf8-4de6-a904-6dbc1d3c47da	730e8059-2362-4c83-ac29-3c7783419da3	kid	f0f38277-fc9b-4c8f-8288-f81ba757ad9e
8f67231b-822b-4b78-9136-8c4dcdf49a7d	730e8059-2362-4c83-ac29-3c7783419da3	priority	100
fa1b6806-23b5-4760-b85c-dafb0c62810a	730e8059-2362-4c83-ac29-3c7783419da3	secret	q2_kbMDsUTbXtISzNi5R-g
aac33550-5839-4049-8537-e354debbd303	46f421df-94c6-45e6-a412-445db3126865	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
92b8bfad-f518-4747-97fe-6138b7b43072	46f421df-94c6-45e6-a412-445db3126865	allowed-protocol-mapper-types	oidc-address-mapper
ac1a3a92-7a05-4942-b9a6-8e7e961a7a9d	46f421df-94c6-45e6-a412-445db3126865	allowed-protocol-mapper-types	saml-user-property-mapper
c282ae02-32d8-47e8-8b77-b72a68af1ea9	46f421df-94c6-45e6-a412-445db3126865	allowed-protocol-mapper-types	saml-user-attribute-mapper
145e8d44-9186-4eea-86ba-75dee2be99ca	46f421df-94c6-45e6-a412-445db3126865	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6c3e3b3e-b193-4afb-b78d-b8d3229d9141	46f421df-94c6-45e6-a412-445db3126865	allowed-protocol-mapper-types	oidc-full-name-mapper
523084c2-015d-4aff-82e8-878ec69d3a6c	46f421df-94c6-45e6-a412-445db3126865	allowed-protocol-mapper-types	saml-role-list-mapper
3cbae38d-c573-4af6-8c7a-9bc21ee0aadb	46f421df-94c6-45e6-a412-445db3126865	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
16d6d72a-c588-4794-bea2-79a9619b8d78	7c735339-be8a-4a0f-8c2b-8661edd446ab	host-sending-registration-request-must-match	true
d1445860-f4bb-4df1-a2e6-788d5a04ef9e	7c735339-be8a-4a0f-8c2b-8661edd446ab	client-uris-must-match	true
3b867ec5-6a2e-4395-9093-ef47fd69381b	aa2a2b34-1fc0-4e9b-a029-503eaefddb83	allow-default-scopes	true
e256a945-c19a-401c-be17-3929bfd4b8d7	5ced8b62-7e04-4881-ad61-a35755585f8e	max-clients	200
e90898f0-8356-456c-9d85-250bf29122c7	e230185d-0696-4195-99f0-b104e2c43455	allow-default-scopes	true
62056011-a5ea-431a-8a8b-82ca745365a6	46351133-9b3c-4a67-bd32-76903b01f394	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d54834af-217e-441f-9ba0-4aa0c4ee8ff8	46351133-9b3c-4a67-bd32-76903b01f394	allowed-protocol-mapper-types	saml-role-list-mapper
71d86bd4-b426-44e7-8653-b344eb518144	46351133-9b3c-4a67-bd32-76903b01f394	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
de845ce5-ebd1-4482-9f5e-5f846ebc955a	46351133-9b3c-4a67-bd32-76903b01f394	allowed-protocol-mapper-types	saml-user-attribute-mapper
cc86caaa-9e68-4704-8ce5-d633690b1cce	46351133-9b3c-4a67-bd32-76903b01f394	allowed-protocol-mapper-types	oidc-address-mapper
4ee45f6a-3fc0-4e67-a12a-560755f93863	46351133-9b3c-4a67-bd32-76903b01f394	allowed-protocol-mapper-types	saml-user-property-mapper
2c3446a9-5cd7-46b6-8890-21dc51647cdf	46351133-9b3c-4a67-bd32-76903b01f394	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
fb263244-6da9-4f6f-a248-970e577a0482	46351133-9b3c-4a67-bd32-76903b01f394	allowed-protocol-mapper-types	oidc-full-name-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
575c4592-6e3f-499d-9cff-2e0393743a97	6b900cd4-0f50-4e75-b237-0d9e4f0e6e12
575c4592-6e3f-499d-9cff-2e0393743a97	a6e3433e-b61a-4c20-beee-47504a573048
575c4592-6e3f-499d-9cff-2e0393743a97	b84b9377-a357-4dc9-af65-9d726d874cad
575c4592-6e3f-499d-9cff-2e0393743a97	304aecf1-7889-4f57-9350-e6cc21cc01e3
575c4592-6e3f-499d-9cff-2e0393743a97	4af854ee-d0ab-49aa-8d29-9a741335629f
575c4592-6e3f-499d-9cff-2e0393743a97	2e99c7ce-c723-4e43-bb43-93ab824595f4
575c4592-6e3f-499d-9cff-2e0393743a97	4fd50bc9-b30d-4d50-9567-c0154ea8b446
575c4592-6e3f-499d-9cff-2e0393743a97	a0656aff-ab16-48de-bdb4-7c99ca45601b
575c4592-6e3f-499d-9cff-2e0393743a97	4515bf76-31e9-4ded-9f0f-1f20c70fbff5
575c4592-6e3f-499d-9cff-2e0393743a97	e515e4e1-2d25-4871-8a48-9e0900df8fac
575c4592-6e3f-499d-9cff-2e0393743a97	6be27291-1048-403a-ba31-012866c7257c
575c4592-6e3f-499d-9cff-2e0393743a97	8d5fd67e-59d6-4060-b2ee-4fc495786975
575c4592-6e3f-499d-9cff-2e0393743a97	d0dd52ca-dd3e-4bb0-8226-00e076dd81c8
575c4592-6e3f-499d-9cff-2e0393743a97	8470411d-c97e-4406-925d-bba35ce199b8
575c4592-6e3f-499d-9cff-2e0393743a97	cda5a572-6e9e-4457-908b-78b4aa382104
575c4592-6e3f-499d-9cff-2e0393743a97	7c1b5bb4-a9de-4b35-ae30-517bda69e14f
575c4592-6e3f-499d-9cff-2e0393743a97	866c0035-6170-4f0e-aae9-3812177d824f
575c4592-6e3f-499d-9cff-2e0393743a97	e2327a41-fe69-4fe1-810d-8ae17ea4c81c
4af854ee-d0ab-49aa-8d29-9a741335629f	7c1b5bb4-a9de-4b35-ae30-517bda69e14f
304aecf1-7889-4f57-9350-e6cc21cc01e3	e2327a41-fe69-4fe1-810d-8ae17ea4c81c
304aecf1-7889-4f57-9350-e6cc21cc01e3	cda5a572-6e9e-4457-908b-78b4aa382104
89553a41-93ff-498e-9c35-d033727bb88e	da5d5643-b176-4bb4-8430-de8322e2ff4c
89553a41-93ff-498e-9c35-d033727bb88e	eebbc780-87b6-41a7-8948-0a0a095c2ef3
eebbc780-87b6-41a7-8948-0a0a095c2ef3	a741b5e2-64d5-4dc0-a6c2-60c2e0c1518e
3beb7183-e20d-4b15-82a6-69a3256dcf66	904bebdd-79e0-43f5-bb2f-8db27b568433
575c4592-6e3f-499d-9cff-2e0393743a97	22346128-0360-44fb-a49d-ae5aeda1a88f
89553a41-93ff-498e-9c35-d033727bb88e	88913bdd-ee17-46cf-9a76-50ac4f63ca9f
89553a41-93ff-498e-9c35-d033727bb88e	e419c75d-3655-4157-9a88-f2f1ad6d382d
575c4592-6e3f-499d-9cff-2e0393743a97	0d9cc63c-dbb1-42e2-99a7-e898124de62b
575c4592-6e3f-499d-9cff-2e0393743a97	f8a8a52c-5f20-4132-8e3c-8a0bff7e7e8d
575c4592-6e3f-499d-9cff-2e0393743a97	b429465f-995f-463d-8751-845053dabcdb
575c4592-6e3f-499d-9cff-2e0393743a97	0b347acf-1780-4fb0-b2f3-a1f4468f0f87
575c4592-6e3f-499d-9cff-2e0393743a97	4f584874-98cf-4861-9e38-0118e2717ca5
575c4592-6e3f-499d-9cff-2e0393743a97	fce754ae-4e71-4d0e-9cb4-f049b6f156b1
575c4592-6e3f-499d-9cff-2e0393743a97	3fd5210d-8c24-49c3-bed5-482dad169a04
575c4592-6e3f-499d-9cff-2e0393743a97	7f1fda4d-41ef-4e43-a6c5-232029d45be8
575c4592-6e3f-499d-9cff-2e0393743a97	719c06d4-374f-4249-9e69-2f724690b9b2
575c4592-6e3f-499d-9cff-2e0393743a97	c8b70591-063e-4dbf-8f0d-f614c0b26355
575c4592-6e3f-499d-9cff-2e0393743a97	52d7b207-197e-4c8d-b496-1153852f1cc4
575c4592-6e3f-499d-9cff-2e0393743a97	18302f9f-c5ec-4838-8450-734df2197d9d
575c4592-6e3f-499d-9cff-2e0393743a97	3ca2ebf1-3c17-4d35-8016-cccdd004bb54
575c4592-6e3f-499d-9cff-2e0393743a97	a4fbb8a5-9f02-4dbd-80d1-e1c96d18e757
575c4592-6e3f-499d-9cff-2e0393743a97	0d04b2ab-7de2-4ed8-a6c2-312fef27c91b
575c4592-6e3f-499d-9cff-2e0393743a97	e22a0cb9-cf8a-478f-9dba-e1671f2f8f67
575c4592-6e3f-499d-9cff-2e0393743a97	4b1932e4-9c39-4422-93c1-bb7f802d1251
0b347acf-1780-4fb0-b2f3-a1f4468f0f87	0d04b2ab-7de2-4ed8-a6c2-312fef27c91b
b429465f-995f-463d-8751-845053dabcdb	4b1932e4-9c39-4422-93c1-bb7f802d1251
b429465f-995f-463d-8751-845053dabcdb	a4fbb8a5-9f02-4dbd-80d1-e1c96d18e757
d61c50b0-933f-4955-a1b7-e5c6d62761ee	38f33c02-a448-4aa7-bf09-0443f3ba6da7
d61c50b0-933f-4955-a1b7-e5c6d62761ee	aca4fc43-4680-4469-a43a-5b1d79f3acc5
d61c50b0-933f-4955-a1b7-e5c6d62761ee	9e9d07f0-26e2-4e90-83ff-90ad5564b3b7
d61c50b0-933f-4955-a1b7-e5c6d62761ee	21916ae1-259b-48e0-9064-42a68dc0904f
d61c50b0-933f-4955-a1b7-e5c6d62761ee	741435ce-d4be-44e8-be72-558920f51b9f
d61c50b0-933f-4955-a1b7-e5c6d62761ee	2d0b916c-29c2-49e8-96f4-edae043fbf0e
d61c50b0-933f-4955-a1b7-e5c6d62761ee	4d4fa898-5999-4767-8b38-1bb4a7a13f9e
d61c50b0-933f-4955-a1b7-e5c6d62761ee	47e1a663-cfd4-49fe-85f9-f55671cb04ba
d61c50b0-933f-4955-a1b7-e5c6d62761ee	7f5648dd-c3ff-4a99-bac3-00d83e7f4754
d61c50b0-933f-4955-a1b7-e5c6d62761ee	31c84a53-8a93-4fc4-9380-d8ba081c5286
d61c50b0-933f-4955-a1b7-e5c6d62761ee	74fb8ee6-e8da-4afa-a17d-ff77c970f2c1
d61c50b0-933f-4955-a1b7-e5c6d62761ee	621a53bc-1b6c-4471-9081-f2152343f46f
d61c50b0-933f-4955-a1b7-e5c6d62761ee	01bacde1-2d96-42d3-8eac-850916f1ca34
d61c50b0-933f-4955-a1b7-e5c6d62761ee	b6173d09-d6d2-4668-b56f-d5c84f059061
d61c50b0-933f-4955-a1b7-e5c6d62761ee	1d02bfa9-b95d-49be-8e35-efa2920b71fb
d61c50b0-933f-4955-a1b7-e5c6d62761ee	34ba7897-8b9f-4dc8-b841-253b32d3ece6
d61c50b0-933f-4955-a1b7-e5c6d62761ee	3f830fc4-ef89-416f-ad5b-55a448316db4
21916ae1-259b-48e0-9064-42a68dc0904f	1d02bfa9-b95d-49be-8e35-efa2920b71fb
9e9d07f0-26e2-4e90-83ff-90ad5564b3b7	3f830fc4-ef89-416f-ad5b-55a448316db4
9e9d07f0-26e2-4e90-83ff-90ad5564b3b7	b6173d09-d6d2-4668-b56f-d5c84f059061
b455deaf-0785-4491-b5cd-50e49ae5526d	f86220e0-5bc7-4adc-b52a-5ac9deaab183
b455deaf-0785-4491-b5cd-50e49ae5526d	13b5f2e2-b388-437e-97ad-4ffda750b871
13b5f2e2-b388-437e-97ad-4ffda750b871	f7e9d4dc-b3c8-4d7e-880a-de4ecc5165bb
29e124a6-16dd-470f-913c-851e82a3e7ef	adce93bd-8e13-4cb2-ba4d-b588f748c515
575c4592-6e3f-499d-9cff-2e0393743a97	23a9768c-606d-461f-a072-c8819cca5a7f
d61c50b0-933f-4955-a1b7-e5c6d62761ee	7b762dd9-10cb-411c-bd66-a4a37300c1d6
b455deaf-0785-4491-b5cd-50e49ae5526d	19af3c56-dc3a-416b-8f58-9dbccca14129
b455deaf-0785-4491-b5cd-50e49ae5526d	935a7298-f1dd-4b80-8dbe-3c530b52b230
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	01bacde1-2d96-42d3-8eac-850916f1ca34
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	741435ce-d4be-44e8-be72-558920f51b9f
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	34ba7897-8b9f-4dc8-b841-253b32d3ece6
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	38f33c02-a448-4aa7-bf09-0443f3ba6da7
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	2d0b916c-29c2-49e8-96f4-edae043fbf0e
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	9e9d07f0-26e2-4e90-83ff-90ad5564b3b7
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	74fb8ee6-e8da-4afa-a17d-ff77c970f2c1
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	7f5648dd-c3ff-4a99-bac3-00d83e7f4754
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	4d4fa898-5999-4767-8b38-1bb4a7a13f9e
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	1d02bfa9-b95d-49be-8e35-efa2920b71fb
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	31c84a53-8a93-4fc4-9380-d8ba081c5286
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	21916ae1-259b-48e0-9064-42a68dc0904f
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	aca4fc43-4680-4469-a43a-5b1d79f3acc5
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	621a53bc-1b6c-4471-9081-f2152343f46f
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	3f830fc4-ef89-416f-ad5b-55a448316db4
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	d61c50b0-933f-4955-a1b7-e5c6d62761ee
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	7b762dd9-10cb-411c-bd66-a4a37300c1d6
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	47e1a663-cfd4-49fe-85f9-f55671cb04ba
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	b6173d09-d6d2-4668-b56f-d5c84f059061
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
4239b09a-30a8-42bd-b773-dda2ef052c77	\N	password	e07f5ab2-2093-45cd-a4ce-98ce34091c77	1643643439088	\N	{"value":"/QAecYEOM3kzOvFPqJuBQwscKM43FUbbg7qyr6gkozbn2HHnYSE806B56mpsG9hYKX6H5CLJkyh3FVKQIoxHPw==","salt":"sS5tE/vLXFtN5ASoLZJXIA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
3ae01a3e-03ce-4a8a-b849-5251127f8b2d	\N	password	c67454de-5385-4c80-93a6-11a95242ceff	1643728867563	\N	{"value":"HbUCXshYXOqSfha7JtbcgGlYqLfIBzv8cU6EXLtEpGzLLDySo2V3JG8Qh+gkaW5kn2BNXHeIyI7cYhPuBX0/fg==","salt":"xGxdcko3p2bDFnEwIRe6AQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
246a938a-62af-4ee9-bfba-b7c3aaa7ce7c	\N	password	d6512e1f-144c-40e1-9a7b-3b1a69207cbf	1643728976779	\N	{"value":"hh6VBPkJ5xBh90EuKWHZOUI+i2PGPlZIwtVsLOxBf4Zwoq7f0+2ycMnEcSl7WtjRsi0GpwZrG9ba9ZWD13lk5A==","salt":"mu/802Qi5yyhvMCtGZEkeQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
d617093b-bc3e-46aa-a67e-dfd2e65b4110	\N	password	5b4ceba7-52e3-47c3-a41c-8c17b0b522a0	1644251981963	\N	{"value":"l9tu7CavSxZoFAhGi3kdz0g9qDgwLj+CBi2JEdEMpkLQb7WpvflWOvKNTUWFtwXYIK10Hydp7V6jZjUftFj5Hg==","salt":"p5AARuP6wvLUMs69TbfuKA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
be9e0283-82c2-48cd-960b-5b7fe2b73705	\N	password	100df59a-000e-4f86-934b-885080523f70	1645289363903	\N	{"value":"kFc1WfMRMCYoM3KLsHIiK78Ke5d8ImU01h6Q02pOp88kZKgpD/ahp2RoDNQbbQRTXDSPDsYw+nICpAcg4qpzZQ==","salt":"2+QXueTq/sGI2R9rocDOmQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
cfa5e75d-2b9e-4d99-990c-6e52b41c0f8f	\N	password	34e2e7f1-5f98-4d63-8224-7852ed1279b0	1646231692798	\N	{"value":"XyiGiYA+KS5mh5Ih4DyxQC4C7hmNMBLJZMyAFxsg7IkV+KudIxqaivdNfuOWGRgtEX6YMGLWEyM2A/bqQuTdGw==","salt":"ubwmmCoQDIOmK/YzWi9mXg==","additionalParameters":{}}	{"hashIterations":100000,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
1d606f3a-b3f8-4c52-b1fb-2cb1c65bfdd2	\N	password	f23cca33-1b1b-4368-8f5a-d1e031ee77af	1647093844099	\N	{"value":"DCYmo9ra3t2RdyIgpiq7QoBaVamBa2sqn3OQaIrYHpc+9su7ujCHuLrZOTTuSjKRo1a9UrjK+yo+n8kCdPYiJw==","salt":"yuk2RtvS+nvxGflyEYzs0g==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-01-31 15:37:11.284077	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3643430925
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-01-31 15:37:11.298079	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3643430925
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-01-31 15:37:11.340627	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	3643430925
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-01-31 15:37:11.345528	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3643430925
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-01-31 15:37:11.446352	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3643430925
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-01-31 15:37:11.450396	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3643430925
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-01-31 15:37:11.530338	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3643430925
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-01-31 15:37:11.535136	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3643430925
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-01-31 15:37:11.540855	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	3643430925
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-01-31 15:37:11.673198	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	3643430925
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-01-31 15:37:11.742937	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3643430925
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-01-31 15:37:11.74731	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3643430925
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-01-31 15:37:11.767788	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3643430925
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-01-31 15:37:11.792847	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	3643430925
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-01-31 15:37:11.79625	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3643430925
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-01-31 15:37:11.799563	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	3643430925
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-01-31 15:37:11.802639	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	3643430925
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-01-31 15:37:11.864208	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	3643430925
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-01-31 15:37:11.910564	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3643430925
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-01-31 15:37:11.915461	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3643430925
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-01-31 15:37:13.213139	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3643430925
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-01-31 15:37:11.918088	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3643430925
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-01-31 15:37:11.920775	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3643430925
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-01-31 15:37:11.961012	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	3643430925
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-01-31 15:37:11.96819	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3643430925
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-01-31 15:37:11.971099	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3643430925
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-01-31 15:37:12.196499	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	3643430925
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-01-31 15:37:12.291527	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	3643430925
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-01-31 15:37:12.295428	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3643430925
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-01-31 15:37:12.357875	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	3643430925
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-01-31 15:37:12.372537	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	3643430925
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-01-31 15:37:12.396393	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	3643430925
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-01-31 15:37:12.401874	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	3643430925
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-01-31 15:37:12.409008	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3643430925
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-01-31 15:37:12.412159	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3643430925
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-01-31 15:37:12.444748	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3643430925
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-01-31 15:37:12.451024	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	3643430925
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-01-31 15:37:12.459787	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3643430925
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-01-31 15:37:12.464852	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	3643430925
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-01-31 15:37:12.470193	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	3643430925
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-01-31 15:37:12.472995	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3643430925
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-01-31 15:37:12.475764	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3643430925
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-01-31 15:37:12.481108	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	3643430925
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-01-31 15:37:13.200992	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	3643430925
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-01-31 15:37:13.207546	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	3643430925
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-01-31 15:37:13.218154	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	3643430925
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-01-31 15:37:13.220825	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3643430925
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-01-31 15:37:13.299464	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	3643430925
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-01-31 15:37:13.305213	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	3643430925
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-01-31 15:37:13.359968	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	3643430925
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-01-31 15:37:13.530625	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	3643430925
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-01-31 15:37:13.538282	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3643430925
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-01-31 15:37:13.54158	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	3643430925
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-01-31 15:37:13.544721	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	3643430925
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-01-31 15:37:13.55272	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	3643430925
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-01-31 15:37:13.558257	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	3643430925
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-01-31 15:37:13.591093	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	3643430925
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-01-31 15:37:13.821051	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	3643430925
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-01-31 15:37:13.857729	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	3643430925
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-01-31 15:37:13.864944	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3643430925
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-01-31 15:37:13.8738	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	3643430925
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-01-31 15:37:13.883515	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	3643430925
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-01-31 15:37:13.88963	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3643430925
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-01-31 15:37:13.894025	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3643430925
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-01-31 15:37:13.901181	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	3643430925
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-01-31 15:37:13.930583	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	3643430925
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-01-31 15:37:13.949212	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	3643430925
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-01-31 15:37:13.954341	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	3643430925
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-01-31 15:37:13.976775	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	3643430925
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-01-31 15:37:13.983219	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	3643430925
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-01-31 15:37:13.988646	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	3643430925
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-01-31 15:37:13.995676	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3643430925
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-01-31 15:37:14.001739	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3643430925
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-01-31 15:37:14.004611	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3643430925
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-01-31 15:37:14.025664	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	3643430925
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-01-31 15:37:14.047991	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	3643430925
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-01-31 15:37:14.059863	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	3643430925
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-01-31 15:37:14.062529	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	3643430925
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-01-31 15:37:14.088956	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	3643430925
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-01-31 15:37:14.091981	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	3643430925
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-01-31 15:37:14.111438	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	3643430925
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-01-31 15:37:14.115181	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3643430925
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-01-31 15:37:14.121643	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3643430925
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-01-31 15:37:14.124671	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3643430925
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-01-31 15:37:14.144702	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3643430925
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-01-31 15:37:14.151049	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	3643430925
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-01-31 15:37:14.160012	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	3643430925
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-01-31 15:37:14.174939	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	3643430925
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-31 15:37:14.181215	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	3643430925
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-31 15:37:14.188531	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	3643430925
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-31 15:37:14.209933	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3643430925
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-31 15:37:14.218989	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	3643430925
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-31 15:37:14.222309	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	3643430925
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-31 15:37:14.23323	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	3643430925
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-31 15:37:14.23616	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	3643430925
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-01-31 15:37:14.247541	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	3643430925
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-31 15:37:14.297391	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3643430925
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-31 15:37:14.301933	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3643430925
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-31 15:37:14.315452	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3643430925
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-31 15:37:14.337857	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3643430925
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-31 15:37:14.341	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3643430925
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-31 15:37:14.358746	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	3643430925
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-01-31 15:37:14.365438	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	3643430925
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-01-31 15:37:14.372551	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	3643430925
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	aa64c861-103d-4606-8512-fcf0826f282b	f
master	d6155016-18ed-4609-8860-3f15a61f075d	t
master	45fd5274-de26-4e67-ad3f-dc15ea4d524c	t
master	2e38a36a-6336-4d67-837e-1987ce47a43e	t
master	a027a281-d7bd-43f1-a540-9efa40d9c61d	f
master	efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8	f
master	b995fac5-a75b-4c5b-9c2b-33bbd55925bd	t
master	06291250-febe-4f67-9820-1fb963a42946	t
master	37ccda3e-2940-4dba-af04-ff0331a2c105	f
WAYD	dae0d07f-beab-4a6c-b22f-636678b23b5c	f
WAYD	438498d7-d078-42cc-9a5b-a2f45df8c5db	t
WAYD	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5	t
WAYD	e38fad3b-7ce8-485a-9ba5-a0f9c8793876	t
WAYD	af8db3a3-8743-4322-b602-8e26fcfdfda1	f
WAYD	9dbade99-8bf1-4568-80da-12e85444461b	f
WAYD	5504ac1a-a39b-4887-9b52-b8668026b428	t
WAYD	737f2954-2ac0-4d6b-9c56-5af59f6973a6	t
WAYD	0f038f49-a281-4713-aaba-32e677f951cd	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
9d49abe4-8e24-4a81-be05-5973c8420c4e	a94df7ae-33b9-4a86-bd56-ef013c8d15ff
c9712bd3-0235-4f22-a51c-42104cf5967f	a94df7ae-33b9-4a86-bd56-ef013c8d15ff
7d38f1d0-c586-47be-808d-ed1354d23f7a	a94df7ae-33b9-4a86-bd56-ef013c8d15ff
ed9c670e-d048-4633-983e-7e4949714fb3	a94df7ae-33b9-4a86-bd56-ef013c8d15ff
c6b7af0c-b944-4caa-8bb4-af39b249fcf8	a21aca18-b552-4df5-b943-7a791ba3bdfa
ed9c670e-d048-4633-983e-7e4949714fb3	a21aca18-b552-4df5-b943-7a791ba3bdfa
c9712bd3-0235-4f22-a51c-42104cf5967f	2107a2a3-e596-4a09-8dbd-caecd1481506
7d38f1d0-c586-47be-808d-ed1354d23f7a	2107a2a3-e596-4a09-8dbd-caecd1481506
ed9c670e-d048-4633-983e-7e4949714fb3	2107a2a3-e596-4a09-8dbd-caecd1481506
7d38f1d0-c586-47be-808d-ed1354d23f7a	7610772d-8a5d-4f7f-95f7-a6b3cc5a53ac
ed9c670e-d048-4633-983e-7e4949714fb3	7610772d-8a5d-4f7f-95f7-a6b3cc5a53ac
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
a94df7ae-33b9-4a86-bd56-ef013c8d15ff	ADMIN_GROUP	 	WAYD
a21aca18-b552-4df5-b943-7a791ba3bdfa	ORGANIZATION_GROUP	 	WAYD
2107a2a3-e596-4a09-8dbd-caecd1481506	MODERATOR_GROUP	 	WAYD
7610772d-8a5d-4f7f-95f7-a6b3cc5a53ac	PERSON_GROUP	 	WAYD
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
89553a41-93ff-498e-9c35-d033727bb88e	master	f	${role_default-roles}	default-roles-master	master	\N	\N
575c4592-6e3f-499d-9cff-2e0393743a97	master	f	${role_admin}	admin	master	\N	\N
6b900cd4-0f50-4e75-b237-0d9e4f0e6e12	master	f	${role_create-realm}	create-realm	master	\N	\N
a6e3433e-b61a-4c20-beee-47504a573048	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_create-client}	create-client	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
b84b9377-a357-4dc9-af65-9d726d874cad	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_view-realm}	view-realm	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
304aecf1-7889-4f57-9350-e6cc21cc01e3	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_view-users}	view-users	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
4af854ee-d0ab-49aa-8d29-9a741335629f	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_view-clients}	view-clients	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
2e99c7ce-c723-4e43-bb43-93ab824595f4	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_view-events}	view-events	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
4fd50bc9-b30d-4d50-9567-c0154ea8b446	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_view-identity-providers}	view-identity-providers	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
a0656aff-ab16-48de-bdb4-7c99ca45601b	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_view-authorization}	view-authorization	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
4515bf76-31e9-4ded-9f0f-1f20c70fbff5	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_manage-realm}	manage-realm	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
e515e4e1-2d25-4871-8a48-9e0900df8fac	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_manage-users}	manage-users	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
6be27291-1048-403a-ba31-012866c7257c	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_manage-clients}	manage-clients	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
8d5fd67e-59d6-4060-b2ee-4fc495786975	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_manage-events}	manage-events	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
d0dd52ca-dd3e-4bb0-8226-00e076dd81c8	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_manage-identity-providers}	manage-identity-providers	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
8470411d-c97e-4406-925d-bba35ce199b8	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_manage-authorization}	manage-authorization	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
cda5a572-6e9e-4457-908b-78b4aa382104	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_query-users}	query-users	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
7c1b5bb4-a9de-4b35-ae30-517bda69e14f	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_query-clients}	query-clients	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
866c0035-6170-4f0e-aae9-3812177d824f	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_query-realms}	query-realms	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
e2327a41-fe69-4fe1-810d-8ae17ea4c81c	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_query-groups}	query-groups	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
da5d5643-b176-4bb4-8430-de8322e2ff4c	89a05317-0b45-43f5-a267-534025915d0c	t	${role_view-profile}	view-profile	master	89a05317-0b45-43f5-a267-534025915d0c	\N
eebbc780-87b6-41a7-8948-0a0a095c2ef3	89a05317-0b45-43f5-a267-534025915d0c	t	${role_manage-account}	manage-account	master	89a05317-0b45-43f5-a267-534025915d0c	\N
a741b5e2-64d5-4dc0-a6c2-60c2e0c1518e	89a05317-0b45-43f5-a267-534025915d0c	t	${role_manage-account-links}	manage-account-links	master	89a05317-0b45-43f5-a267-534025915d0c	\N
953308e0-c4be-4a37-8146-2ff2f3cc9675	89a05317-0b45-43f5-a267-534025915d0c	t	${role_view-applications}	view-applications	master	89a05317-0b45-43f5-a267-534025915d0c	\N
904bebdd-79e0-43f5-bb2f-8db27b568433	89a05317-0b45-43f5-a267-534025915d0c	t	${role_view-consent}	view-consent	master	89a05317-0b45-43f5-a267-534025915d0c	\N
3beb7183-e20d-4b15-82a6-69a3256dcf66	89a05317-0b45-43f5-a267-534025915d0c	t	${role_manage-consent}	manage-consent	master	89a05317-0b45-43f5-a267-534025915d0c	\N
cbbccd93-b7ba-4cc2-b1a1-1bac23e4f63b	89a05317-0b45-43f5-a267-534025915d0c	t	${role_delete-account}	delete-account	master	89a05317-0b45-43f5-a267-534025915d0c	\N
92a356ed-be58-4204-b08e-485659aa5281	fdea54ca-8fee-41fc-ad78-6540be507a83	t	${role_read-token}	read-token	master	fdea54ca-8fee-41fc-ad78-6540be507a83	\N
22346128-0360-44fb-a49d-ae5aeda1a88f	9ec85d13-9c05-4026-85f9-2a00cdc30ece	t	${role_impersonation}	impersonation	master	9ec85d13-9c05-4026-85f9-2a00cdc30ece	\N
88913bdd-ee17-46cf-9a76-50ac4f63ca9f	master	f	${role_offline-access}	offline_access	master	\N	\N
e419c75d-3655-4157-9a88-f2f1ad6d382d	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
b455deaf-0785-4491-b5cd-50e49ae5526d	WAYD	f	${role_default-roles}	default-roles-wayd	WAYD	\N	\N
0d9cc63c-dbb1-42e2-99a7-e898124de62b	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_create-client}	create-client	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
f8a8a52c-5f20-4132-8e3c-8a0bff7e7e8d	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_view-realm}	view-realm	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
b429465f-995f-463d-8751-845053dabcdb	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_view-users}	view-users	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
0b347acf-1780-4fb0-b2f3-a1f4468f0f87	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_view-clients}	view-clients	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
4f584874-98cf-4861-9e38-0118e2717ca5	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_view-events}	view-events	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
fce754ae-4e71-4d0e-9cb4-f049b6f156b1	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_view-identity-providers}	view-identity-providers	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
3fd5210d-8c24-49c3-bed5-482dad169a04	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_view-authorization}	view-authorization	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
7f1fda4d-41ef-4e43-a6c5-232029d45be8	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_manage-realm}	manage-realm	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
719c06d4-374f-4249-9e69-2f724690b9b2	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_manage-users}	manage-users	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
c8b70591-063e-4dbf-8f0d-f614c0b26355	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_manage-clients}	manage-clients	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
52d7b207-197e-4c8d-b496-1153852f1cc4	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_manage-events}	manage-events	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
18302f9f-c5ec-4838-8450-734df2197d9d	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_manage-identity-providers}	manage-identity-providers	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
3ca2ebf1-3c17-4d35-8016-cccdd004bb54	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_manage-authorization}	manage-authorization	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
a4fbb8a5-9f02-4dbd-80d1-e1c96d18e757	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_query-users}	query-users	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
0d04b2ab-7de2-4ed8-a6c2-312fef27c91b	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_query-clients}	query-clients	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
e22a0cb9-cf8a-478f-9dba-e1671f2f8f67	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_query-realms}	query-realms	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
4b1932e4-9c39-4422-93c1-bb7f802d1251	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_query-groups}	query-groups	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
d61c50b0-933f-4955-a1b7-e5c6d62761ee	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_realm-admin}	realm-admin	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
38f33c02-a448-4aa7-bf09-0443f3ba6da7	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_create-client}	create-client	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
aca4fc43-4680-4469-a43a-5b1d79f3acc5	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_view-realm}	view-realm	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
9e9d07f0-26e2-4e90-83ff-90ad5564b3b7	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_view-users}	view-users	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
21916ae1-259b-48e0-9064-42a68dc0904f	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_view-clients}	view-clients	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
741435ce-d4be-44e8-be72-558920f51b9f	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_view-events}	view-events	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
2d0b916c-29c2-49e8-96f4-edae043fbf0e	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_view-identity-providers}	view-identity-providers	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
4d4fa898-5999-4767-8b38-1bb4a7a13f9e	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_view-authorization}	view-authorization	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
47e1a663-cfd4-49fe-85f9-f55671cb04ba	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_manage-realm}	manage-realm	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
7f5648dd-c3ff-4a99-bac3-00d83e7f4754	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_manage-users}	manage-users	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
31c84a53-8a93-4fc4-9380-d8ba081c5286	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_manage-clients}	manage-clients	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
74fb8ee6-e8da-4afa-a17d-ff77c970f2c1	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_manage-events}	manage-events	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
621a53bc-1b6c-4471-9081-f2152343f46f	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_manage-identity-providers}	manage-identity-providers	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
01bacde1-2d96-42d3-8eac-850916f1ca34	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_manage-authorization}	manage-authorization	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
b6173d09-d6d2-4668-b56f-d5c84f059061	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_query-users}	query-users	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
1d02bfa9-b95d-49be-8e35-efa2920b71fb	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_query-clients}	query-clients	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
34ba7897-8b9f-4dc8-b841-253b32d3ece6	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_query-realms}	query-realms	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
3f830fc4-ef89-416f-ad5b-55a448316db4	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_query-groups}	query-groups	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
f86220e0-5bc7-4adc-b52a-5ac9deaab183	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	t	${role_view-profile}	view-profile	WAYD	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	\N
13b5f2e2-b388-437e-97ad-4ffda750b871	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	t	${role_manage-account}	manage-account	WAYD	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	\N
f7e9d4dc-b3c8-4d7e-880a-de4ecc5165bb	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	t	${role_manage-account-links}	manage-account-links	WAYD	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	\N
b9a01cb9-fa53-4aac-b725-253ebac65632	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	t	${role_view-applications}	view-applications	WAYD	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	\N
adce93bd-8e13-4cb2-ba4d-b588f748c515	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	t	${role_view-consent}	view-consent	WAYD	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	\N
29e124a6-16dd-470f-913c-851e82a3e7ef	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	t	${role_manage-consent}	manage-consent	WAYD	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	\N
c89df76a-aca4-473b-b71b-0f3051385db1	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	t	${role_delete-account}	delete-account	WAYD	f30380e2-97f9-45d9-9e54-80aca4bb0aa3	\N
23a9768c-606d-461f-a072-c8819cca5a7f	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	t	${role_impersonation}	impersonation	master	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	\N
7b762dd9-10cb-411c-bd66-a4a37300c1d6	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	t	${role_impersonation}	impersonation	WAYD	8e3c01c9-d1ca-4e79-adb1-3eb817e8223a	\N
6dbf94d8-f5be-4a28-b8f6-a34536fff6d0	af992157-4226-467a-b68b-27fea93abe0d	t	${role_read-token}	read-token	WAYD	af992157-4226-467a-b68b-27fea93abe0d	\N
19af3c56-dc3a-416b-8f58-9dbccca14129	WAYD	f	${role_offline-access}	offline_access	WAYD	\N	\N
935a7298-f1dd-4b80-8dbe-3c530b52b230	WAYD	f	${role_uma_authorization}	uma_authorization	WAYD	\N	\N
9d49abe4-8e24-4a81-be05-5973c8420c4e	WAYD	f	\N	ROLE_ADMIN	WAYD	\N	\N
c9712bd3-0235-4f22-a51c-42104cf5967f	WAYD	f	\N	ROLE_MODERATOR	WAYD	\N	\N
7d38f1d0-c586-47be-808d-ed1354d23f7a	WAYD	f	\N	ROLE_PERSON	WAYD	\N	\N
c6b7af0c-b944-4caa-8bb4-af39b249fcf8	WAYD	f	\N	ROLE_ORGANIZATION	WAYD	\N	\N
ed9c670e-d048-4633-983e-7e4949714fb3	WAYD	f	\N	ROLE_USER	WAYD	\N	\N
ad0032c8-7b95-4430-b221-1e74a29bf3f5	65c14276-8921-4060-8c93-941f468d53cb	t	\N	uma_protection	WAYD	65c14276-8921-4060-8c93-941f468d53cb	\N
1f8d9ded-6734-4f79-899f-09ebf94f1d2c	WAYD	f	\N	user_admin	WAYD	\N	\N
f45ae11f-34f1-408f-9ea3-12948203f238	9ed1cc96-2f27-43ad-933d-022f22f6d83d	t	\N	uma_protection	WAYD	9ed1cc96-2f27-43ad-933d-022f22f6d83d	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
uo6ch	16.1.1	1643643437
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
33c17a47-b7ad-4853-8036-21ef8fa0da9f	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
834ecbe0-2039-45a9-84b0-a685c85cb9eb	defaultResourceType	urn:user-service:resources:default
da0190b1-eb03-49b8-97e4-26496e2106be	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
6aa3a39c-4413-4058-a1b6-310e1e46de4d	defaultResourceType	urn:moderator-service:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
4be6f5d9-8d9b-430b-8f02-0673f387c94b	audience resolve	openid-connect	oidc-audience-resolve-mapper	3bb62974-3793-4ce9-8394-eae365f6de40	\N
cc9955be-71ea-4816-b5fe-b7fb733a045a	locale	openid-connect	oidc-usermodel-attribute-mapper	c68246db-bb4f-4c9e-a771-0ead82f8362a	\N
28190b37-2b3c-433e-970a-1b2a404ed61f	role list	saml	saml-role-list-mapper	\N	d6155016-18ed-4609-8860-3f15a61f075d
95003e42-cb75-46f3-a6d2-4c9de1a1b636	full name	openid-connect	oidc-full-name-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
fa55a8ff-a0c5-4563-9541-f928cb410a2e	family name	openid-connect	oidc-usermodel-property-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
6af1666d-330d-47f4-9970-d2ba42cc082d	given name	openid-connect	oidc-usermodel-property-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
30dd383d-f983-49f8-b580-8d337fbf9730	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
51d3fd17-b6ed-43a2-a8c1-96f7d511b32f	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
1224c240-221d-4cd4-a0f4-c4fcbd15b822	username	openid-connect	oidc-usermodel-property-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
1050f64e-7f00-419c-b688-45c684a0ce76	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
a1073b28-832c-47f2-8a25-0b0586f608ab	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
24100316-6137-4ab4-b20e-40d411626928	website	openid-connect	oidc-usermodel-attribute-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
4b8ad611-f032-4afa-b634-0fdab7d6700c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
539cea49-1d40-4832-9288-d6d2fa3e8a14	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
4b8f0fd7-1360-4c98-a7de-bfca8436c92c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
05a64397-dce1-437e-92d2-955270e13dc1	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
d7dae402-daf5-4d9d-93f0-b47bd039eeb4	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	45fd5274-de26-4e67-ad3f-dc15ea4d524c
2dcf3cc1-344a-4ce9-a7b3-f887463ccde2	email	openid-connect	oidc-usermodel-property-mapper	\N	2e38a36a-6336-4d67-837e-1987ce47a43e
a699510a-b697-48be-b9f4-671c75becf0b	email verified	openid-connect	oidc-usermodel-property-mapper	\N	2e38a36a-6336-4d67-837e-1987ce47a43e
7c302049-2fbb-4a22-801a-bd45d2a843db	address	openid-connect	oidc-address-mapper	\N	a027a281-d7bd-43f1-a540-9efa40d9c61d
3416de51-a7d9-4d63-9f95-1001dac920e7	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8
cb0c089f-c01d-4ae1-a784-d28b7bf8de6a	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	efd9b5b0-479d-40a3-8da6-cf3d57e3c8c8
7d5414d4-f1c6-4a50-8ff5-4921ea638f4d	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	b995fac5-a75b-4c5b-9c2b-33bbd55925bd
051683ba-cc74-411b-9aba-51ff781d053b	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	b995fac5-a75b-4c5b-9c2b-33bbd55925bd
16f01e44-afe8-4b20-9ae8-f5002d8af02a	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	b995fac5-a75b-4c5b-9c2b-33bbd55925bd
60ff3d77-a6cc-4e49-b6aa-791ab7d81c21	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	06291250-febe-4f67-9820-1fb963a42946
54c6a111-2a1f-4d7a-986b-cdfbdf56a557	upn	openid-connect	oidc-usermodel-property-mapper	\N	37ccda3e-2940-4dba-af04-ff0331a2c105
d3bbde8c-cb84-4b95-9c72-7054e52bc7db	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	37ccda3e-2940-4dba-af04-ff0331a2c105
c7956a69-ca6c-4682-8644-b49112d817ba	audience resolve	openid-connect	oidc-audience-resolve-mapper	55827f0e-432e-4a17-9122-832dd12da738	\N
2410fb32-5c7e-4d4b-8b8f-7ff1c5cc4294	role list	saml	saml-role-list-mapper	\N	438498d7-d078-42cc-9a5b-a2f45df8c5db
7f153dc1-4ab6-4dd9-b5dc-bc1def067599	full name	openid-connect	oidc-full-name-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
3f21eb3b-12eb-43e1-8699-55a08e9c3431	family name	openid-connect	oidc-usermodel-property-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
bcad4bdc-461d-4039-9c8e-69da3b5b0149	given name	openid-connect	oidc-usermodel-property-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
87f6d06d-6490-4840-8cee-b887bf42ac68	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
f88a0120-5376-47fc-b714-a75945ada3c6	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
1a083179-4939-43f2-a97e-24185c4bc4f6	username	openid-connect	oidc-usermodel-property-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
e83c1e69-1b98-4964-bf6f-d43947953343	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
4f3d6d63-ac15-4cd7-b0b8-1c528ac894ce	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
7720c9c9-e0a9-4a9f-9409-8e9848d545aa	website	openid-connect	oidc-usermodel-attribute-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
e494113d-1a9d-4120-bb33-65f472b106f9	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
72d514a2-6f20-4292-a54d-259f45180539	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
c9f5077b-55ef-40ee-82dd-74a2a1d14139	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
1e74fe6f-ae09-4cb7-8f8d-340cc6b97296	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
6022d2d2-fe60-4386-af67-b6c2fa776444	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	2aad9bb2-2d42-42a7-b107-b95d0f3d66f5
282349f1-da64-4ab3-bb32-2d9d6611146a	email	openid-connect	oidc-usermodel-property-mapper	\N	e38fad3b-7ce8-485a-9ba5-a0f9c8793876
f2a4492f-d59b-4fdd-9378-d0f1261770bc	email verified	openid-connect	oidc-usermodel-property-mapper	\N	e38fad3b-7ce8-485a-9ba5-a0f9c8793876
c9a72cc6-1854-45c4-b68d-f87fec5ccc4e	address	openid-connect	oidc-address-mapper	\N	af8db3a3-8743-4322-b602-8e26fcfdfda1
a4d1431f-5841-45e7-8477-80cc95b0a0d2	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	9dbade99-8bf1-4568-80da-12e85444461b
2a9ca720-fda3-4b78-955d-010ed123537f	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	9dbade99-8bf1-4568-80da-12e85444461b
6fe0be10-d535-4138-94c3-95eb317c77b2	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	5504ac1a-a39b-4887-9b52-b8668026b428
a2379148-8536-4695-aee8-35c09d2d3678	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	5504ac1a-a39b-4887-9b52-b8668026b428
88b5cbe0-99fe-48a1-bfe8-60d8fbf64e09	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	5504ac1a-a39b-4887-9b52-b8668026b428
6069c986-86dc-4cce-aa37-169d8082293d	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	737f2954-2ac0-4d6b-9c56-5af59f6973a6
498e66e5-fd7c-4f26-b114-a17f991779ad	upn	openid-connect	oidc-usermodel-property-mapper	\N	0f038f49-a281-4713-aaba-32e677f951cd
c6b934d6-231e-4630-9015-ef4a899d171e	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	0f038f49-a281-4713-aaba-32e677f951cd
0beb7617-2655-4b07-9a68-7fd43ab1c20f	locale	openid-connect	oidc-usermodel-attribute-mapper	19b2001f-f020-4955-a632-7867490abc98	\N
f2e83186-a920-4e50-9705-81861987b871	dateOfBirth	openid-connect	oidc-usermodel-attribute-mapper	65c14276-8921-4060-8c93-941f468d53cb	\N
b8465866-3189-4268-aada-3138dbcbff40	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	65c14276-8921-4060-8c93-941f468d53cb	\N
ff34af20-a19e-4863-bcdc-88345173b75b	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	65c14276-8921-4060-8c93-941f468d53cb	\N
e57d272c-1c5c-4ae3-9fb6-fe50681c055a	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	65c14276-8921-4060-8c93-941f468d53cb	\N
61093f62-9bb7-489b-be70-2bd310faad2f	status	openid-connect	oidc-usermodel-attribute-mapper	65c14276-8921-4060-8c93-941f468d53cb	\N
aaae98be-e621-4c17-bbb5-1af85648d659	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	9ed1cc96-2f27-43ad-933d-022f22f6d83d	\N
c19a05f6-0c1b-4bb5-a8e9-54f51f9abfa8	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	9ed1cc96-2f27-43ad-933d-022f22f6d83d	\N
a2e7e556-0893-42e9-937c-5248054a3fd8	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	9ed1cc96-2f27-43ad-933d-022f22f6d83d	\N
ed3cef6d-251c-41c9-97ab-13212014aa86	dateOfBirth	openid-connect	oidc-usermodel-attribute-mapper	5363183d-d4f0-4de6-81b0-65b43452bf8a	\N
d0019beb-b477-4b91-b198-ac1c9d827124	status	openid-connect	oidc-usermodel-attribute-mapper	5363183d-d4f0-4de6-81b0-65b43452bf8a	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
cc9955be-71ea-4816-b5fe-b7fb733a045a	true	userinfo.token.claim
cc9955be-71ea-4816-b5fe-b7fb733a045a	locale	user.attribute
cc9955be-71ea-4816-b5fe-b7fb733a045a	true	id.token.claim
cc9955be-71ea-4816-b5fe-b7fb733a045a	true	access.token.claim
cc9955be-71ea-4816-b5fe-b7fb733a045a	locale	claim.name
cc9955be-71ea-4816-b5fe-b7fb733a045a	String	jsonType.label
28190b37-2b3c-433e-970a-1b2a404ed61f	false	single
28190b37-2b3c-433e-970a-1b2a404ed61f	Basic	attribute.nameformat
28190b37-2b3c-433e-970a-1b2a404ed61f	Role	attribute.name
95003e42-cb75-46f3-a6d2-4c9de1a1b636	true	userinfo.token.claim
95003e42-cb75-46f3-a6d2-4c9de1a1b636	true	id.token.claim
95003e42-cb75-46f3-a6d2-4c9de1a1b636	true	access.token.claim
fa55a8ff-a0c5-4563-9541-f928cb410a2e	true	userinfo.token.claim
fa55a8ff-a0c5-4563-9541-f928cb410a2e	lastName	user.attribute
fa55a8ff-a0c5-4563-9541-f928cb410a2e	true	id.token.claim
fa55a8ff-a0c5-4563-9541-f928cb410a2e	true	access.token.claim
fa55a8ff-a0c5-4563-9541-f928cb410a2e	family_name	claim.name
fa55a8ff-a0c5-4563-9541-f928cb410a2e	String	jsonType.label
6af1666d-330d-47f4-9970-d2ba42cc082d	true	userinfo.token.claim
6af1666d-330d-47f4-9970-d2ba42cc082d	firstName	user.attribute
6af1666d-330d-47f4-9970-d2ba42cc082d	true	id.token.claim
6af1666d-330d-47f4-9970-d2ba42cc082d	true	access.token.claim
6af1666d-330d-47f4-9970-d2ba42cc082d	given_name	claim.name
6af1666d-330d-47f4-9970-d2ba42cc082d	String	jsonType.label
30dd383d-f983-49f8-b580-8d337fbf9730	true	userinfo.token.claim
30dd383d-f983-49f8-b580-8d337fbf9730	middleName	user.attribute
30dd383d-f983-49f8-b580-8d337fbf9730	true	id.token.claim
30dd383d-f983-49f8-b580-8d337fbf9730	true	access.token.claim
30dd383d-f983-49f8-b580-8d337fbf9730	middle_name	claim.name
30dd383d-f983-49f8-b580-8d337fbf9730	String	jsonType.label
51d3fd17-b6ed-43a2-a8c1-96f7d511b32f	true	userinfo.token.claim
51d3fd17-b6ed-43a2-a8c1-96f7d511b32f	nickname	user.attribute
51d3fd17-b6ed-43a2-a8c1-96f7d511b32f	true	id.token.claim
51d3fd17-b6ed-43a2-a8c1-96f7d511b32f	true	access.token.claim
51d3fd17-b6ed-43a2-a8c1-96f7d511b32f	nickname	claim.name
51d3fd17-b6ed-43a2-a8c1-96f7d511b32f	String	jsonType.label
1224c240-221d-4cd4-a0f4-c4fcbd15b822	true	userinfo.token.claim
1224c240-221d-4cd4-a0f4-c4fcbd15b822	username	user.attribute
1224c240-221d-4cd4-a0f4-c4fcbd15b822	true	id.token.claim
1224c240-221d-4cd4-a0f4-c4fcbd15b822	true	access.token.claim
1224c240-221d-4cd4-a0f4-c4fcbd15b822	preferred_username	claim.name
1224c240-221d-4cd4-a0f4-c4fcbd15b822	String	jsonType.label
1050f64e-7f00-419c-b688-45c684a0ce76	true	userinfo.token.claim
1050f64e-7f00-419c-b688-45c684a0ce76	profile	user.attribute
1050f64e-7f00-419c-b688-45c684a0ce76	true	id.token.claim
1050f64e-7f00-419c-b688-45c684a0ce76	true	access.token.claim
1050f64e-7f00-419c-b688-45c684a0ce76	profile	claim.name
1050f64e-7f00-419c-b688-45c684a0ce76	String	jsonType.label
a1073b28-832c-47f2-8a25-0b0586f608ab	true	userinfo.token.claim
a1073b28-832c-47f2-8a25-0b0586f608ab	picture	user.attribute
a1073b28-832c-47f2-8a25-0b0586f608ab	true	id.token.claim
a1073b28-832c-47f2-8a25-0b0586f608ab	true	access.token.claim
a1073b28-832c-47f2-8a25-0b0586f608ab	picture	claim.name
a1073b28-832c-47f2-8a25-0b0586f608ab	String	jsonType.label
24100316-6137-4ab4-b20e-40d411626928	true	userinfo.token.claim
24100316-6137-4ab4-b20e-40d411626928	website	user.attribute
24100316-6137-4ab4-b20e-40d411626928	true	id.token.claim
24100316-6137-4ab4-b20e-40d411626928	true	access.token.claim
24100316-6137-4ab4-b20e-40d411626928	website	claim.name
24100316-6137-4ab4-b20e-40d411626928	String	jsonType.label
4b8ad611-f032-4afa-b634-0fdab7d6700c	true	userinfo.token.claim
4b8ad611-f032-4afa-b634-0fdab7d6700c	gender	user.attribute
4b8ad611-f032-4afa-b634-0fdab7d6700c	true	id.token.claim
4b8ad611-f032-4afa-b634-0fdab7d6700c	true	access.token.claim
4b8ad611-f032-4afa-b634-0fdab7d6700c	gender	claim.name
4b8ad611-f032-4afa-b634-0fdab7d6700c	String	jsonType.label
539cea49-1d40-4832-9288-d6d2fa3e8a14	true	userinfo.token.claim
539cea49-1d40-4832-9288-d6d2fa3e8a14	birthdate	user.attribute
539cea49-1d40-4832-9288-d6d2fa3e8a14	true	id.token.claim
539cea49-1d40-4832-9288-d6d2fa3e8a14	true	access.token.claim
539cea49-1d40-4832-9288-d6d2fa3e8a14	birthdate	claim.name
539cea49-1d40-4832-9288-d6d2fa3e8a14	String	jsonType.label
4b8f0fd7-1360-4c98-a7de-bfca8436c92c	true	userinfo.token.claim
4b8f0fd7-1360-4c98-a7de-bfca8436c92c	zoneinfo	user.attribute
4b8f0fd7-1360-4c98-a7de-bfca8436c92c	true	id.token.claim
4b8f0fd7-1360-4c98-a7de-bfca8436c92c	true	access.token.claim
4b8f0fd7-1360-4c98-a7de-bfca8436c92c	zoneinfo	claim.name
4b8f0fd7-1360-4c98-a7de-bfca8436c92c	String	jsonType.label
05a64397-dce1-437e-92d2-955270e13dc1	true	userinfo.token.claim
05a64397-dce1-437e-92d2-955270e13dc1	locale	user.attribute
05a64397-dce1-437e-92d2-955270e13dc1	true	id.token.claim
05a64397-dce1-437e-92d2-955270e13dc1	true	access.token.claim
05a64397-dce1-437e-92d2-955270e13dc1	locale	claim.name
05a64397-dce1-437e-92d2-955270e13dc1	String	jsonType.label
d7dae402-daf5-4d9d-93f0-b47bd039eeb4	true	userinfo.token.claim
d7dae402-daf5-4d9d-93f0-b47bd039eeb4	updatedAt	user.attribute
d7dae402-daf5-4d9d-93f0-b47bd039eeb4	true	id.token.claim
d7dae402-daf5-4d9d-93f0-b47bd039eeb4	true	access.token.claim
d7dae402-daf5-4d9d-93f0-b47bd039eeb4	updated_at	claim.name
d7dae402-daf5-4d9d-93f0-b47bd039eeb4	String	jsonType.label
2dcf3cc1-344a-4ce9-a7b3-f887463ccde2	true	userinfo.token.claim
2dcf3cc1-344a-4ce9-a7b3-f887463ccde2	email	user.attribute
2dcf3cc1-344a-4ce9-a7b3-f887463ccde2	true	id.token.claim
2dcf3cc1-344a-4ce9-a7b3-f887463ccde2	true	access.token.claim
2dcf3cc1-344a-4ce9-a7b3-f887463ccde2	email	claim.name
2dcf3cc1-344a-4ce9-a7b3-f887463ccde2	String	jsonType.label
a699510a-b697-48be-b9f4-671c75becf0b	true	userinfo.token.claim
a699510a-b697-48be-b9f4-671c75becf0b	emailVerified	user.attribute
a699510a-b697-48be-b9f4-671c75becf0b	true	id.token.claim
a699510a-b697-48be-b9f4-671c75becf0b	true	access.token.claim
a699510a-b697-48be-b9f4-671c75becf0b	email_verified	claim.name
a699510a-b697-48be-b9f4-671c75becf0b	boolean	jsonType.label
7c302049-2fbb-4a22-801a-bd45d2a843db	formatted	user.attribute.formatted
7c302049-2fbb-4a22-801a-bd45d2a843db	country	user.attribute.country
7c302049-2fbb-4a22-801a-bd45d2a843db	postal_code	user.attribute.postal_code
7c302049-2fbb-4a22-801a-bd45d2a843db	true	userinfo.token.claim
7c302049-2fbb-4a22-801a-bd45d2a843db	street	user.attribute.street
7c302049-2fbb-4a22-801a-bd45d2a843db	true	id.token.claim
7c302049-2fbb-4a22-801a-bd45d2a843db	region	user.attribute.region
7c302049-2fbb-4a22-801a-bd45d2a843db	true	access.token.claim
7c302049-2fbb-4a22-801a-bd45d2a843db	locality	user.attribute.locality
3416de51-a7d9-4d63-9f95-1001dac920e7	true	userinfo.token.claim
3416de51-a7d9-4d63-9f95-1001dac920e7	phoneNumber	user.attribute
3416de51-a7d9-4d63-9f95-1001dac920e7	true	id.token.claim
3416de51-a7d9-4d63-9f95-1001dac920e7	true	access.token.claim
3416de51-a7d9-4d63-9f95-1001dac920e7	phone_number	claim.name
3416de51-a7d9-4d63-9f95-1001dac920e7	String	jsonType.label
cb0c089f-c01d-4ae1-a784-d28b7bf8de6a	true	userinfo.token.claim
cb0c089f-c01d-4ae1-a784-d28b7bf8de6a	phoneNumberVerified	user.attribute
cb0c089f-c01d-4ae1-a784-d28b7bf8de6a	true	id.token.claim
cb0c089f-c01d-4ae1-a784-d28b7bf8de6a	true	access.token.claim
cb0c089f-c01d-4ae1-a784-d28b7bf8de6a	phone_number_verified	claim.name
cb0c089f-c01d-4ae1-a784-d28b7bf8de6a	boolean	jsonType.label
7d5414d4-f1c6-4a50-8ff5-4921ea638f4d	true	multivalued
7d5414d4-f1c6-4a50-8ff5-4921ea638f4d	foo	user.attribute
7d5414d4-f1c6-4a50-8ff5-4921ea638f4d	true	access.token.claim
7d5414d4-f1c6-4a50-8ff5-4921ea638f4d	realm_access.roles	claim.name
7d5414d4-f1c6-4a50-8ff5-4921ea638f4d	String	jsonType.label
051683ba-cc74-411b-9aba-51ff781d053b	true	multivalued
051683ba-cc74-411b-9aba-51ff781d053b	foo	user.attribute
051683ba-cc74-411b-9aba-51ff781d053b	true	access.token.claim
051683ba-cc74-411b-9aba-51ff781d053b	resource_access.${client_id}.roles	claim.name
051683ba-cc74-411b-9aba-51ff781d053b	String	jsonType.label
54c6a111-2a1f-4d7a-986b-cdfbdf56a557	true	userinfo.token.claim
54c6a111-2a1f-4d7a-986b-cdfbdf56a557	username	user.attribute
54c6a111-2a1f-4d7a-986b-cdfbdf56a557	true	id.token.claim
54c6a111-2a1f-4d7a-986b-cdfbdf56a557	true	access.token.claim
54c6a111-2a1f-4d7a-986b-cdfbdf56a557	upn	claim.name
54c6a111-2a1f-4d7a-986b-cdfbdf56a557	String	jsonType.label
d3bbde8c-cb84-4b95-9c72-7054e52bc7db	true	multivalued
d3bbde8c-cb84-4b95-9c72-7054e52bc7db	foo	user.attribute
d3bbde8c-cb84-4b95-9c72-7054e52bc7db	true	id.token.claim
d3bbde8c-cb84-4b95-9c72-7054e52bc7db	true	access.token.claim
d3bbde8c-cb84-4b95-9c72-7054e52bc7db	groups	claim.name
d3bbde8c-cb84-4b95-9c72-7054e52bc7db	String	jsonType.label
2410fb32-5c7e-4d4b-8b8f-7ff1c5cc4294	false	single
2410fb32-5c7e-4d4b-8b8f-7ff1c5cc4294	Basic	attribute.nameformat
2410fb32-5c7e-4d4b-8b8f-7ff1c5cc4294	Role	attribute.name
7f153dc1-4ab6-4dd9-b5dc-bc1def067599	true	userinfo.token.claim
7f153dc1-4ab6-4dd9-b5dc-bc1def067599	true	id.token.claim
7f153dc1-4ab6-4dd9-b5dc-bc1def067599	true	access.token.claim
3f21eb3b-12eb-43e1-8699-55a08e9c3431	true	userinfo.token.claim
3f21eb3b-12eb-43e1-8699-55a08e9c3431	lastName	user.attribute
3f21eb3b-12eb-43e1-8699-55a08e9c3431	true	id.token.claim
3f21eb3b-12eb-43e1-8699-55a08e9c3431	true	access.token.claim
3f21eb3b-12eb-43e1-8699-55a08e9c3431	family_name	claim.name
3f21eb3b-12eb-43e1-8699-55a08e9c3431	String	jsonType.label
bcad4bdc-461d-4039-9c8e-69da3b5b0149	true	userinfo.token.claim
bcad4bdc-461d-4039-9c8e-69da3b5b0149	firstName	user.attribute
bcad4bdc-461d-4039-9c8e-69da3b5b0149	true	id.token.claim
bcad4bdc-461d-4039-9c8e-69da3b5b0149	true	access.token.claim
bcad4bdc-461d-4039-9c8e-69da3b5b0149	given_name	claim.name
bcad4bdc-461d-4039-9c8e-69da3b5b0149	String	jsonType.label
87f6d06d-6490-4840-8cee-b887bf42ac68	true	userinfo.token.claim
87f6d06d-6490-4840-8cee-b887bf42ac68	middleName	user.attribute
87f6d06d-6490-4840-8cee-b887bf42ac68	true	id.token.claim
87f6d06d-6490-4840-8cee-b887bf42ac68	true	access.token.claim
87f6d06d-6490-4840-8cee-b887bf42ac68	middle_name	claim.name
87f6d06d-6490-4840-8cee-b887bf42ac68	String	jsonType.label
f88a0120-5376-47fc-b714-a75945ada3c6	true	userinfo.token.claim
f88a0120-5376-47fc-b714-a75945ada3c6	nickname	user.attribute
f88a0120-5376-47fc-b714-a75945ada3c6	true	id.token.claim
f88a0120-5376-47fc-b714-a75945ada3c6	true	access.token.claim
f88a0120-5376-47fc-b714-a75945ada3c6	nickname	claim.name
f88a0120-5376-47fc-b714-a75945ada3c6	String	jsonType.label
1a083179-4939-43f2-a97e-24185c4bc4f6	true	userinfo.token.claim
1a083179-4939-43f2-a97e-24185c4bc4f6	username	user.attribute
1a083179-4939-43f2-a97e-24185c4bc4f6	true	id.token.claim
1a083179-4939-43f2-a97e-24185c4bc4f6	true	access.token.claim
1a083179-4939-43f2-a97e-24185c4bc4f6	preferred_username	claim.name
1a083179-4939-43f2-a97e-24185c4bc4f6	String	jsonType.label
e83c1e69-1b98-4964-bf6f-d43947953343	true	userinfo.token.claim
e83c1e69-1b98-4964-bf6f-d43947953343	profile	user.attribute
e83c1e69-1b98-4964-bf6f-d43947953343	true	id.token.claim
e83c1e69-1b98-4964-bf6f-d43947953343	true	access.token.claim
e83c1e69-1b98-4964-bf6f-d43947953343	profile	claim.name
e83c1e69-1b98-4964-bf6f-d43947953343	String	jsonType.label
4f3d6d63-ac15-4cd7-b0b8-1c528ac894ce	true	userinfo.token.claim
4f3d6d63-ac15-4cd7-b0b8-1c528ac894ce	picture	user.attribute
4f3d6d63-ac15-4cd7-b0b8-1c528ac894ce	true	id.token.claim
4f3d6d63-ac15-4cd7-b0b8-1c528ac894ce	true	access.token.claim
4f3d6d63-ac15-4cd7-b0b8-1c528ac894ce	picture	claim.name
4f3d6d63-ac15-4cd7-b0b8-1c528ac894ce	String	jsonType.label
7720c9c9-e0a9-4a9f-9409-8e9848d545aa	true	userinfo.token.claim
7720c9c9-e0a9-4a9f-9409-8e9848d545aa	website	user.attribute
7720c9c9-e0a9-4a9f-9409-8e9848d545aa	true	id.token.claim
7720c9c9-e0a9-4a9f-9409-8e9848d545aa	true	access.token.claim
7720c9c9-e0a9-4a9f-9409-8e9848d545aa	website	claim.name
7720c9c9-e0a9-4a9f-9409-8e9848d545aa	String	jsonType.label
e494113d-1a9d-4120-bb33-65f472b106f9	true	userinfo.token.claim
e494113d-1a9d-4120-bb33-65f472b106f9	gender	user.attribute
e494113d-1a9d-4120-bb33-65f472b106f9	true	id.token.claim
e494113d-1a9d-4120-bb33-65f472b106f9	true	access.token.claim
e494113d-1a9d-4120-bb33-65f472b106f9	gender	claim.name
e494113d-1a9d-4120-bb33-65f472b106f9	String	jsonType.label
72d514a2-6f20-4292-a54d-259f45180539	true	userinfo.token.claim
72d514a2-6f20-4292-a54d-259f45180539	birthdate	user.attribute
72d514a2-6f20-4292-a54d-259f45180539	true	id.token.claim
72d514a2-6f20-4292-a54d-259f45180539	true	access.token.claim
72d514a2-6f20-4292-a54d-259f45180539	birthdate	claim.name
72d514a2-6f20-4292-a54d-259f45180539	String	jsonType.label
c9f5077b-55ef-40ee-82dd-74a2a1d14139	true	userinfo.token.claim
c9f5077b-55ef-40ee-82dd-74a2a1d14139	zoneinfo	user.attribute
c9f5077b-55ef-40ee-82dd-74a2a1d14139	true	id.token.claim
c9f5077b-55ef-40ee-82dd-74a2a1d14139	true	access.token.claim
c9f5077b-55ef-40ee-82dd-74a2a1d14139	zoneinfo	claim.name
c9f5077b-55ef-40ee-82dd-74a2a1d14139	String	jsonType.label
1e74fe6f-ae09-4cb7-8f8d-340cc6b97296	true	userinfo.token.claim
1e74fe6f-ae09-4cb7-8f8d-340cc6b97296	locale	user.attribute
1e74fe6f-ae09-4cb7-8f8d-340cc6b97296	true	id.token.claim
1e74fe6f-ae09-4cb7-8f8d-340cc6b97296	true	access.token.claim
1e74fe6f-ae09-4cb7-8f8d-340cc6b97296	locale	claim.name
1e74fe6f-ae09-4cb7-8f8d-340cc6b97296	String	jsonType.label
6022d2d2-fe60-4386-af67-b6c2fa776444	true	userinfo.token.claim
6022d2d2-fe60-4386-af67-b6c2fa776444	updatedAt	user.attribute
6022d2d2-fe60-4386-af67-b6c2fa776444	true	id.token.claim
6022d2d2-fe60-4386-af67-b6c2fa776444	true	access.token.claim
6022d2d2-fe60-4386-af67-b6c2fa776444	updated_at	claim.name
6022d2d2-fe60-4386-af67-b6c2fa776444	String	jsonType.label
282349f1-da64-4ab3-bb32-2d9d6611146a	true	userinfo.token.claim
282349f1-da64-4ab3-bb32-2d9d6611146a	email	user.attribute
282349f1-da64-4ab3-bb32-2d9d6611146a	true	id.token.claim
282349f1-da64-4ab3-bb32-2d9d6611146a	true	access.token.claim
282349f1-da64-4ab3-bb32-2d9d6611146a	email	claim.name
282349f1-da64-4ab3-bb32-2d9d6611146a	String	jsonType.label
f2a4492f-d59b-4fdd-9378-d0f1261770bc	true	userinfo.token.claim
f2a4492f-d59b-4fdd-9378-d0f1261770bc	emailVerified	user.attribute
f2a4492f-d59b-4fdd-9378-d0f1261770bc	true	id.token.claim
f2a4492f-d59b-4fdd-9378-d0f1261770bc	true	access.token.claim
f2a4492f-d59b-4fdd-9378-d0f1261770bc	email_verified	claim.name
f2a4492f-d59b-4fdd-9378-d0f1261770bc	boolean	jsonType.label
c9a72cc6-1854-45c4-b68d-f87fec5ccc4e	formatted	user.attribute.formatted
c9a72cc6-1854-45c4-b68d-f87fec5ccc4e	country	user.attribute.country
c9a72cc6-1854-45c4-b68d-f87fec5ccc4e	postal_code	user.attribute.postal_code
c9a72cc6-1854-45c4-b68d-f87fec5ccc4e	true	userinfo.token.claim
c9a72cc6-1854-45c4-b68d-f87fec5ccc4e	street	user.attribute.street
c9a72cc6-1854-45c4-b68d-f87fec5ccc4e	true	id.token.claim
c9a72cc6-1854-45c4-b68d-f87fec5ccc4e	region	user.attribute.region
c9a72cc6-1854-45c4-b68d-f87fec5ccc4e	true	access.token.claim
c9a72cc6-1854-45c4-b68d-f87fec5ccc4e	locality	user.attribute.locality
a4d1431f-5841-45e7-8477-80cc95b0a0d2	true	userinfo.token.claim
a4d1431f-5841-45e7-8477-80cc95b0a0d2	phoneNumber	user.attribute
a4d1431f-5841-45e7-8477-80cc95b0a0d2	true	id.token.claim
a4d1431f-5841-45e7-8477-80cc95b0a0d2	true	access.token.claim
a4d1431f-5841-45e7-8477-80cc95b0a0d2	phone_number	claim.name
a4d1431f-5841-45e7-8477-80cc95b0a0d2	String	jsonType.label
2a9ca720-fda3-4b78-955d-010ed123537f	true	userinfo.token.claim
2a9ca720-fda3-4b78-955d-010ed123537f	phoneNumberVerified	user.attribute
2a9ca720-fda3-4b78-955d-010ed123537f	true	id.token.claim
2a9ca720-fda3-4b78-955d-010ed123537f	true	access.token.claim
2a9ca720-fda3-4b78-955d-010ed123537f	phone_number_verified	claim.name
2a9ca720-fda3-4b78-955d-010ed123537f	boolean	jsonType.label
6fe0be10-d535-4138-94c3-95eb317c77b2	true	multivalued
6fe0be10-d535-4138-94c3-95eb317c77b2	foo	user.attribute
6fe0be10-d535-4138-94c3-95eb317c77b2	true	access.token.claim
6fe0be10-d535-4138-94c3-95eb317c77b2	realm_access.roles	claim.name
6fe0be10-d535-4138-94c3-95eb317c77b2	String	jsonType.label
a2379148-8536-4695-aee8-35c09d2d3678	true	multivalued
a2379148-8536-4695-aee8-35c09d2d3678	foo	user.attribute
a2379148-8536-4695-aee8-35c09d2d3678	true	access.token.claim
a2379148-8536-4695-aee8-35c09d2d3678	resource_access.${client_id}.roles	claim.name
a2379148-8536-4695-aee8-35c09d2d3678	String	jsonType.label
498e66e5-fd7c-4f26-b114-a17f991779ad	true	userinfo.token.claim
498e66e5-fd7c-4f26-b114-a17f991779ad	username	user.attribute
498e66e5-fd7c-4f26-b114-a17f991779ad	true	id.token.claim
498e66e5-fd7c-4f26-b114-a17f991779ad	true	access.token.claim
498e66e5-fd7c-4f26-b114-a17f991779ad	upn	claim.name
498e66e5-fd7c-4f26-b114-a17f991779ad	String	jsonType.label
c6b934d6-231e-4630-9015-ef4a899d171e	true	multivalued
c6b934d6-231e-4630-9015-ef4a899d171e	foo	user.attribute
c6b934d6-231e-4630-9015-ef4a899d171e	true	id.token.claim
c6b934d6-231e-4630-9015-ef4a899d171e	true	access.token.claim
c6b934d6-231e-4630-9015-ef4a899d171e	groups	claim.name
c6b934d6-231e-4630-9015-ef4a899d171e	String	jsonType.label
0beb7617-2655-4b07-9a68-7fd43ab1c20f	true	userinfo.token.claim
0beb7617-2655-4b07-9a68-7fd43ab1c20f	locale	user.attribute
0beb7617-2655-4b07-9a68-7fd43ab1c20f	true	id.token.claim
0beb7617-2655-4b07-9a68-7fd43ab1c20f	true	access.token.claim
0beb7617-2655-4b07-9a68-7fd43ab1c20f	locale	claim.name
0beb7617-2655-4b07-9a68-7fd43ab1c20f	String	jsonType.label
f2e83186-a920-4e50-9705-81861987b871	true	userinfo.token.claim
f2e83186-a920-4e50-9705-81861987b871	dateOfBirth	user.attribute
f2e83186-a920-4e50-9705-81861987b871	true	id.token.claim
f2e83186-a920-4e50-9705-81861987b871	true	access.token.claim
f2e83186-a920-4e50-9705-81861987b871	String	jsonType.label
f2e83186-a920-4e50-9705-81861987b871	dateOfBirth	claim.name
b8465866-3189-4268-aada-3138dbcbff40	clientId	user.session.note
b8465866-3189-4268-aada-3138dbcbff40	true	id.token.claim
b8465866-3189-4268-aada-3138dbcbff40	true	access.token.claim
b8465866-3189-4268-aada-3138dbcbff40	clientId	claim.name
b8465866-3189-4268-aada-3138dbcbff40	String	jsonType.label
ff34af20-a19e-4863-bcdc-88345173b75b	clientHost	user.session.note
ff34af20-a19e-4863-bcdc-88345173b75b	true	id.token.claim
ff34af20-a19e-4863-bcdc-88345173b75b	true	access.token.claim
ff34af20-a19e-4863-bcdc-88345173b75b	clientHost	claim.name
ff34af20-a19e-4863-bcdc-88345173b75b	String	jsonType.label
e57d272c-1c5c-4ae3-9fb6-fe50681c055a	clientAddress	user.session.note
e57d272c-1c5c-4ae3-9fb6-fe50681c055a	true	id.token.claim
e57d272c-1c5c-4ae3-9fb6-fe50681c055a	true	access.token.claim
e57d272c-1c5c-4ae3-9fb6-fe50681c055a	clientAddress	claim.name
e57d272c-1c5c-4ae3-9fb6-fe50681c055a	String	jsonType.label
61093f62-9bb7-489b-be70-2bd310faad2f	true	userinfo.token.claim
61093f62-9bb7-489b-be70-2bd310faad2f	status	user.attribute
61093f62-9bb7-489b-be70-2bd310faad2f	true	id.token.claim
61093f62-9bb7-489b-be70-2bd310faad2f	true	access.token.claim
61093f62-9bb7-489b-be70-2bd310faad2f	status	claim.name
61093f62-9bb7-489b-be70-2bd310faad2f	String	jsonType.label
aaae98be-e621-4c17-bbb5-1af85648d659	clientId	user.session.note
aaae98be-e621-4c17-bbb5-1af85648d659	true	id.token.claim
aaae98be-e621-4c17-bbb5-1af85648d659	true	access.token.claim
aaae98be-e621-4c17-bbb5-1af85648d659	clientId	claim.name
aaae98be-e621-4c17-bbb5-1af85648d659	String	jsonType.label
c19a05f6-0c1b-4bb5-a8e9-54f51f9abfa8	clientHost	user.session.note
c19a05f6-0c1b-4bb5-a8e9-54f51f9abfa8	true	id.token.claim
c19a05f6-0c1b-4bb5-a8e9-54f51f9abfa8	true	access.token.claim
c19a05f6-0c1b-4bb5-a8e9-54f51f9abfa8	clientHost	claim.name
c19a05f6-0c1b-4bb5-a8e9-54f51f9abfa8	String	jsonType.label
a2e7e556-0893-42e9-937c-5248054a3fd8	clientAddress	user.session.note
a2e7e556-0893-42e9-937c-5248054a3fd8	true	id.token.claim
a2e7e556-0893-42e9-937c-5248054a3fd8	true	access.token.claim
a2e7e556-0893-42e9-937c-5248054a3fd8	clientAddress	claim.name
a2e7e556-0893-42e9-937c-5248054a3fd8	String	jsonType.label
ed3cef6d-251c-41c9-97ab-13212014aa86	true	userinfo.token.claim
ed3cef6d-251c-41c9-97ab-13212014aa86	dateOfBirth	user.attribute
ed3cef6d-251c-41c9-97ab-13212014aa86	true	id.token.claim
ed3cef6d-251c-41c9-97ab-13212014aa86	true	access.token.claim
ed3cef6d-251c-41c9-97ab-13212014aa86	dateOfBirth	claim.name
ed3cef6d-251c-41c9-97ab-13212014aa86	String	jsonType.label
d0019beb-b477-4b91-b198-ac1c9d827124	true	userinfo.token.claim
d0019beb-b477-4b91-b198-ac1c9d827124	status	user.attribute
d0019beb-b477-4b91-b198-ac1c9d827124	true	id.token.claim
d0019beb-b477-4b91-b198-ac1c9d827124	true	access.token.claim
d0019beb-b477-4b91-b198-ac1c9d827124	status	claim.name
d0019beb-b477-4b91-b198-ac1c9d827124	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
WAYD	60	300	432000	\N	\N	\N	t	f	0	\N	WAYD	0	\N	f	t	t	f	EXTERNAL	1800	36000	f	t	6e99b5a2-a8f9-4c0c-9cf3-2e5af28a2d23	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	c95e0473-d50f-4749-aa15-cd415beb2c32	7034377f-66ea-48a5-88de-8dcd7dce1255	a4dc6c0a-fd1a-4f27-bcef-6928cb0ca21e	a29b3489-8dfe-4564-b0fd-0947e49f1c3a	131d2d0b-9ddd-44a0-b431-2ca31391d8d2	2592000	f	900	t	f	bba31e7e-06ca-43ae-889a-7d57a6c66fa4	0	f	0	0	b455deaf-0785-4491-b5cd-50e49ae5526d
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	9ec85d13-9c05-4026-85f9-2a00cdc30ece	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	155e7d4d-48cc-4bf3-b7c6-299f71719f53	1804d43d-cfe8-465b-97fa-fc7fd2284257	287f8272-e95d-4056-8c30-3ad8fdbfd620	0ccb7aaa-f173-41e3-8f2d-962f30772218	f7a63f43-ee7b-4afa-8027-b171fc0e1d4a	2592000	f	900	t	f	c9a950d4-4411-491e-8ae5-304eda4e4167	0	f	0	0	89553a41-93ff-498e-9c35-d033727bb88e
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
userProfileEnabled	WAYD	false
bruteForceProtected	WAYD	false
permanentLockout	WAYD	false
maxFailureWaitSeconds	WAYD	900
minimumQuickLoginWaitSeconds	WAYD	60
waitIncrementSeconds	WAYD	60
quickLoginCheckMilliSeconds	WAYD	1000
maxDeltaTimeSeconds	WAYD	43200
failureFactor	WAYD	30
actionTokenGeneratedByAdminLifespan	WAYD	43200
actionTokenGeneratedByUserLifespan	WAYD	300
defaultSignatureAlgorithm	WAYD	RS256
offlineSessionMaxLifespanEnabled	WAYD	false
offlineSessionMaxLifespan	WAYD	5184000
webAuthnPolicyRpEntityName	WAYD	keycloak
webAuthnPolicySignatureAlgorithms	WAYD	ES256
webAuthnPolicyRpId	WAYD	
webAuthnPolicyAttestationConveyancePreference	WAYD	not specified
webAuthnPolicyAuthenticatorAttachment	WAYD	not specified
webAuthnPolicyRequireResidentKey	WAYD	not specified
oauth2DeviceCodeLifespan	WAYD	600
oauth2DevicePollingInterval	WAYD	5
webAuthnPolicyUserVerificationRequirement	WAYD	not specified
webAuthnPolicyCreateTimeout	WAYD	0
webAuthnPolicyAvoidSameAuthenticatorRegister	WAYD	false
webAuthnPolicyRpEntityNamePasswordless	WAYD	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	WAYD	ES256
webAuthnPolicyRpIdPasswordless	WAYD	
webAuthnPolicyAttestationConveyancePreferencePasswordless	WAYD	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	WAYD	not specified
webAuthnPolicyRequireResidentKeyPasswordless	WAYD	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	WAYD	not specified
webAuthnPolicyCreateTimeoutPasswordless	WAYD	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	WAYD	false
client-policies.profiles	WAYD	{"profiles":[]}
client-policies.policies	WAYD	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	WAYD	
_browser_header.xContentTypeOptions	WAYD	nosniff
_browser_header.xRobotsTag	WAYD	none
_browser_header.xFrameOptions	WAYD	SAMEORIGIN
cibaBackchannelTokenDeliveryMode	WAYD	poll
cibaExpiresIn	WAYD	120
cibaInterval	WAYD	5
cibaAuthRequestedUserHint	WAYD	login_hint
parRequestUriLifespan	WAYD	60
_browser_header.contentSecurityPolicy	WAYD	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	WAYD	1; mode=block
_browser_header.strictTransportSecurity	WAYD	max-age=31536000; includeSubDomains
clientSessionIdleTimeout	WAYD	0
clientSessionMaxLifespan	WAYD	0
clientOfflineSessionIdleTimeout	WAYD	0
clientOfflineSessionMaxLifespan	WAYD	0
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
WAYD	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	WAYD
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
WAYD	wdsfmhegrprclxtr	password
WAYD	true	starttls
WAYD	true	auth
WAYD	587	port
WAYD	smtp.gmail.com	host
WAYD	wayd.system@gmail.com	from
WAYD	WAYD	fromDisplayName
WAYD		ssl
WAYD	wayd.system@gmail.com	user
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
89a05317-0b45-43f5-a267-534025915d0c	/realms/master/account/*
3bb62974-3793-4ce9-8394-eae365f6de40	/realms/master/account/*
c68246db-bb4f-4c9e-a771-0ead82f8362a	/admin/master/console/*
f30380e2-97f9-45d9-9e54-80aca4bb0aa3	/realms/WAYD/account/*
55827f0e-432e-4a17-9122-832dd12da738	/realms/WAYD/account/*
19b2001f-f020-4955-a632-7867490abc98	/admin/WAYD/console/*
65c14276-8921-4060-8c93-941f468d53cb	*
5363183d-d4f0-4de6-81b0-65b43452bf8a	http://localhost:3000/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
218c11ca-883f-4ea2-b598-ef8978026519	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
784409f6-02d5-4f3b-8867-afc2bc1f6b34	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
d1c8dc76-f7e5-4160-b95b-945b282f9360	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
e2df2607-e3cc-4d4a-8af3-0d8c5c4616b1	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
4c70dc7f-1080-4374-a61f-eb19ed9ed65c	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
5de95d2c-cc2e-4558-ac2f-510233c5efc0	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
807ab005-8fde-417c-bec2-0d6e1d6ae93e	delete_account	Delete Account	master	f	f	delete_account	60
a5edf43a-57eb-49e3-8ffe-91aa1e84bc32	VERIFY_EMAIL	Verify Email	WAYD	t	f	VERIFY_EMAIL	50
8915a19c-09a4-4662-97ed-df6fcba440b6	UPDATE_PROFILE	Update Profile	WAYD	t	f	UPDATE_PROFILE	40
b13a9767-e218-455e-b2fa-72ecaf31fa95	CONFIGURE_TOTP	Configure OTP	WAYD	t	f	CONFIGURE_TOTP	10
c1ec243e-92bc-4f77-96fb-043e019028f9	UPDATE_PASSWORD	Update Password	WAYD	t	f	UPDATE_PASSWORD	30
220433ed-1ffe-43b6-bacf-cb982e0c1c58	terms_and_conditions	Terms and Conditions	WAYD	f	f	terms_and_conditions	20
903fd3f7-3ca1-41fb-8baa-36ee21738192	update_user_locale	Update User Locale	WAYD	t	f	update_user_locale	1000
f8d540fb-951c-4b6e-8a50-f3a56cde8a5b	delete_account	Delete Account	WAYD	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
65c14276-8921-4060-8c93-941f468d53cb	t	0	1
9ed1cc96-2f27-43ad-933d-022f22f6d83d	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
33c17a47-b7ad-4853-8036-21ef8fa0da9f	Default Policy	A policy that grants access only for users within this realm	js	0	0	65c14276-8921-4060-8c93-941f468d53cb	\N
834ecbe0-2039-45a9-84b0-a685c85cb9eb	Default Permission	A permission that applies to the default resource type	resource	1	0	65c14276-8921-4060-8c93-941f468d53cb	\N
da0190b1-eb03-49b8-97e4-26496e2106be	Default Policy	A policy that grants access only for users within this realm	js	0	0	9ed1cc96-2f27-43ad-933d-022f22f6d83d	\N
6aa3a39c-4413-4058-a1b6-310e1e46de4d	Default Permission	A permission that applies to the default resource type	resource	1	0	9ed1cc96-2f27-43ad-933d-022f22f6d83d	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
0fd2be8d-2a5e-4778-a5df-7dd6e4e7ef91	Default Resource	urn:user-service:resources:default	\N	65c14276-8921-4060-8c93-941f468d53cb	65c14276-8921-4060-8c93-941f468d53cb	f	\N
2866d313-dbb2-438a-9ba6-0a8945d873f6	Default Resource	urn:moderator-service:resources:default	\N	9ed1cc96-2f27-43ad-933d-022f22f6d83d	9ed1cc96-2f27-43ad-933d-022f22f6d83d	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
0fd2be8d-2a5e-4778-a5df-7dd6e4e7ef91	/*
2866d313-dbb2-438a-9ba6-0a8945d873f6	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
3bb62974-3793-4ce9-8394-eae365f6de40	eebbc780-87b6-41a7-8948-0a0a095c2ef3
55827f0e-432e-4a17-9122-832dd12da738	13b5f2e2-b388-437e-97ad-4ffda750b871
65c14276-8921-4060-8c93-941f468d53cb	9e9d07f0-26e2-4e90-83ff-90ad5564b3b7
65c14276-8921-4060-8c93-941f468d53cb	b6173d09-d6d2-4668-b56f-d5c84f059061
65c14276-8921-4060-8c93-941f468d53cb	7f5648dd-c3ff-4a99-bac3-00d83e7f4754
65c14276-8921-4060-8c93-941f468d53cb	aca4fc43-4680-4469-a43a-5b1d79f3acc5
65c14276-8921-4060-8c93-941f468d53cb	01bacde1-2d96-42d3-8eac-850916f1ca34
65c14276-8921-4060-8c93-941f468d53cb	38f33c02-a448-4aa7-bf09-0443f3ba6da7
65c14276-8921-4060-8c93-941f468d53cb	74fb8ee6-e8da-4afa-a17d-ff77c970f2c1
65c14276-8921-4060-8c93-941f468d53cb	7b762dd9-10cb-411c-bd66-a4a37300c1d6
65c14276-8921-4060-8c93-941f468d53cb	31c84a53-8a93-4fc4-9380-d8ba081c5286
65c14276-8921-4060-8c93-941f468d53cb	34ba7897-8b9f-4dc8-b841-253b32d3ece6
65c14276-8921-4060-8c93-941f468d53cb	1d02bfa9-b95d-49be-8e35-efa2920b71fb
65c14276-8921-4060-8c93-941f468d53cb	621a53bc-1b6c-4471-9081-f2152343f46f
65c14276-8921-4060-8c93-941f468d53cb	3f830fc4-ef89-416f-ad5b-55a448316db4
65c14276-8921-4060-8c93-941f468d53cb	47e1a663-cfd4-49fe-85f9-f55671cb04ba
65c14276-8921-4060-8c93-941f468d53cb	741435ce-d4be-44e8-be72-558920f51b9f
65c14276-8921-4060-8c93-941f468d53cb	2d0b916c-29c2-49e8-96f4-edae043fbf0e
65c14276-8921-4060-8c93-941f468d53cb	4d4fa898-5999-4767-8b38-1bb4a7a13f9e
65c14276-8921-4060-8c93-941f468d53cb	21916ae1-259b-48e0-9064-42a68dc0904f
65c14276-8921-4060-8c93-941f468d53cb	d61c50b0-933f-4955-a1b7-e5c6d62761ee
65c14276-8921-4060-8c93-941f468d53cb	1f8d9ded-6734-4f79-899f-09ebf94f1d2c
0a876099-5c08-40d4-972b-bdf0efc838be	01bacde1-2d96-42d3-8eac-850916f1ca34
0a876099-5c08-40d4-972b-bdf0efc838be	741435ce-d4be-44e8-be72-558920f51b9f
0a876099-5c08-40d4-972b-bdf0efc838be	34ba7897-8b9f-4dc8-b841-253b32d3ece6
0a876099-5c08-40d4-972b-bdf0efc838be	38f33c02-a448-4aa7-bf09-0443f3ba6da7
0a876099-5c08-40d4-972b-bdf0efc838be	2d0b916c-29c2-49e8-96f4-edae043fbf0e
0a876099-5c08-40d4-972b-bdf0efc838be	9e9d07f0-26e2-4e90-83ff-90ad5564b3b7
0a876099-5c08-40d4-972b-bdf0efc838be	74fb8ee6-e8da-4afa-a17d-ff77c970f2c1
0a876099-5c08-40d4-972b-bdf0efc838be	7f5648dd-c3ff-4a99-bac3-00d83e7f4754
0a876099-5c08-40d4-972b-bdf0efc838be	4d4fa898-5999-4767-8b38-1bb4a7a13f9e
0a876099-5c08-40d4-972b-bdf0efc838be	1d02bfa9-b95d-49be-8e35-efa2920b71fb
0a876099-5c08-40d4-972b-bdf0efc838be	31c84a53-8a93-4fc4-9380-d8ba081c5286
0a876099-5c08-40d4-972b-bdf0efc838be	21916ae1-259b-48e0-9064-42a68dc0904f
0a876099-5c08-40d4-972b-bdf0efc838be	aca4fc43-4680-4469-a43a-5b1d79f3acc5
0a876099-5c08-40d4-972b-bdf0efc838be	621a53bc-1b6c-4471-9081-f2152343f46f
0a876099-5c08-40d4-972b-bdf0efc838be	3f830fc4-ef89-416f-ad5b-55a448316db4
0a876099-5c08-40d4-972b-bdf0efc838be	d61c50b0-933f-4955-a1b7-e5c6d62761ee
0a876099-5c08-40d4-972b-bdf0efc838be	7b762dd9-10cb-411c-bd66-a4a37300c1d6
0a876099-5c08-40d4-972b-bdf0efc838be	47e1a663-cfd4-49fe-85f9-f55671cb04ba
0a876099-5c08-40d4-972b-bdf0efc838be	b6173d09-d6d2-4668-b56f-d5c84f059061
19b2001f-f020-4955-a632-7867490abc98	01bacde1-2d96-42d3-8eac-850916f1ca34
19b2001f-f020-4955-a632-7867490abc98	741435ce-d4be-44e8-be72-558920f51b9f
19b2001f-f020-4955-a632-7867490abc98	34ba7897-8b9f-4dc8-b841-253b32d3ece6
19b2001f-f020-4955-a632-7867490abc98	38f33c02-a448-4aa7-bf09-0443f3ba6da7
19b2001f-f020-4955-a632-7867490abc98	2d0b916c-29c2-49e8-96f4-edae043fbf0e
19b2001f-f020-4955-a632-7867490abc98	9e9d07f0-26e2-4e90-83ff-90ad5564b3b7
19b2001f-f020-4955-a632-7867490abc98	74fb8ee6-e8da-4afa-a17d-ff77c970f2c1
19b2001f-f020-4955-a632-7867490abc98	7f5648dd-c3ff-4a99-bac3-00d83e7f4754
19b2001f-f020-4955-a632-7867490abc98	4d4fa898-5999-4767-8b38-1bb4a7a13f9e
19b2001f-f020-4955-a632-7867490abc98	1d02bfa9-b95d-49be-8e35-efa2920b71fb
19b2001f-f020-4955-a632-7867490abc98	31c84a53-8a93-4fc4-9380-d8ba081c5286
19b2001f-f020-4955-a632-7867490abc98	21916ae1-259b-48e0-9064-42a68dc0904f
19b2001f-f020-4955-a632-7867490abc98	aca4fc43-4680-4469-a43a-5b1d79f3acc5
19b2001f-f020-4955-a632-7867490abc98	621a53bc-1b6c-4471-9081-f2152343f46f
19b2001f-f020-4955-a632-7867490abc98	3f830fc4-ef89-416f-ad5b-55a448316db4
19b2001f-f020-4955-a632-7867490abc98	d61c50b0-933f-4955-a1b7-e5c6d62761ee
19b2001f-f020-4955-a632-7867490abc98	7b762dd9-10cb-411c-bd66-a4a37300c1d6
19b2001f-f020-4955-a632-7867490abc98	47e1a663-cfd4-49fe-85f9-f55671cb04ba
19b2001f-f020-4955-a632-7867490abc98	b6173d09-d6d2-4668-b56f-d5c84f059061
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
locale	en	e07f5ab2-2093-45cd-a4ce-98ce34091c77	0e93d8be-e641-4ca3-94f2-b810b396de37
dateOfBirth	1990-01-01	c67454de-5385-4c80-93a6-11a95242ceff	27485256-8853-44e6-908b-c6f6a873b9e5
dateOfBirth	1990-01-01	5b4ceba7-52e3-47c3-a41c-8c17b0b522a0	d5e1ab8a-d69f-4cd8-986c-6c833b039503
dateOfBirth	1990-01-01	d6512e1f-144c-40e1-9a7b-3b1a69207cbf	202de878-aada-4c51-aa19-064e042de792
status	ACTIVE	c67454de-5385-4c80-93a6-11a95242ceff	f4ef6008-14b0-4f90-91ab-f18c9837c4ce
status	ON_VALIDATION	d6512e1f-144c-40e1-9a7b-3b1a69207cbf	1a9550d9-8adb-4c7c-b143-da7f1636c374
description	Description1	d6512e1f-144c-40e1-9a7b-3b1a69207cbf	1c56d8b4-69a3-47c5-89fa-d64656189b48
contacts	Telegram: @user1	d6512e1f-144c-40e1-9a7b-3b1a69207cbf	0b7667a5-ea95-4153-b627-bb96d144729e
dateOfBirth	1996-06-21	100df59a-000e-4f86-934b-885080523f70	6421fad8-64be-49ed-8106-e48e7cefea7d
status	ON_VALIDATION	100df59a-000e-4f86-934b-885080523f70	5381fc93-5397-46d9-9ef6-54e3e0e8aa10
avatar	6215e681f3a91a6067717316	5b4ceba7-52e3-47c3-a41c-8c17b0b522a0	3fb2c5b8-1ac4-42e4-8242-72682a61c665
status	ON_VALIDATION	5b4ceba7-52e3-47c3-a41c-8c17b0b522a0	635f8706-431c-48c6-a3bc-ec98b723c79c
avatar	6229ebf5c7063927d6026eba	100df59a-000e-4f86-934b-885080523f70	df33ea25-6909-401d-b3b4-83a62784cffb
avatar	6229ec3ac7063927d6026ebb	d6512e1f-144c-40e1-9a7b-3b1a69207cbf	bd83bbce-1dc4-46d3-ac90-f78fe268ef92
description	Excepteur sint occaecat cupidatat non proident, consectetur adipiscing elit, obcaecati cupiditate non provident, similique sunt in culpa, qui officia deserunt mollitia animi, id est laborum et dolorum fuga?	f23cca33-1b1b-4368-8f5a-d1e031ee77af	4bafc5b0-aba1-4a95-b3ac-9799e4cea7d1
status	ON_VALIDATION	f23cca33-1b1b-4368-8f5a-d1e031ee77af	03d0a901-ffcd-4149-8de9-9c4cd6b4c2ea
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
d6512e1f-144c-40e1-9a7b-3b1a69207cbf	wayd.test@gmail.com	wayd.test@gmail.com	t	t	\N	user1	userov1	WAYD	user	1643728733406	\N	0
c67454de-5385-4c80-93a6-11a95242ceff	wayd.admtest@gmail.com	wayd.admtest@gmail.com	t	t	\N	admin	adminov	WAYD	admin	1643728290622	\N	0
5b4ceba7-52e3-47c3-a41c-8c17b0b522a0	wayd.moderator@yandex.ru	wayd.moderator@yandex.ru	t	t	\N	moderator	moderatorov	WAYD	moderator	1643728643557	\N	0
e07f5ab2-2093-45cd-a4ce-98ce34091c77	vladislav.kolmykov@yandex.ru	vladislav.kolmykov@yandex.ru	f	t	\N	Vladislav	Kolmykov	master	admin	1643643439054	\N	0
adbb0637-51a2-40d9-931f-00966339c34a	\N	697b351f-1bcd-4965-8ce1-498427c9809c	f	t	\N	\N	\N	WAYD	service-account-user-service	1643739587183	65c14276-8921-4060-8c93-941f468d53cb	0
34e2e7f1-5f98-4d63-8224-7852ed1279b0	\N	480d0fc7-5f3a-4fb8-bf67-83fc6b1b3e84	f	t	\N	\N	\N	master	adm	1646231692748	\N	0
100df59a-000e-4f86-934b-885080523f70	vladislav.kolmykov@yandex.ru	vladislav.kolmykov@yandex.ru	t	t	\N	Vladislav	Kolmykov	WAYD	tsvlad	1645289363818	\N	0
f23cca33-1b1b-4368-8f5a-d1e031ee77af	tabussicus@gmail.com	tabussicus@gmail.com	t	t	\N	Some company	\N	WAYD	somecompany	1647093624872	\N	0
7872edf4-2ac4-4c59-bace-7574d3b5a70a	\N	d6bc9cf6-4ddc-4bce-bd45-ce26dee854b8	f	t	\N	\N	\N	WAYD	service-account-moderation-service	1644428214235	9ed1cc96-2f27-43ad-933d-022f22f6d83d	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
a94df7ae-33b9-4a86-bd56-ef013c8d15ff	c67454de-5385-4c80-93a6-11a95242ceff
2107a2a3-e596-4a09-8dbd-caecd1481506	5b4ceba7-52e3-47c3-a41c-8c17b0b522a0
7610772d-8a5d-4f7f-95f7-a6b3cc5a53ac	d6512e1f-144c-40e1-9a7b-3b1a69207cbf
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
89553a41-93ff-498e-9c35-d033727bb88e	e07f5ab2-2093-45cd-a4ce-98ce34091c77
575c4592-6e3f-499d-9cff-2e0393743a97	e07f5ab2-2093-45cd-a4ce-98ce34091c77
0d9cc63c-dbb1-42e2-99a7-e898124de62b	e07f5ab2-2093-45cd-a4ce-98ce34091c77
f8a8a52c-5f20-4132-8e3c-8a0bff7e7e8d	e07f5ab2-2093-45cd-a4ce-98ce34091c77
b429465f-995f-463d-8751-845053dabcdb	e07f5ab2-2093-45cd-a4ce-98ce34091c77
0b347acf-1780-4fb0-b2f3-a1f4468f0f87	e07f5ab2-2093-45cd-a4ce-98ce34091c77
4f584874-98cf-4861-9e38-0118e2717ca5	e07f5ab2-2093-45cd-a4ce-98ce34091c77
fce754ae-4e71-4d0e-9cb4-f049b6f156b1	e07f5ab2-2093-45cd-a4ce-98ce34091c77
3fd5210d-8c24-49c3-bed5-482dad169a04	e07f5ab2-2093-45cd-a4ce-98ce34091c77
7f1fda4d-41ef-4e43-a6c5-232029d45be8	e07f5ab2-2093-45cd-a4ce-98ce34091c77
719c06d4-374f-4249-9e69-2f724690b9b2	e07f5ab2-2093-45cd-a4ce-98ce34091c77
c8b70591-063e-4dbf-8f0d-f614c0b26355	e07f5ab2-2093-45cd-a4ce-98ce34091c77
52d7b207-197e-4c8d-b496-1153852f1cc4	e07f5ab2-2093-45cd-a4ce-98ce34091c77
18302f9f-c5ec-4838-8450-734df2197d9d	e07f5ab2-2093-45cd-a4ce-98ce34091c77
3ca2ebf1-3c17-4d35-8016-cccdd004bb54	e07f5ab2-2093-45cd-a4ce-98ce34091c77
a4fbb8a5-9f02-4dbd-80d1-e1c96d18e757	e07f5ab2-2093-45cd-a4ce-98ce34091c77
0d04b2ab-7de2-4ed8-a6c2-312fef27c91b	e07f5ab2-2093-45cd-a4ce-98ce34091c77
e22a0cb9-cf8a-478f-9dba-e1671f2f8f67	e07f5ab2-2093-45cd-a4ce-98ce34091c77
4b1932e4-9c39-4422-93c1-bb7f802d1251	e07f5ab2-2093-45cd-a4ce-98ce34091c77
b455deaf-0785-4491-b5cd-50e49ae5526d	c67454de-5385-4c80-93a6-11a95242ceff
b455deaf-0785-4491-b5cd-50e49ae5526d	5b4ceba7-52e3-47c3-a41c-8c17b0b522a0
b455deaf-0785-4491-b5cd-50e49ae5526d	d6512e1f-144c-40e1-9a7b-3b1a69207cbf
b455deaf-0785-4491-b5cd-50e49ae5526d	adbb0637-51a2-40d9-931f-00966339c34a
ad0032c8-7b95-4430-b221-1e74a29bf3f5	adbb0637-51a2-40d9-931f-00966339c34a
b455deaf-0785-4491-b5cd-50e49ae5526d	7872edf4-2ac4-4c59-bace-7574d3b5a70a
f45ae11f-34f1-408f-9ea3-12948203f238	7872edf4-2ac4-4c59-bace-7574d3b5a70a
c9712bd3-0235-4f22-a51c-42104cf5967f	5b4ceba7-52e3-47c3-a41c-8c17b0b522a0
ed9c670e-d048-4633-983e-7e4949714fb3	5b4ceba7-52e3-47c3-a41c-8c17b0b522a0
7d38f1d0-c586-47be-808d-ed1354d23f7a	5b4ceba7-52e3-47c3-a41c-8c17b0b522a0
b455deaf-0785-4491-b5cd-50e49ae5526d	100df59a-000e-4f86-934b-885080523f70
ed9c670e-d048-4633-983e-7e4949714fb3	100df59a-000e-4f86-934b-885080523f70
7d38f1d0-c586-47be-808d-ed1354d23f7a	100df59a-000e-4f86-934b-885080523f70
89553a41-93ff-498e-9c35-d033727bb88e	34e2e7f1-5f98-4d63-8224-7852ed1279b0
575c4592-6e3f-499d-9cff-2e0393743a97	34e2e7f1-5f98-4d63-8224-7852ed1279b0
7d38f1d0-c586-47be-808d-ed1354d23f7a	d6512e1f-144c-40e1-9a7b-3b1a69207cbf
ed9c670e-d048-4633-983e-7e4949714fb3	d6512e1f-144c-40e1-9a7b-3b1a69207cbf
38f33c02-a448-4aa7-bf09-0443f3ba6da7	adbb0637-51a2-40d9-931f-00966339c34a
7b762dd9-10cb-411c-bd66-a4a37300c1d6	adbb0637-51a2-40d9-931f-00966339c34a
01bacde1-2d96-42d3-8eac-850916f1ca34	adbb0637-51a2-40d9-931f-00966339c34a
31c84a53-8a93-4fc4-9380-d8ba081c5286	adbb0637-51a2-40d9-931f-00966339c34a
74fb8ee6-e8da-4afa-a17d-ff77c970f2c1	adbb0637-51a2-40d9-931f-00966339c34a
621a53bc-1b6c-4471-9081-f2152343f46f	adbb0637-51a2-40d9-931f-00966339c34a
47e1a663-cfd4-49fe-85f9-f55671cb04ba	adbb0637-51a2-40d9-931f-00966339c34a
7f5648dd-c3ff-4a99-bac3-00d83e7f4754	adbb0637-51a2-40d9-931f-00966339c34a
1d02bfa9-b95d-49be-8e35-efa2920b71fb	adbb0637-51a2-40d9-931f-00966339c34a
3f830fc4-ef89-416f-ad5b-55a448316db4	adbb0637-51a2-40d9-931f-00966339c34a
34ba7897-8b9f-4dc8-b841-253b32d3ece6	adbb0637-51a2-40d9-931f-00966339c34a
b6173d09-d6d2-4668-b56f-d5c84f059061	adbb0637-51a2-40d9-931f-00966339c34a
d61c50b0-933f-4955-a1b7-e5c6d62761ee	adbb0637-51a2-40d9-931f-00966339c34a
4d4fa898-5999-4767-8b38-1bb4a7a13f9e	adbb0637-51a2-40d9-931f-00966339c34a
21916ae1-259b-48e0-9064-42a68dc0904f	adbb0637-51a2-40d9-931f-00966339c34a
741435ce-d4be-44e8-be72-558920f51b9f	adbb0637-51a2-40d9-931f-00966339c34a
2d0b916c-29c2-49e8-96f4-edae043fbf0e	adbb0637-51a2-40d9-931f-00966339c34a
aca4fc43-4680-4469-a43a-5b1d79f3acc5	adbb0637-51a2-40d9-931f-00966339c34a
9e9d07f0-26e2-4e90-83ff-90ad5564b3b7	adbb0637-51a2-40d9-931f-00966339c34a
b455deaf-0785-4491-b5cd-50e49ae5526d	f23cca33-1b1b-4368-8f5a-d1e031ee77af
ed9c670e-d048-4633-983e-7e4949714fb3	f23cca33-1b1b-4368-8f5a-d1e031ee77af
c6b7af0c-b944-4caa-8bb4-af39b249fcf8	f23cca33-1b1b-4368-8f5a-d1e031ee77af
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
c68246db-bb4f-4c9e-a771-0ead82f8362a	+
19b2001f-f020-4955-a632-7867490abc98	+
5363183d-d4f0-4de6-81b0-65b43452bf8a	http://localhost:3000
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Debian 14.1-1.pgdg110+1)
-- Dumped by pg_dump version 14.1 (Debian 14.1-1.pgdg110+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--


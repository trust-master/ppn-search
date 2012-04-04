--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    resource_id character varying(255) NOT NULL,
    resource_type character varying(255) NOT NULL,
    author_id integer,
    author_type character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    namespace character varying(255)
);


--
-- Name: admin_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: admin_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_notes_id_seq OWNED BY active_admin_comments.id;


--
-- Name: affiliations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE affiliations (
    id integer NOT NULL,
    company_id integer,
    name character varying(255),
    title character varying(255),
    description text,
    started_on date,
    ended_on date,
    url character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: affiliations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE affiliations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: affiliations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE affiliations_id_seq OWNED BY affiliations.id;


--
-- Name: associations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE associations (
    id integer NOT NULL,
    company_id integer,
    name character varying(255),
    title character varying(255),
    description text,
    started_on date,
    ended_on date,
    url character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: associations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE associations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: associations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE associations_id_seq OWNED BY associations.id;


--
-- Name: business_filings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE business_filings (
    id integer NOT NULL,
    company_id integer,
    issuing_state_id integer,
    type_id integer,
    status_id integer,
    number character varying(255),
    name character varying(255),
    registered_office_address text,
    chief_executive_officer text,
    home_jurisdiction character varying(255),
    originally_filed_on date,
    last_annually_filed_on date,
    renewal_due_on date,
    registered_agents character varying(255),
    raw_data text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fetched_at timestamp without time zone
);


--
-- Name: business_filings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE business_filings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: business_filings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE business_filings_id_seq OWNED BY business_filings.id;


--
-- Name: business_licenses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE business_licenses (
    id integer NOT NULL,
    company_id integer,
    issuing_state_id integer,
    type_id integer,
    status_id integer,
    number character varying(255),
    application_number character varying(255),
    expires_on date,
    effective_on date,
    issued_on date,
    printed_on date,
    enforcement_action boolean DEFAULT false NOT NULL,
    name character varying(255),
    doing_business_as character varying(255),
    address text,
    phone_number character varying(255),
    responsible_person_license_number character varying(255),
    raw_data text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fetched_at timestamp without time zone
);


--
-- Name: business_licenses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE business_licenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: business_licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE business_licenses_id_seq OWNED BY business_licenses.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: certifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE certifications (
    id integer NOT NULL,
    company_id integer,
    name character varying(255),
    title character varying(255),
    description text,
    certificate character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: certifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE certifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: certifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE certifications_id_seq OWNED BY certifications.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE companies (
    id integer NOT NULL,
    active boolean DEFAULT false NOT NULL,
    visible boolean DEFAULT false NOT NULL,
    deleted_at timestamp without time zone,
    deleted_by_user_id integer,
    name character varying(255),
    email character varying(255),
    phone_main character varying(255),
    phone_mobile character varying(255),
    phone_fax character varying(255),
    website_url character varying(255),
    in_business_since date,
    about character varying(255),
    description text,
    general_info text,
    offers_24_hour_service boolean DEFAULT false NOT NULL,
    offers_emergency_service boolean DEFAULT false NOT NULL,
    insured boolean DEFAULT false NOT NULL,
    insurance_state_id integer,
    insurance_certificate character varying(255),
    insurance_valid_from date,
    insurance_valid_until date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE companies_id_seq OWNED BY companies.id;


--
-- Name: company_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE company_categories (
    id integer NOT NULL,
    company_id integer,
    sub_category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: company_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE company_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: company_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE company_categories_id_seq OWNED BY company_categories.id;


--
-- Name: discounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE discounts (
    id integer NOT NULL,
    company_id integer,
    type_id integer,
    title character varying(255),
    description character varying(255),
    image character varying(255),
    market_id integer,
    start_date date,
    end_date date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    company_id integer,
    city character varying(255),
    state_id integer,
    zip character varying(255),
    country_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    street character varying(255),
    street2 character varying(255)
);


--
-- Name: personal_licenses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE personal_licenses (
    id integer NOT NULL,
    company_id integer,
    issuing_state_id integer,
    type_id integer,
    status_id integer,
    number character varying(255),
    application_number character varying(255),
    continuing_education character varying(255),
    enforcement_action boolean DEFAULT false NOT NULL,
    name character varying(255),
    address text,
    phone_number character varying(255),
    issued_on date,
    expires_on date,
    printed_on date,
    effective_on date,
    raw_data text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fetched_at timestamp without time zone
);


--
-- Name: company_searches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW company_searches AS
    (((((((SELECT (companies.id)::text AS company_id, (companies.about)::text AS about, NULL::unknown AS address, NULL::unknown AS application_number, NULL::unknown AS chief_executive_officer, NULL::unknown AS city, companies.description, NULL::unknown AS doing_business_as, companies.general_info, NULL::unknown AS home_jurisdiction, (companies.name)::text AS name, NULL::unknown AS number, (companies.phone_fax)::text AS phone_fax, (companies.phone_main)::text AS phone_main, (companies.phone_mobile)::text AS phone_mobile, NULL::unknown AS phone_number, NULL::unknown AS raw_data, NULL::unknown AS registered_agents, NULL::unknown AS registered_office_address, NULL::unknown AS responsible_person_license_number, NULL::unknown AS title, NULL::unknown AS url, (companies.website_url)::text AS website_url, 'Company'::character varying AS searchable_type, companies.id AS searchable_id FROM companies UNION SELECT (personal_licenses.company_id)::text AS company_id, NULL::unknown AS about, personal_licenses.address, (personal_licenses.application_number)::text AS application_number, NULL::unknown AS chief_executive_officer, NULL::unknown AS city, NULL::unknown AS description, NULL::unknown AS doing_business_as, NULL::unknown AS general_info, NULL::unknown AS home_jurisdiction, (personal_licenses.name)::text AS name, (personal_licenses.number)::text AS number, NULL::unknown AS phone_fax, NULL::unknown AS phone_main, NULL::unknown AS phone_mobile, (personal_licenses.phone_number)::text AS phone_number, personal_licenses.raw_data, NULL::unknown AS registered_agents, NULL::unknown AS registered_office_address, NULL::unknown AS responsible_person_license_number, NULL::unknown AS title, NULL::unknown AS url, NULL::unknown AS website_url, 'PersonalLicense'::character varying AS searchable_type, personal_licenses.id AS searchable_id FROM personal_licenses) UNION SELECT (business_licenses.company_id)::text AS company_id, NULL::unknown AS about, business_licenses.address, (business_licenses.application_number)::text AS application_number, NULL::unknown AS chief_executive_officer, NULL::unknown AS city, NULL::unknown AS description, (business_licenses.doing_business_as)::text AS doing_business_as, NULL::unknown AS general_info, NULL::unknown AS home_jurisdiction, (business_licenses.name)::text AS name, (business_licenses.number)::text AS number, NULL::unknown AS phone_fax, NULL::unknown AS phone_main, NULL::unknown AS phone_mobile, (business_licenses.phone_number)::text AS phone_number, business_licenses.raw_data, NULL::unknown AS registered_agents, NULL::unknown AS registered_office_address, (business_licenses.responsible_person_license_number)::text AS responsible_person_license_number, NULL::unknown AS title, NULL::unknown AS url, NULL::unknown AS website_url, 'BusinessLicense'::character varying AS searchable_type, business_licenses.id AS searchable_id FROM business_licenses) UNION SELECT (business_filings.company_id)::text AS company_id, NULL::unknown AS about, NULL::unknown AS address, NULL::unknown AS application_number, business_filings.chief_executive_officer, NULL::unknown AS city, NULL::unknown AS description, NULL::unknown AS doing_business_as, NULL::unknown AS general_info, (business_filings.home_jurisdiction)::text AS home_jurisdiction, (business_filings.name)::text AS name, (business_filings.number)::text AS number, NULL::unknown AS phone_fax, NULL::unknown AS phone_main, NULL::unknown AS phone_mobile, NULL::unknown AS phone_number, business_filings.raw_data, (business_filings.registered_agents)::text AS registered_agents, business_filings.registered_office_address, NULL::unknown AS responsible_person_license_number, NULL::unknown AS title, NULL::unknown AS url, NULL::unknown AS website_url, 'BusinessFiling'::character varying AS searchable_type, business_filings.id AS searchable_id FROM business_filings) UNION SELECT (affiliations.company_id)::text AS company_id, NULL::unknown AS about, NULL::unknown AS address, NULL::unknown AS application_number, NULL::unknown AS chief_executive_officer, NULL::unknown AS city, affiliations.description, NULL::unknown AS doing_business_as, NULL::unknown AS general_info, NULL::unknown AS home_jurisdiction, (affiliations.name)::text AS name, NULL::unknown AS number, NULL::unknown AS phone_fax, NULL::unknown AS phone_main, NULL::unknown AS phone_mobile, NULL::unknown AS phone_number, NULL::unknown AS raw_data, NULL::unknown AS registered_agents, NULL::unknown AS registered_office_address, NULL::unknown AS responsible_person_license_number, (affiliations.title)::text AS title, (affiliations.url)::text AS url, NULL::unknown AS website_url, 'Affiliation'::character varying AS searchable_type, affiliations.id AS searchable_id FROM affiliations) UNION SELECT (associations.company_id)::text AS company_id, NULL::unknown AS about, NULL::unknown AS address, NULL::unknown AS application_number, NULL::unknown AS chief_executive_officer, NULL::unknown AS city, associations.description, NULL::unknown AS doing_business_as, NULL::unknown AS general_info, NULL::unknown AS home_jurisdiction, (associations.name)::text AS name, NULL::unknown AS number, NULL::unknown AS phone_fax, NULL::unknown AS phone_main, NULL::unknown AS phone_mobile, NULL::unknown AS phone_number, NULL::unknown AS raw_data, NULL::unknown AS registered_agents, NULL::unknown AS registered_office_address, NULL::unknown AS responsible_person_license_number, (associations.title)::text AS title, (associations.url)::text AS url, NULL::unknown AS website_url, 'Association'::character varying AS searchable_type, associations.id AS searchable_id FROM associations) UNION SELECT (certifications.company_id)::text AS company_id, NULL::unknown AS about, NULL::unknown AS address, NULL::unknown AS application_number, NULL::unknown AS chief_executive_officer, NULL::unknown AS city, certifications.description, NULL::unknown AS doing_business_as, NULL::unknown AS general_info, NULL::unknown AS home_jurisdiction, (certifications.name)::text AS name, NULL::unknown AS number, NULL::unknown AS phone_fax, NULL::unknown AS phone_main, NULL::unknown AS phone_mobile, NULL::unknown AS phone_number, NULL::unknown AS raw_data, NULL::unknown AS registered_agents, NULL::unknown AS registered_office_address, NULL::unknown AS responsible_person_license_number, (certifications.title)::text AS title, NULL::unknown AS url, NULL::unknown AS website_url, 'Certification'::character varying AS searchable_type, certifications.id AS searchable_id FROM certifications) UNION SELECT (locations.company_id)::text AS company_id, NULL::unknown AS about, NULL::unknown AS address, NULL::unknown AS application_number, NULL::unknown AS chief_executive_officer, (locations.city)::text AS city, NULL::unknown AS description, NULL::unknown AS doing_business_as, NULL::unknown AS general_info, NULL::unknown AS home_jurisdiction, NULL::unknown AS name, NULL::unknown AS number, NULL::unknown AS phone_fax, NULL::unknown AS phone_main, NULL::unknown AS phone_mobile, NULL::unknown AS phone_number, NULL::unknown AS raw_data, NULL::unknown AS registered_agents, NULL::unknown AS registered_office_address, NULL::unknown AS responsible_person_license_number, NULL::unknown AS title, NULL::unknown AS url, NULL::unknown AS website_url, 'Location'::character varying AS searchable_type, locations.id AS searchable_id FROM locations) UNION SELECT (discounts.company_id)::text AS company_id, NULL::unknown AS about, NULL::unknown AS address, NULL::unknown AS application_number, NULL::unknown AS chief_executive_officer, NULL::unknown AS city, (discounts.description)::text AS description, NULL::unknown AS doing_business_as, NULL::unknown AS general_info, NULL::unknown AS home_jurisdiction, NULL::unknown AS name, NULL::unknown AS number, NULL::unknown AS phone_fax, NULL::unknown AS phone_main, NULL::unknown AS phone_mobile, NULL::unknown AS phone_number, NULL::unknown AS raw_data, NULL::unknown AS registered_agents, NULL::unknown AS registered_office_address, NULL::unknown AS responsible_person_license_number, (discounts.title)::text AS title, NULL::unknown AS url, NULL::unknown AS website_url, 'Discount'::character varying AS searchable_type, discounts.id AS searchable_id FROM discounts;


--
-- Name: company_service_areas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE company_service_areas (
    id integer NOT NULL,
    company_id integer,
    service_area_id integer,
    partial_only boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: company_service_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE company_service_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: company_service_areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE company_service_areas_id_seq OWNED BY company_service_areas.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE countries (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    abbreviation character varying(255) NOT NULL
);


--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE countries_id_seq OWNED BY countries.id;


--
-- Name: discount_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE discount_types (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


--
-- Name: discount_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE discount_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: discount_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE discount_types_id_seq OWNED BY discount_types.id;


--
-- Name: discounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE discounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: discounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE discounts_id_seq OWNED BY discounts.id;


--
-- Name: filing_status; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE filing_status (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: filing_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE filing_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: filing_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE filing_status_id_seq OWNED BY filing_status.id;


--
-- Name: filing_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE filing_types (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: filing_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE filing_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: filing_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE filing_types_id_seq OWNED BY filing_types.id;


--
-- Name: license_status; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE license_status (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: license_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE license_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: license_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE license_status_id_seq OWNED BY license_status.id;


--
-- Name: license_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE license_types (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying(255),
    state_id integer
);


--
-- Name: license_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE license_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: license_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE license_types_id_seq OWNED BY license_types.id;


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: markets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE markets (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


--
-- Name: markets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE markets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: markets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE markets_id_seq OWNED BY markets.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    name character varying(255),
    slug character varying(255),
    title character varying(255),
    content text,
    published boolean DEFAULT false NOT NULL
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: personal_licenses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE personal_licenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: personal_licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE personal_licenses_id_seq OWNED BY personal_licenses.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: service_areas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE service_areas (
    id integer NOT NULL,
    market_id integer,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


--
-- Name: service_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE service_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: service_areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE service_areas_id_seq OWNED BY service_areas.id;


--
-- Name: states; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE states (
    id integer NOT NULL,
    country_id integer,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    abbreviation character varying(255) NOT NULL
);


--
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE states_id_seq OWNED BY states.id;


--
-- Name: sub_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sub_categories (
    id integer NOT NULL,
    category_id integer,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


--
-- Name: sub_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sub_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: sub_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sub_categories_id_seq OWNED BY sub_categories.id;


--
-- Name: user_auth_tokens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_auth_tokens (
    id integer NOT NULL,
    user_id integer,
    token character varying(255),
    type character varying(255),
    fullfilled_by_ip character varying(255),
    fullfilled_at timestamp without time zone,
    email_sent_at timestamp without time zone,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by_ip character varying(255),
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_auth_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_auth_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: user_auth_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_auth_tokens_id_seq OWNED BY user_auth_tokens.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    active boolean DEFAULT false NOT NULL,
    company_id integer,
    email character varying(255),
    password_digest character varying(255),
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    created_by_user_id integer,
    updated_by_user_id integer,
    role character varying(255) DEFAULT 'User'::character varying,
    logged_in_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    phone character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit integer,
    object text,
    object_changes text,
    created_at timestamp without time zone NOT NULL,
    published boolean NOT NULL,
    ip_address character varying(255),
    controller_name character varying(255)
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE active_admin_comments ALTER COLUMN id SET DEFAULT nextval('admin_notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE affiliations ALTER COLUMN id SET DEFAULT nextval('affiliations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE associations ALTER COLUMN id SET DEFAULT nextval('associations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE business_filings ALTER COLUMN id SET DEFAULT nextval('business_filings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE business_licenses ALTER COLUMN id SET DEFAULT nextval('business_licenses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE certifications ALTER COLUMN id SET DEFAULT nextval('certifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE companies ALTER COLUMN id SET DEFAULT nextval('companies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE company_categories ALTER COLUMN id SET DEFAULT nextval('company_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE company_service_areas ALTER COLUMN id SET DEFAULT nextval('company_service_areas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE countries ALTER COLUMN id SET DEFAULT nextval('countries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE discount_types ALTER COLUMN id SET DEFAULT nextval('discount_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE discounts ALTER COLUMN id SET DEFAULT nextval('discounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE filing_status ALTER COLUMN id SET DEFAULT nextval('filing_status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE filing_types ALTER COLUMN id SET DEFAULT nextval('filing_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE license_status ALTER COLUMN id SET DEFAULT nextval('license_status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE license_types ALTER COLUMN id SET DEFAULT nextval('license_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE markets ALTER COLUMN id SET DEFAULT nextval('markets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE personal_licenses ALTER COLUMN id SET DEFAULT nextval('personal_licenses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE service_areas ALTER COLUMN id SET DEFAULT nextval('service_areas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE states ALTER COLUMN id SET DEFAULT nextval('states_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE sub_categories ALTER COLUMN id SET DEFAULT nextval('sub_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE user_auth_tokens ALTER COLUMN id SET DEFAULT nextval('user_auth_tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: admin_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT admin_notes_pkey PRIMARY KEY (id);


--
-- Name: affiliations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY affiliations
    ADD CONSTRAINT affiliations_pkey PRIMARY KEY (id);


--
-- Name: associations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY associations
    ADD CONSTRAINT associations_pkey PRIMARY KEY (id);


--
-- Name: business_filings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY business_filings
    ADD CONSTRAINT business_filings_pkey PRIMARY KEY (id);


--
-- Name: business_licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY business_licenses
    ADD CONSTRAINT business_licenses_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: certifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY certifications
    ADD CONSTRAINT certifications_pkey PRIMARY KEY (id);


--
-- Name: companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: company_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY company_categories
    ADD CONSTRAINT company_categories_pkey PRIMARY KEY (id);


--
-- Name: company_service_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY company_service_areas
    ADD CONSTRAINT company_service_areas_pkey PRIMARY KEY (id);


--
-- Name: countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: discount_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY discount_types
    ADD CONSTRAINT discount_types_pkey PRIMARY KEY (id);


--
-- Name: discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY discounts
    ADD CONSTRAINT discounts_pkey PRIMARY KEY (id);


--
-- Name: filing_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY filing_status
    ADD CONSTRAINT filing_status_pkey PRIMARY KEY (id);


--
-- Name: filing_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY filing_types
    ADD CONSTRAINT filing_types_pkey PRIMARY KEY (id);


--
-- Name: license_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY license_status
    ADD CONSTRAINT license_status_pkey PRIMARY KEY (id);


--
-- Name: license_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY license_types
    ADD CONSTRAINT license_types_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: markets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY markets
    ADD CONSTRAINT markets_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: personal_licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY personal_licenses
    ADD CONSTRAINT personal_licenses_pkey PRIMARY KEY (id);


--
-- Name: service_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY service_areas
    ADD CONSTRAINT service_areas_pkey PRIMARY KEY (id);


--
-- Name: states_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: sub_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_categories
    ADD CONSTRAINT sub_categories_pkey PRIMARY KEY (id);


--
-- Name: user_auth_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_auth_tokens
    ADD CONSTRAINT user_auth_tokens_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_admin_notes_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_admin_notes_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_affiliations_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_affiliations_on_company_id ON affiliations USING btree (company_id);


--
-- Name: index_associations_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_associations_on_company_id ON associations USING btree (company_id);


--
-- Name: index_certifications_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_certifications_on_company_id ON certifications USING btree (company_id);


--
-- Name: index_companies_on_deleted_by_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_companies_on_deleted_by_user_id ON companies USING btree (deleted_by_user_id);


--
-- Name: index_companies_on_insurance_state_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_companies_on_insurance_state_id ON companies USING btree (insurance_state_id);


--
-- Name: index_company_categories_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_company_categories_on_company_id ON company_categories USING btree (company_id);


--
-- Name: index_company_categories_on_sub_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_company_categories_on_sub_category_id ON company_categories USING btree (sub_category_id);


--
-- Name: index_company_service_areas_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_company_service_areas_on_company_id ON company_service_areas USING btree (company_id);


--
-- Name: index_company_service_areas_on_service_area_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_company_service_areas_on_service_area_id ON company_service_areas USING btree (service_area_id);


--
-- Name: index_discounts_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_discounts_on_company_id ON discounts USING btree (company_id);


--
-- Name: index_discounts_on_market_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_discounts_on_market_id ON discounts USING btree (market_id);


--
-- Name: index_discounts_on_type_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_discounts_on_type_id ON discounts USING btree (type_id);


--
-- Name: index_locations_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_locations_on_company_id ON locations USING btree (company_id);


--
-- Name: index_locations_on_country_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_locations_on_country_id ON locations USING btree (country_id);


--
-- Name: index_locations_on_state_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_locations_on_state_id ON locations USING btree (state_id);


--
-- Name: index_pages_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_pages_on_name ON pages USING btree (name);


--
-- Name: index_pages_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_pages_on_slug ON pages USING btree (slug);


--
-- Name: index_service_areas_on_market_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_service_areas_on_market_id ON service_areas USING btree (market_id);


--
-- Name: index_states_on_country_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_states_on_country_id ON states USING btree (country_id);


--
-- Name: index_sub_categories_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sub_categories_on_category_id ON sub_categories USING btree (category_id);


--
-- Name: index_users_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_company_id ON users USING btree (company_id);


--
-- Name: index_users_on_created_by_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_created_by_user_id ON users USING btree (created_by_user_id);


--
-- Name: index_users_on_updated_by_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_updated_by_user_id ON users USING btree (updated_by_user_id);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_item_type_and_item_id ON versions USING btree (item_type, item_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20111210050744');

INSERT INTO schema_migrations (version) VALUES ('20120109074547');

INSERT INTO schema_migrations (version) VALUES ('20120130231436');

INSERT INTO schema_migrations (version) VALUES ('20120214022929');

INSERT INTO schema_migrations (version) VALUES ('20120309231232');

INSERT INTO schema_migrations (version) VALUES ('20120314030748');

INSERT INTO schema_migrations (version) VALUES ('20120325061841');

INSERT INTO schema_migrations (version) VALUES ('20120326230132');

INSERT INTO schema_migrations (version) VALUES ('20120326230213');

INSERT INTO schema_migrations (version) VALUES ('20120327093418');

INSERT INTO schema_migrations (version) VALUES ('20120328194211');

INSERT INTO schema_migrations (version) VALUES ('20120329030853');

INSERT INTO schema_migrations (version) VALUES ('20120329030854');

INSERT INTO schema_migrations (version) VALUES ('20120329085638');

INSERT INTO schema_migrations (version) VALUES ('20120331204925');

INSERT INTO schema_migrations (version) VALUES ('20120401224059');

INSERT INTO schema_migrations (version) VALUES ('20120402084108');

INSERT INTO schema_migrations (version) VALUES ('20120402113423');

INSERT INTO schema_migrations (version) VALUES ('20120403213400');
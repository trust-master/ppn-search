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

--
-- Name: ghstore; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE ghstore;


--
-- Name: ghstore_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ghstore_in(cstring) RETURNS ghstore
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'ghstore_in';


--
-- Name: ghstore_out(ghstore); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ghstore_out(ghstore) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'ghstore_out';


--
-- Name: ghstore; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE ghstore (
    INTERNALLENGTH = variable,
    INPUT = ghstore_in,
    OUTPUT = ghstore_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


--
-- Name: hstore; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE hstore;


--
-- Name: hstore_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION hstore_in(cstring) RETURNS hstore
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'hstore_in';


--
-- Name: hstore_out(hstore); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION hstore_out(hstore) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'hstore_out';


--
-- Name: hstore; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE hstore (
    INTERNALLENGTH = variable,
    INPUT = hstore_in,
    OUTPUT = hstore_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


--
-- Name: akeys(hstore); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION akeys(hstore) RETURNS text[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'akeys';


--
-- Name: avals(hstore); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION avals(hstore) RETURNS text[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'avals';


--
-- Name: defined(hstore, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION defined(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'defined';


--
-- Name: delete(hstore, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION delete(hstore, text) RETURNS hstore
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'delete';


--
-- Name: each(hstore); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION each(hs hstore, OUT key text, OUT value text) RETURNS SETOF record
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'each';


--
-- Name: exist(hstore, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION exist(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'exists';


--
-- Name: fetchval(hstore, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fetchval(hstore, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'fetchval';


--
-- Name: ghstore_compress(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ghstore_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'ghstore_compress';


--
-- Name: ghstore_consistent(internal, internal, integer, oid, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ghstore_consistent(internal, internal, integer, oid, internal) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'ghstore_consistent';


--
-- Name: ghstore_decompress(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ghstore_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'ghstore_decompress';


--
-- Name: ghstore_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ghstore_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'ghstore_penalty';


--
-- Name: ghstore_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ghstore_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'ghstore_picksplit';


--
-- Name: ghstore_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ghstore_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'ghstore_same';


--
-- Name: ghstore_union(internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ghstore_union(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'ghstore_union';


--
-- Name: gin_consistent_hstore(internal, smallint, internal, integer, internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gin_consistent_hstore(internal, smallint, internal, integer, internal, internal) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'gin_consistent_hstore';


--
-- Name: gin_extract_hstore(internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gin_extract_hstore(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'gin_extract_hstore';


--
-- Name: gin_extract_hstore_query(internal, internal, smallint, internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gin_extract_hstore_query(internal, internal, smallint, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'gin_extract_hstore_query';


--
-- Name: hs_concat(hstore, hstore); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION hs_concat(hstore, hstore) RETURNS hstore
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'hs_concat';


--
-- Name: hs_contained(hstore, hstore); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION hs_contained(hstore, hstore) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'hs_contained';


--
-- Name: hs_contains(hstore, hstore); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION hs_contains(hstore, hstore) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'hs_contains';


--
-- Name: isdefined(hstore, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION isdefined(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'defined';


--
-- Name: isexists(hstore, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION isexists(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'exists';


--
-- Name: skeys(hstore); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION skeys(hstore) RETURNS SETOF text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'skeys';


--
-- Name: svals(hstore); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION svals(hstore) RETURNS SETOF text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'svals';


--
-- Name: tconvert(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION tconvert(text, text) RETURNS hstore
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'tconvert';


--
-- Name: ->; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR -> (
    PROCEDURE = fetchval,
    LEFTARG = hstore,
    RIGHTARG = text
);


--
-- Name: <@; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <@ (
    PROCEDURE = hs_contained,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: =>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR => (
    PROCEDURE = tconvert,
    LEFTARG = text,
    RIGHTARG = text
);


--
-- Name: ?; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR ? (
    PROCEDURE = exist,
    LEFTARG = hstore,
    RIGHTARG = text,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: @; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR @ (
    PROCEDURE = hs_contains,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: @>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR @> (
    PROCEDURE = hs_contains,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: ||; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR || (
    PROCEDURE = hs_concat,
    LEFTARG = hstore,
    RIGHTARG = hstore
);


--
-- Name: ~; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR ~ (
    PROCEDURE = hs_contained,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: gin_hstore_ops; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS gin_hstore_ops
    DEFAULT FOR TYPE hstore USING gin AS
    STORAGE text ,
    OPERATOR 7 @>(hstore,hstore) ,
    OPERATOR 9 ?(hstore,text) ,
    FUNCTION 1 bttextcmp(text,text) ,
    FUNCTION 2 gin_extract_hstore(internal,internal) ,
    FUNCTION 3 gin_extract_hstore_query(internal,internal,smallint,internal,internal) ,
    FUNCTION 4 gin_consistent_hstore(internal,smallint,internal,integer,internal,internal);


--
-- Name: gist_hstore_ops; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS gist_hstore_ops
    DEFAULT FOR TYPE hstore USING gist AS
    STORAGE ghstore ,
    OPERATOR 7 @>(hstore,hstore) ,
    OPERATOR 9 ?(hstore,text) ,
    OPERATOR 13 @(hstore,hstore) ,
    FUNCTION 1 ghstore_consistent(internal,internal,integer,oid,internal) ,
    FUNCTION 2 ghstore_union(internal,internal) ,
    FUNCTION 3 ghstore_compress(internal) ,
    FUNCTION 4 ghstore_decompress(internal) ,
    FUNCTION 5 ghstore_penalty(internal,internal,internal) ,
    FUNCTION 6 ghstore_picksplit(internal,internal) ,
    FUNCTION 7 ghstore_same(internal,internal,internal);


SET default_tablespace = '';

SET default_with_oids = false;

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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fetched_at timestamp without time zone,
    raw_data hstore
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
    enforcement_action boolean DEFAULT false,
    name character varying(255),
    doing_business_as character varying(255),
    address text,
    phone_number character varying(255),
    responsible_person_license_number character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fetched_at timestamp without time zone,
    raw_data hstore
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    active boolean DEFAULT false,
    visible boolean DEFAULT false,
    deleted_at timestamp without time zone,
    deleted_by_user_id integer,
    admin_email character varying(255),
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
    offers_24_hour_service boolean DEFAULT false,
    offers_emergency_service boolean DEFAULT false,
    insured boolean DEFAULT false,
    insurance_state_id integer,
    insurance_certificate character varying(255),
    insurance_valid_from date,
    insurance_valid_until date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
-- Name: company_service_areas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE company_service_areas (
    id integer NOT NULL,
    company_id integer,
    service_area_id integer,
    partial_only boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
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
-- Name: locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    company_id integer,
    city character varying(255),
    state_id integer,
    zip character varying(255),
    country_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    enforcement_action boolean DEFAULT false,
    name character varying(255),
    address text,
    phone_number character varying(255),
    issued_on date,
    expires_on date,
    printed_on date,
    effective_on date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fetched_at timestamp without time zone,
    raw_data hstore
);


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
-- Name: rails_admin_histories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rails_admin_histories (
    id integer NOT NULL,
    message text,
    username character varying(255),
    item integer,
    "table" character varying(255),
    month smallint,
    year bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rails_admin_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rails_admin_histories_id_seq OWNED BY rails_admin_histories.id;


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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    expires_at timestamp without time zone,
    created_at timestamp without time zone,
    created_by_ip character varying(255),
    updated_at timestamp without time zone
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
    active boolean DEFAULT false,
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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

ALTER TABLE personal_licenses ALTER COLUMN id SET DEFAULT nextval('personal_licenses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE rails_admin_histories ALTER COLUMN id SET DEFAULT nextval('rails_admin_histories_id_seq'::regclass);


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
-- Name: personal_licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY personal_licenses
    ADD CONSTRAINT personal_licenses_pkey PRIMARY KEY (id);


--
-- Name: rails_admin_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rails_admin_histories
    ADD CONSTRAINT rails_admin_histories_pkey PRIMARY KEY (id);


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
-- Name: business_filings_raw_data; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX business_filings_raw_data ON business_filings USING gin (raw_data);


--
-- Name: business_licenses_raw_data; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX business_licenses_raw_data ON business_licenses USING gin (raw_data);


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
-- Name: index_rails_admin_histories; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rails_admin_histories ON rails_admin_histories USING btree (item, "table", month, year);


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
-- Name: personal_licenses_raw_data; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX personal_licenses_raw_data ON personal_licenses USING gin (raw_data);


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

INSERT INTO schema_migrations (version) VALUES ('20120315220055');

INSERT INTO schema_migrations (version) VALUES ('20120315222500');
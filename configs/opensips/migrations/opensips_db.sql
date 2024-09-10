CREATE TABLE version (
    table_name VARCHAR(32) NOT NULL,
    table_version INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT version_t_name_idx UNIQUE (table_name)
);

INSERT INTO version (table_name, table_version) values ('dialog','11');
CREATE TABLE dialog (
    dlg_id BIGINT PRIMARY KEY NOT NULL,
    callid VARCHAR(255) NOT NULL,
    from_uri VARCHAR(255) NOT NULL,
    from_tag VARCHAR(64) NOT NULL,
    to_uri VARCHAR(255) NOT NULL,
    to_tag VARCHAR(64) NOT NULL,
    mangled_from_uri VARCHAR(64) DEFAULT NULL,
    mangled_to_uri VARCHAR(64) DEFAULT NULL,
    caller_cseq VARCHAR(11) NOT NULL,
    callee_cseq VARCHAR(11) NOT NULL,
    caller_ping_cseq INTEGER NOT NULL,
    callee_ping_cseq INTEGER NOT NULL,
    caller_route_set TEXT,
    callee_route_set TEXT,
    caller_contact VARCHAR(255),
    callee_contact VARCHAR(255),
    caller_sock VARCHAR(64) NOT NULL,
    callee_sock VARCHAR(64) NOT NULL,
    state INTEGER NOT NULL,
    start_time INTEGER NOT NULL,
    timeout INTEGER NOT NULL,
    vars BYTEA DEFAULT NULL,
    profiles TEXT DEFAULT NULL,
    script_flags INTEGER DEFAULT 0 NOT NULL,
    module_flags INTEGER DEFAULT 0 NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    rt_on_answer VARCHAR(64) DEFAULT NULL,
    rt_on_timeout VARCHAR(64) DEFAULT NULL,
    rt_on_hangup VARCHAR(64) DEFAULT NULL
);

INSERT INTO version (table_name, table_version) values ('load_balancer','3');
CREATE TABLE load_balancer (
    id SERIAL PRIMARY KEY NOT NULL,
    group_id INTEGER DEFAULT 0 NOT NULL,
    dst_uri VARCHAR(128) NOT NULL,
    resources VARCHAR(255) NOT NULL,
    probe_mode INTEGER DEFAULT 0 NOT NULL,
    attrs VARCHAR(255) DEFAULT NULL,
    description VARCHAR(128) DEFAULT NULL
);

ALTER SEQUENCE load_balancer_id_seq MAXVALUE 2147483647 CYCLE;
CREATE INDEX load_balancer_dsturi_idx ON load_balancer (dst_uri);

INSERT INTO public.load_balancer (group_id,dst_uri,resources,probe_mode,attrs,description) VALUES
	(0,'sip:10.11.1.3:5060','pstn=10',0,NULL,NULL);

CREATE TABLE destinations (
    range_start bigint NOT NULL,
    range_end bigint NOT NULL,
    net smallint NOT NULL
);

CREATE INDEX range_idx ON destinations USING BRIN ("range_start", "range_end");

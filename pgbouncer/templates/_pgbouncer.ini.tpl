{{ define "pgbouncer.ini.1.0.0" }}

{{- $root := . -}}

;; database name = {{ .Values.replicaCount }}
[databases]
{{- range $k, $v := .Values.databases }}

{{- $requiredMsg := printf ".Values.databases.%v needs to include .dbname" $k }}
{{- if $root.Values.global.namespacedDatabases }}
{{ $k }} = host={{ $v.host }} port={{ $v.port }} {{ if $v.user }}user={{ $v.user }}{{end}} {{ if $v.auth_user }}auth_user={{ $v.auth_user }}{{end}} dbname={{ $root.Release.Namespace | replace "-" "_"}}_{{ required $requiredMsg $v.dbname }}
{{- else }}
{{ $k }} = host={{ $v.host }} port={{ $v.port }} {{ if $v.user }}user={{ $v.user }}{{end}} {{ if $v.auth_user }}auth_user={{ $v.auth_user }}{{end}} {{ if $v.dbname }}dbname={{ $v.dbname }}{{end}}
{{- end }}

{{- end }}


[pgbouncer]

;;; Administrative settings
;logfile = /var/log/pgbouncer/pgbouncer.log
;pidfile = /var/run/pgbouncer/pgbouncer.pid

;;; Where to wait for clients
listen_addr = 0.0.0.0
listen_port = 5432
unix_socket_dir = var/run/postgresql
;unix_socket_mode = 0777
;unix_socket_group =
;client_tls_sslmode = disable
;client_tls_ca_file = <system default>
;client_tls_key_file =
;client_tls_cert_file =
;client_tls_ciphers = fast
;client_tls_protocols = all
;client_tls_dheparams = auto
;client_tls_ecdhcurve = auto
;server_tls_sslmode = disable
;server_tls_ca_file = <system default>
;server_tls_key_file =
;server_tls_cert_file =
;server_tls_protocols = all
;server_tls_ciphers = fast
; any, trust, plain, crypt, md5, cert, hba, pam

;;; Authentication settings

auth_type = {{ .Values.settings.auth_type }}
;auth_file = /8.0/main/global/pg_auth
auth_file = /etc/pgbouncer.d/userlist.txt
;auth_hba_file =

{{ .Values.settings.auth_query }}

;;; Users allowed into database 'pgbouncer'
{{- $users := (join ", " (keys .Values.users | sortAlpha)) }}
admin_users = {{ $users }}
stats_users = {{ $users }}, stats, root, monitor

;;; Pooler personality

pool_mode = {{ .Values.poolMode }}
server_reset_query = DISCARD ALL
;server_reset_query_always = 0
;ignore_startup_parameters = extra_float_digits
;server_check_query = select 1
;server_check_delay = 30
;application_name_add_host = 0

;;; Connection limits

max_client_conn = {{ .Values.connectionLimits.maxClientConn }}
default_pool_size = {{ .Values.connectionLimits.defaultPoolSize }}
min_pool_size = {{ .Values.connectionLimits.minPoolSize }}
reserve_pool_size = {{ .Values.connectionLimits.reservePoolSize }}
reserve_pool_timeout = {{ .Values.connectionLimits.reservePoolTimeout }}
;max_db_connections = 0
;max_user_connections = 0
;server_round_robin = 0
;syslog = 0
;syslog_facility = daemon
;syslog_ident = pgbouncer

;;; Logging

log_connections = {{ .Values.logConnections }}
log_disconnections = {{ .Values.logDisconnections }}
log_pooler_errors = {{ .Values.logPoolerErrors }}
log_stats = {{ .Values.logStats }}
stats_period = {{ .Values.statsPeriod }}
verbose = {{ .Values.verbose }}

;;; Timeouts

server_lifetime = {{ .Values.serverLifetime }}
server_idle_timeout = {{ .Values.serverIdleTimeout }}
server_connect_timeout = {{ .Values.serverConnectTimeout }}
server_login_retry = {{ .Values.serverLoginRetry }}
query_timeout = {{ .Values.queryTimeout }}
query_wait_timeout = {{ .Values.queryWaitTimeout }}
client_idle_timeout = {{ .Values.clientIdleTimeout }}
client_login_timeout = {{ .Values.clientLoginTimeout }}
;autodb_idle_timeout = 3600
;suspend_timeout = 10
;idle_transaction_timeout = 0

;;; Low-level tuning options

;pkt_buf = 4096
;listen_backlog = 128
;sbuf_loopcnt = 5
;max_packet_size = 2147483647

;tcp_defer_accept = 0
;tcp_socket_buffer = 0
tcp_keepalive = 1
tcp_keepcnt = 5
tcp_keepidle = 30
tcp_keepintvl = 30

;dns_max_ttl = 15
;dns_zone_check_period = 0
;dns_nxdomain_ttl = 15

;disable_pqexec = 0
;conffile
;service_name = pgbouncer
;job_name = pgbouncer
;%include /etc/pgbouncer/pgbouncer-other.ini

;;; Custom attributes added from .Values.customSettings
{{- range $k, $v := .Values.customSettings }}
{{ $k }} = {{ $v }}
{{- end }}
{{ end }}

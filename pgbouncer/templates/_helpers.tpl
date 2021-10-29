{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "pgbouncer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "pgbouncer.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pgbouncer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "pgbouncer.labels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "pgbouncer.chart" . }}
{{- if .Values.labels }}
{{ toYaml .Values.labels }}
{{- end }}
{{ include "pgbouncer.selectorLabels" . }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "pgbouncer.selectorLabels" -}}
{{- if .Values.helm2selector }}
app: {{ include "pgbouncer.fullname" . }}
release: {{ .Release.Name }}
{{- else }}
app.kubernetes.io/name: {{ include "pgbouncer.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Get the users secret name.
*/}}
{{- define "pgbouncer.usersSecretName" -}}
{{- if .Values.existingUsersSecret -}}
{{- printf "%s" .Values.existingUsersSecret -}}
{{- else -}}
{{- printf "%s-secret-userlist-txt" (include "pgbouncer.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Get the users key to be retrieved from pgbouncer secret.
*/}}
{{- define "pgbouncer.usersSecretKey" -}}
{{- if .Values.existingUsersSecretKey -}}
{{- printf "%s" .Values.existingUsersSecretKey -}}
{{- else -}}
{{- printf "userlist.txt" -}}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "nimbit-cloud.ocb.name" -}}
{{- default  (print .Chart.Name "-ocb") .Values.ocb.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nimbit-cloud.ocb.fullname" -}}
{{- if .Values.ocb.fullnameOverride }}
{{- .Values.ocb.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "ocb" .Values.ocb.nameOverride }}
{{- if contains .Release.Name $name }}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nimbit-cloud.ocb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nimbit-cloud.ocb.labels" -}}
helm.sh/chart: {{ include "nimbit-cloud.ocb.chart" . }}
{{ include "nimbit-cloud.ocb.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nimbit-cloud.ocb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nimbit-cloud.ocb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nimbit-cloud.ocb.serviceAccountName" -}}
{{- if .Values.ocb.serviceAccount.name }}
{{- default "default" .Values.ocb.serviceAccount.name }}
{{- else }}
{{- default (include "nimbit-cloud.ocb.name" .) }}
{{- end }}
{{- end }}


{{- define "isSecretRef" -}}
{{- $isMap := kindIs "map" . -}}
{{- if $isMap -}}
  {{- if hasKey . "secretKeyRef" -}}
    {{- true -}}
  {{- else -}}
    {{- false -}}
  {{- end -}}
{{- else -}}
  {{- false -}}
{{- end -}}
{{- end -}}


{{/*
RLS USER
*/}}
{{- define "nimbit-cloud.ocb.rls_uri" -}}
{{- if .Values.ocb.db.rls.secret -}}
{{- printf "%s" .Values.ocb.db.rls.secret | quote -}}
{{- else -}}
{{- printf "%s-pguser-rls-user" .Values.global.database.name | quote -}}
{{- end -}}
{{- end -}}



{{/*
PRISMA USER
*/}}
{{- define "nimbit-cloud.ocb.prisma" -}}
{{- if .Values.ocb.db.prisma.secret -}}
{{- printf "%s" .Values.ocb.db.prisma.secret | quote -}}
{{- else -}}
{{- printf "%s-pguser-prisma" .Values.global.database.name | quote -}}
{{- end -}}
{{- end -}}
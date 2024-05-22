{{/*
Expand the name of the chart.
*/}}
{{- define "nimbit-cloud.nbq.name" -}}
{{- default  (print .Chart.Name "-nbq") .Values.nbq.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nimbit-cloud.nbq.fullname" -}}
{{- if .Values.nbq.fullnameOverride }}
{{- .Values.nbq.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "nbq" .Values.nbq.nameOverride }}
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
{{- define "nimbit-cloud.nbq.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "nimbit-cloud.nbq.labels" -}}
helm.sh/chart: {{ include "nimbit-cloud.nbq.chart" . }}
{{ include "nimbit-cloud.nbq.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nimbit-cloud.nbq.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nimbit-cloud.nbq.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nimbit-cloud.nbq.serviceAccountName" -}}
{{- if .Values.nbq.serviceAccount.name }}
{{- default "default" .Values.nbq.serviceAccount.name }}
{{- else }}
{{- default (include "nimbit-cloud.nbq.name" .) }}
{{- end }}
{{- end }}


{{- define "supabase.secret.jwt" -}}
{{- default (print .Chart.Name "-supabase-jwt") | trunc 63 | trimSuffix "-" }}
{{- end }}

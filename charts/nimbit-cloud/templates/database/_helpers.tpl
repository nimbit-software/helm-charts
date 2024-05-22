{{/*
Expand the name of the chart.
*/}}
{{- define "nimbit-cloud.tsdb.name" -}}
{{- default  (print .Chart.Name "-tsdb") .Values.tsdb.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nimbit-cloud.tsdb.fullname" -}}
{{- if .Values.tsdb.fullnameOverride }}
{{- .Values.tsdb.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "tsdb" .Values.tsdb.nameOverride }}
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
{{- define "nimbit-cloud.tsdb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nimbit-cloud.tsdb.labels" -}}
helm.sh/chart: {{ include "nimbit-cloud.tsdb.chart" . }}
{{ include "nimbit-cloud.tsdb.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nimbit-cloud.tsdb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nimbit-cloud.tsdb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nimbit-cloud.tsdb.serviceAccountName" -}}
{{- if .Values.tsdb.serviceAccount.name }}
{{- default "default" .Values.tsdb.serviceAccount.name }}
{{- else }}
{{- default (include "nimbit-cloud.tsdb.name" .) }}
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
{{/*
Expand the name of the chart.
*/}}
{{- define "nimbit-cloud.dip.name" -}}
{{- default  (print .Chart.Name "-dip") .Values.dip.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nimbit-cloud.dip.fullname" -}}
{{- if .Values.dip.fullnameOverride }}
{{- .Values.dip.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "dip" .Values.dip.nameOverride }}
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
{{- define "nimbit-cloud.dip.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nimbit-cloud.dip.labels" -}}
helm.sh/chart: {{ include "nimbit-cloud.dip.chart" . }}
{{ include "nimbit-cloud.dip.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nimbit-cloud.dip.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nimbit-cloud.dip.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nimbit-cloud.dip.serviceAccountName" -}}
{{- if .Values.dip.serviceAccount.name }}
{{- default "default" .Values.dip.serviceAccount.name }}
{{- else }}
{{- default (include "nimbit-cloud.dip.name" .) }}
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
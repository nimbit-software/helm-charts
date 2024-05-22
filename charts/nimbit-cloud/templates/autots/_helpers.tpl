{{/*
Expand the name of the chart.
*/}}
{{- define "nimbit-cloud.autots.name" -}}
{{- default  (print .Chart.Name "-autots") .Values.autots.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nimbit-cloud.autots.fullname" -}}
{{- if .Values.autots.fullnameOverride }}
{{- .Values.autots.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "autots" .Values.autots.nameOverride }}
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
{{- define "nimbit-cloud.autots.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nimbit-cloud.autots.labels" -}}
helm.sh/chart: {{ include "nimbit-cloud.autots.chart" . }}
{{ include "nimbit-cloud.autots.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nimbit-cloud.autots.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nimbit-cloud.autots.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nimbit-cloud.autots.serviceAccountName" -}}
{{- if .Values.autots.serviceAccount.name }}
{{- default "default" .Values.autots.serviceAccount.name }}
{{- else }}
{{- default (include "nimbit-cloud.autots.name" .) }}
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
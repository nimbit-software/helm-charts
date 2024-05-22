{{/*
Expand the name of the chart.
*/}}
{{- define "nimbit-cloud.breeze.name" -}}
{{- default  (print .Chart.Name "-breeze") .Values.breeze.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nimbit-cloud.breeze.fullname" -}}
{{- if .Values.breeze.fullnameOverride }}
{{- .Values.breeze.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "breeze" .Values.breeze.nameOverride }}
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
{{- define "nimbit-cloud.breeze.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nimbit-cloud.breeze.labels" -}}
helm.sh/chart: {{ include "nimbit-cloud.breeze.chart" . }}
{{ include "nimbit-cloud.breeze.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nimbit-cloud.breeze.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nimbit-cloud.breeze.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nimbit-cloud.breeze.serviceAccountName" -}}
{{- if .Values.breeze.serviceAccount.create }}
{{- default (include "nimbit-cloud.breeze.fullname" .) .Values.breeze.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.breeze.serviceAccount.name }}
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
{{/*
Expand the name of the chart.
*/}}
{{- define "nimbit-cloud.node-red.name" -}}
{{- default (print .Chart.Name "-node-red") .Values.nodered.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}



{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nimbit-cloud.node-red.fullname" -}}
{{- if .Values.nodered.fullnameOverride }}
{{- .Values.nodered.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "node-red" .Values.nodered.nameOverride }}
{{- if contains .Release.Name $name }}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
{{/*

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nimbit-cloud.node-red.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nimbit-cloud.node-red.labels" -}}
helm.sh/chart: {{ include "nimbit-cloud.node-red.chart" . }}
{{ include "nimbit-cloud.node-red.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nimbit-cloud.node-red.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nimbit-cloud.node-red.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nimbit-cloud.node-red.serviceAccountName" -}}
{{- if .Values.nodered.serviceAccount.create }}
{{- default (include "nimbit-cloud.node-red.fullname" .) .Values.nodered.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.nodered.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the configmap
*/}}
{{- define "nimbit-cloud.node-red.settingsConfigMap" -}}
{{ printf "node-red-settings-cm" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of the configmap
*/}}
{{- define "nimbit-cloud.node-red.configMapName" -}}
{{ printf "%s-npmrc-cm" (include "nimbit-cloud.node-red.fullname" $) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of the sidecar-configmap
*/}}
{{- define "nimbit-cloud.node-red.sidecarConfigMapName" -}}
{{ printf "%s-flow-refresh-cm" (include "nimbit-cloud.node-red.fullname" $) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of the certificate
*/}}
{{- define "nimbit-cloud.node-red.certificateName" -}}
{{ printf "%s-cert" (include "nimbit-cloud.node-red.fullname" $) | trunc 63 | trimSuffix "-" }}
{{- end }}
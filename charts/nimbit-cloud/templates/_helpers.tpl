{{/*
Deployment environment name
*/}}
{{- define "nimbit-cloud.deployment.environment" -}}
{{- default  (print .Chart.Name "-nimbit") .Values.global.environment | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
tenant type.
*/}}
{{- define "nimbit-cloud.tenant.type" -}}
{{- default (print .Chart.Name "-shared") .Values.global.type | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
tenant type.
*/}}
{{- define "nimbit-cloud.tenant.name" -}}
{{- default  (print .Chart.Name "-shared") .Values.global.name | trunc 63 | trimSuffix "-" }}
{{- end }}
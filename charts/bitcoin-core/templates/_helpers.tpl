{{/* ########### Name ########### */}}
{{- define "bitcoin-core.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### Service Name ########### */}}
{{- define "bitcoin-core.serviceName" -}}
{{- default .Chart.Name .Values.service.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### Selector labels ########### */}}
{{- define "bitcoin-core.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bitcoin-core.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* ########### All labels ########### */}}
{{- define "bitcoin-core.labels" -}}
helm.sh/chart: {{ include "bitcoin-core.chart" . }}
{{ include "bitcoin-core.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* ########### Image Selection Helper ########### */}}
{{- define "bitcoin-core.image" -}}
{{- if contains "sha:" .Values.image.tag -}}
"{{ .Values.image.name }}@{{ .Values.image.tag }}"
{{- else -}}
"{{ .Values.image.name }}:{{ .Values.image.tag }}"
{{- end -}}
{{- end -}}
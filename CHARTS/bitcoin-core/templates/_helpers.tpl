{{/* ########### Name ########### */}}
{{- define "bitcoin-core.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### FullName ########### */}}
{{- define "bitcoin-core.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* ########### Chart ########### */}}
{{- define "bitcoin-core.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
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

{{/* ########### Create the full name for the persistent volume ########### */}}
{{- define "bitcoin-core.persistenVolumeName" -}}
{{- if .Values.dataPersistency.testMode -}}
"{{ include "bitcoin-core.name" . }}-data-test"
{{- else -}}
"{{ include "bitcoin-core.name" . }}-data"
{{- end -}}
{{- end -}}
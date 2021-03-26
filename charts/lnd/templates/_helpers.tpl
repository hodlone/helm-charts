{{/* ########### Name ########### */}}
{{- define "lnd.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### FullName ########### */}}
{{- define "lnd.fullname" -}}
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
{{- define "lnd.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### Service Name ########### */}}
{{- define "lnd.serviceName" -}}
{{- default .Chart.Name .Values.service.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### Selector labels ########### */}}
{{- define "lnd.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lnd.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* ########### All labels ########### */}}
{{- define "lnd.labels" -}}
helm.sh/chart: {{ include "lnd.chart" . }}
{{ include "lnd.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* ########### Image Selection Helper ########### */}}
{{- define "lnd.image" -}}
{{- if contains "sha:" .Values.image.tag -}}
"{{ .Values.image.name }}@{{ .Values.image.tag }}"
{{- else -}}
"{{ .Values.image.name }}:{{ .Values.image.tag }}"
{{- end -}}
{{- end -}}

{{/* ########### Create the full name for the persistent volume ########### */}}
{{- define "lnd.persistenVolumeName" -}}
{{- if .Values.dataPersistency.testMode -}}
"{{ include "lnd.name" . }}-data-test"
{{- else -}}
"{{ include "lnd.name" . }}-data"
{{- end -}}
{{- end -}}
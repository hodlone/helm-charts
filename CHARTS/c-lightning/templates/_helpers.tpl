{{/* ########### Name ########### */}}
{{- define "c-lightning.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### FullName ########### */}}
{{- define "c-lightning.fullname" -}}
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
{{- define "c-lightning.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### Service Name ########### */}}
{{- define "c-lightning.serviceName" -}}
{{- default .Chart.Name .Values.service.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### Selector labels ########### */}}
{{- define "c-lightning.selectorLabels" -}}
app.kubernetes.io/name: {{ include "c-lightning.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* ########### All labels ########### */}}
{{- define "c-lightning.labels" -}}
helm.sh/chart: {{ include "c-lightning.chart" . }}
{{ include "c-lightning.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* ########### Image Selection Helper ########### */}}
{{- define "c-lightning.image" -}}
{{- if contains "sha:" .Values.image.tag -}}
"{{ .Values.image.name }}@{{ .Values.image.tag }}"
{{- else -}}
"{{ .Values.image.name }}:{{ .Values.image.tag }}"
{{- end -}}
{{- end -}}

{{/* ########### Create the full name for the persistent volume ########### */}}
{{- define "c-lightning.persistenVolumeName" -}}
{{- if .Values.dataPersistency.testMode -}}
"{{ include "c-lightning.name" . }}-data-test"
{{- else -}}
"{{ include "c-lightning.name" . }}-data"
{{- end -}}
{{- end -}}
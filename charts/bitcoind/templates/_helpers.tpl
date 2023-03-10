{{/* ########### Name ########### */}}
{{- define "bitcoind.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### FullName ########### */}}
{{- define "bitcoind.fullname" -}}
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
{{- define "bitcoind.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### Service Name ########### */}}
{{- define "bitcoind.serviceName" -}}
{{- default .Chart.Name .Values.service.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### Selector labels ########### */}}
{{- define "bitcoind.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bitcoind.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* ########### All labels ########### */}}
{{- define "bitcoind.labels" -}}
helm.sh/chart: {{ include "bitcoind.chart" . }}
{{ include "bitcoind.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* ########### Image Selection Helper ########### */}}
{{- define "bitcoind.image" -}}
{{- if contains "sha:" .Values.image.tag -}}
"{{ .Values.image.name }}@{{ .Values.image.tag }}"
{{- else -}}
"{{ .Values.image.name }}:{{ .Values.image.tag }}"
{{- end -}}
{{- end -}}

{{/* ########### Create the full name for the persistent volume ########### */}}
{{- define "bitcoind.persistenVolumeName" -}}
"{{ include "bitcoind.name" . }}-{{ .Values.dataPersistency.storageClass }}"
{{- end -}}
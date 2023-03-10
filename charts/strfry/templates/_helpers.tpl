{{/* ########### Name ########### */}}
{{- define "strfry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### Headless Service Name ########### */}}
{{- define "strfry.headlessServiceName" -}}
{{- include "strfry.name" . -}}-headless
{{- end -}}

{{/* ########### Configmap Name ########### */}}
{{- define "strfry.configMapName" -}}
{{- include "strfry.name" . -}}-config
{{- end -}}

{{/* ########### Chart ########### */}}
{{- define "strfry.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ########### Selector labels ########### */}}
{{- define "strfry.selectorLabels" -}}
app.kubernetes.io/name: {{ include "strfry.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* ########### All labels ########### */}}
{{- define "strfry.labels" -}}
helm.sh/chart: {{ include "strfry.chart" . }}
{{ include "strfry.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* ########### Image Selection Helper ########### */}}
{{- define "strfry.image" -}}
{{- if contains "sha:" .Values.image.tag -}}
"{{ .Values.image.repository }}@{{ .Values.image.tag }}"
{{- else -}}
"{{ .Values.image.repository }}:{{ .Values.image.tag }}"
{{- end -}}
{{- end -}}
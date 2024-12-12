{{/*
Helper template to construct the full name of resources
*/}}
{{- define "k8s-program.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{ .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" $name .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end -}}

{{/*
Helper template to construct the name of the chart
*/}}
{{- define "k8s-program.chart" -}}
{{ printf "%s-%s" .Chart.Name .Chart.Version | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Helper template to define common labels for all resources
*/}}
{{- define "k8s-program.labels" -}}
app.kubernetes.io/name: {{ include "k8s-program.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "k8s-program.chart" . }}
app.kubernetes.io/created: "{{ now | date "20060102T150405" }}" # Sanitized format for labels
{{- end -}}

{{/*
Helper template to define selector labels
*/}}
{{- define "k8s-program.selectorLabels" -}}
app.kubernetes.io/name: {{ include "k8s-program.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Helper template for resource annotations
*/}}
{{- define "k8s-program.annotations" -}}
helm.sh/chart: {{ include "k8s-program.chart" . }}
{{- end -}}
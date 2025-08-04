{{/*
Expand the name of the chart
*/}}
{{- define "danielle-react.name" -}}
{{ .Chart.Name }}
{{- end }}

{{/*
Create a default fully qualified app name
*/}}
{{- define "danielle-react.fullname" -}}
{{ .Release.Name }}
{{- end }}

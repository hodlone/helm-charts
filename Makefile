package:
	helm package ./charts/* -d docs

index:
	helm repo index --url https://hodlone.github.io/helm-charts/docs ./docs

echo ''
echo '==> Generating new Index'
helm repo index --url https://hodlone.github.io/helm-charts/PKG ./PKG
mv ./PKG/index.yaml .

echo ''
echo '==> Success'

echo ''
echo '==> Packaging all helm charts from ./charts directory'
echo ''
helm package ./charts/* -d docs
echo ''
echo '==> Success'

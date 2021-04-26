# The Hodlone repository for Kubernetes
Bitcoin centric applications, provided by Hodlone, ready to launch on Kubernetes using Kubernetes Helm.

TL;DR

```shell
$ helm version
$ helm plugin install https://github.com/hayorov/helm-gcs --version "0.3.1"
$ helm repo add hodlone gs://hodlone-helm-repo
$ helm install hodlone/<name-of-the-chart>
```
## Installation process

### Prerequisites
1. a Kubernetes cluster running 1.12+
2. a workstation with Helm 3.1.0+ and k8s cluster credentials 

### Install helm-gcs plugin
The following command allows you to download and install all the charts from this repository:

```shell
$ helm plugin install https://github.com/hayorov/helm-gcs --version "0.3.1"
```

### Adding the hodlone repository

``` shell
$ helm repo add hodlone gs://hodlone-helm-repo
```

## Using this repo
Once you have installed the helm-gcs plugin and added the hodlone repo, you can deploy our charts into any Kubernetes cluster you have access to  

```shell
$ helm install hodlone/<name-of-the-chart>
```

### Some images are not publicy served
but you can find the dockerfiles in the `docker` directory of this repo and override the image on during installs

```shell
$ helm install <my-release> --set image.name=foo --set image.tag=bar hodlone/<name-of-the-chart>  
```

### Some charts require persistency
`bitcoin-core` and `lnd` apps require data persistency; since the host environment can greatly vary, data persistency options will also vary. We provide our charts with a generic PersistentVolume. you can see all options with examples in the kubernetes [docs](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#types-of-persistent-volumes), normally you should only need to add the `providerPvConfig` block to your values file matching the type of persistent volume you want to use.


```yaml
# this is an example for a persistent disk on Google Cloud Platform
providerPvConfig:
  gcePersistentDisk:
    pdName: "bitcoin-core-data"
    fsType: "ext4"
```

```yaml
# this is an example for your Raspberry pi k3s cluster
providerPvConfig:
  local:
    path: "/mnt/disks/ssd1"
```

### Modifying charts
if you want to modify the charts, you can get the source code in the `CHARTS` directory of this repo, or you could pull and unpack these charts using the following command 

```shell
$ helm pull hodlone/<name-of-the-chart> --untar
```

### Useful Helm Client Commands:

1. View available charts: `helm search repo`
2. Install a chart: `helm install my-release hodlone/<name-of-the-chart>`
3. Upgrade your application: `helm upgrade`
4. Installing local charts: `helm install <my-release> <path-to-my-chart>`

## License
[MPL-2.0](https://choosealicense.com/licenses/mpl-2.0/)
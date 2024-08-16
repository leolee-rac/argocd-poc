https://www.arthurkoziel.com/setting-up-argocd-with-helm/
helm search repo argo/argo-cd --versions
$ helm repo add argo-cd https://argoproj.github.io/argo-helm
$ helm dep update charts/argo-cd/

kubectl rollout restart deployment argocd-server -n default
https://www.arthurkoziel.com/setting-up-argocd-with-helm/
helm search repo argo/argo-cd --versions
$ helm repo add argo-cd https://argoproj.github.io/argo-helm
$ helm dep update charts/argo-cd/

kubectl rollout restart deployment argocd-server -n default

# Minikube https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2Fchocolatey#Service
disconnect GP
minikube start --vm-driver=hyperv --alsologtostderr -v=7
minikube start --cpus 4 --memory 3072

argocd admin initial-password -n default

minikube node add
## https://medium.com/cloudnloud/how-to-minikube-with-multi-node-setup-1159006fc80e
minikube start — nodes=2 -p dev

minikube start — nodes=2 -p stg

minikube start — nodes=2 -p prod
M4bfjMij8htyuwzk
kubectl port-forward svc/argocd-server -n default 8080:443
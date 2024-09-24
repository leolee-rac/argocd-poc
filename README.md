https://www.arthurkoziel.com/setting-up-argocd-with-helm/
helm search repo argo/argo-cd --versions
$ helm repo add argo-cd https://argoproj.github.io/argo-helm
$ helm dep update charts/argo-cd/

kubectl rollout restart deployment argocd-server -n default

# Minikube https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2Fchocolatey#Service
disconnect GP
minikube start --vm-driver=hyperv --alsologtostderr -v=7
minikube start --cpus 4 --memory 4096 --alsologtostderr -v=7
minikube start --driver=docker --cpus 4 --memory 8208 --alsologtostderr -v=7
minikube dashboard

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl port-forward service/argocd-server -n argocd 8080:443
argocd admin initial-password -n argocd
6P8VA88vCaQwtzfA

# Install docker image to minikube
minikube docker-env | Invoke-Expression


## https://medium.com/cloudnloud/how-to-minikube-with-multi-node-setup-1159006fc80e
minikube start — nodes=2 -p dev

minikube start — nodes=2 -p stg

minikube start — nodes=2 -p prod

kubectl port-forward svc/argo-cd-argocd-server -n default 8080:443
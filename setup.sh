# kubectl delete -f srcs/kubernetes
# minikube delete --all

cd srcs

#--- Start minikube
minikube start --vm-driver=docker
# to prevent error image never pull
eval $(minikube docker-env) 


#--- Docker build containers && run deployments / services ---

# MetalLB --------------------
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl create -f ./kubernetes/metalLB.yaml

# INFLUX DB ----------------------
kubectl create -f kubernetes/influxVol.yaml
docker build -t influxdb ./influxdb/.
kubectl create -f kubernetes/influxdb.yaml

# MYSQL ----------------------
kubectl create -f kubernetes/mysqlVol.yaml
docker build -t mysql ./mysql/.
kubectl create -f kubernetes/mysql.yaml

# NGINX ----------------------
docker build -t nginx ./nginx/.
kubectl create -f kubernetes/nginx.yaml

# WORDPRESS -------------------
docker build -t wordpress ./wordpress/.
kubectl create -f kubernetes/wordpress.yaml

# FTPS -----------------------
docker build -t ftps ./ftps/.
kubectl create -f kubernetes/ftps.yaml

# PHPMyAdmin --------------------
docker build -t phpmyadmin ./phpmyadmin/.
kubectl create -f kubernetes/phpmyadmin.yaml

# Grafanna ------------------------
docker build -t grafana ./grafana/.
kubectl create -f kubernetes/grafana.yaml

# Add SQL database to Wordpress
kubectl exec -i `kubectl get pods | grep -o "mysql\S*"` -- mysql -u root < mysql/srcs/wordpress.sql

# SSH
ssh-keygen -f "/home/user42/.ssh/known_hosts" -R "172.17.0.240"

#--- Launch minikube dashboard
minikube dashboard
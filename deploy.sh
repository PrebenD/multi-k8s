docker build -t prebenmd/multi-client-k8s:latest -t prebenmd/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t prebenmd/multi-server-k8s-pgfix:latest -t prebenmd/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t prebenmd/multi-worker-k8s:latest -t prebenmd/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push prebenmd/multi-client-k8s:latest
docker push prebenmd/multi-server-k8s-pgfix:latest
docker push prebenmd/multi-worker-k8s:latest

docker push prebenmd/multi-client-k8s:$SHA
docker push prebenmd/multi-server-k8s-pgfix:$SHA
docker push prebenmd/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=prebenmd/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=prebenmd/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=prebenmd/multi-worker-k8s:$SHA
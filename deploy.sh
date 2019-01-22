docker build -t samjbro/multi-k8s-client:latest -t samjbro/multi-k8s-client:$SHA -f ./client/Dockerfile ./client
docker build -t samjbro/multi-k8s-server:latest -t samjbro/multi-k8s-server:$SHA -f ./server/Dockerfile ./server
docker build -t samjbro/multi-k8s-worker:latest -t samjbro/multi-k8s-worker:$SHA -f ./worker/Dockerfile ./worker

docker push samjbro/multi-k8s-client:latest
docker push samjbro/multi-k8s-server:latest
docker push samjbro/multi-k8s-worker:latest

docker push samjbro/multi-k8s-client:$SHA
docker push samjbro/multi-k8s-server:$SHA
docker push samjbro/multi-k8s-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployent client=samjbro/multi-k8s-client:$SHA
kubectl set image deployments/server-deployment server=samjbro/multi-k8s-server:$SHA
kubectl set image deployments/worker-deployent worker=samjbro/multi-k8s-worker:$SHA
docker build -t pawleztef/multi-client:latest -t pawleztef/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pawelztef/multi-server:latest -t pawelztef/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pawelztef/multi-worker:latest -t pawelztef/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pawelztef/multi-client:latest
docker push pawelztef/multi-server:latest
docker push pawelztef/multi-worker:latest

docker push pawelztef/multi-client:$SHA
docker push pawelztef/multi-server:$SHA
docker push pawelztef/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pawelztef/multi-server:$SHA
kubectl set image deployments/client-deployment client=pawelztef/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pawelztef/multi-worker:$SHA

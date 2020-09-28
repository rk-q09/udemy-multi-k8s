docker build -t etsuk/multi-client:latest -t etsuk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t etsuk/multi-server:latest -t etsuk/multi-server:$SHA -f ./sever/Dockerfile ./server
docker build -t etsuk/multi-worker:latest -t etsuk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push etsuk/multi-client:latest
docker push etsuk/multi-server:latest
docker push etsuk/multi-worker:latest

docker push etsuk/multi-client:$SHA
docker push etsuk/multi-server:$SHA
docker push etsuk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=etsuk/multi-server:$SHA
kubectl set image deployments/client-deployment client=etsuk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=etsuk/multi-worker:$SHA
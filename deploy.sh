docker build -t nakul080816/multi-client:latest -t nakul080816/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nakul080816/multi-server:latest -t nakul080816/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nakul080816/multi-worker:latest -t nakul080816/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nakul080816/multi-client:latest
docker push nakul080816/multi-server:latest
docker push nakul080816/multi-worker:latest

docker push nakul080816/multi-client:$SHA
docker push nakul080816/multi-server:$SHA
docker push nakul080816/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=nakul080816/multi-server:$SHA
kubectl set image deployments/client-deployment client=nakul080816/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nakul080816/multi-worker:$SHA



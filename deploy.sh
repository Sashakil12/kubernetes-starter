docker build -t sashakil/final-client:latest -t sashakil/final-client:$SHA -f ./client/Dockerfile ./client
docker build -t sashakil/final-server:latest -t sashakil/final-server:$SHA -f ./server/Dockerfile ./server
docker build -t sashakil/final-worker:latest -t sashakil/final-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sashakil/final-client:latest
docker push sashakil/final-server:latest
docker push sashakil/final-worker:latest

docker push sashakil/final-client:$SHA
docker push sashakil/final-server:$SHA
docker push sashakil/final-worker:$SHA


kubectl apply -f k8s

kubectl set image deployments/<the name of the object inside yml file |server-deployment> <name you used for the container inside deployment file | server>=sashakil/final-server:$SHA
kubectl set image deployments/client-deployment client=sashakil/final-client:$SHA
kubectl set image deployments/worker-deployment worker=sashakil/final-worker:$SHA

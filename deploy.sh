docker build -t sutirthabagchi21/multi-client:latest -t sutirthabagchi21/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sutirthabagchi21/multi-server:latest -t sutirthabagchi21/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sutirthabagchi21/multi-worker:latest -t sutirthabagchi21/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sutirthabagchi21/multi-client:latest
docker push sutirthabagchi21/multi-server:latest
docker push sutirthabagchi21/multi-worker:latest

docker push sutirthabagchi21/multi-client:$SHA
docker push sutirthabagchi21/multi-server:$SHA
docker push sutirthabagchi21/multi-worker:$SHA

kubectl apply -f k8s
kubctl set image deployments/server-deployment server=sutirthabagchi21/multi-server:$SHA
kubctl set image deployments/client-deployment client=sutirthabagchi21/multi-client:$SHA
kubctl set image deployments/worker-deployment worker=sutirthabagchi21/multi-worker:$SHA
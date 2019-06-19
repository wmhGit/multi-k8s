docker build -t wmh17dc/multi-client:latest -t wmh17dc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wmh17dc/multi-server:latest -t wmh17dc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wmh17dc/multi-worker:latest -t wmh17dc/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push wmh17dc/multi-client:latest
docker push wmh17dc/multi-client:$SHA
docker push wmh17dc/multi-server:latest
docker push wmh17dc/multi-server:$SHA
docker push wmh17dc/multi-worker:latest
docker push wmh17dc/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments//server-deployment server=wmh17dc/multi-server:$SHA
kubectl set image deployments//client-deployment client=wmh17dc/multi-client:$SHA
kubectl set image deployments//worker-deployment worker=wmh17dc/multi-worker:$SHA

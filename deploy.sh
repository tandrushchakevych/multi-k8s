docker build -t tandrtc/multi-client:latest -t tandrtc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tandrtc/multi-server:latest -t tandrtc/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t tandrtc/multi-worker:latest -t tandrtc/multi-worker:$SHA -f ./client/Dockerfile ./worker

docker push tandrtc/multi-client:latest
docker push tandrtc/multi-server:latest
docker push tandrtc/multi-worker:latest

docker push tandrtc/multi-client:$SHA
docker push tandrtc/multi-server:$SHA
docker push tandrtc/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment server=tandrtc/multi-client:$SHA
kubectl set image deployments/server-deployment server=tandrtc/multi-server:$SHA
kubectl set image deployments/worker-deployment server=tandrtc/multi-worker:$SHA

docker build \
  -t jgwhite/multi-client:latest \
  -t jgwhite/multi-client:$GIT_SHA \
  -f ./client/Dockerfile \
  ./client

docker build \
  -t jgwhite/multi-server:latest \
  -t jgwhite/multi-server:$GIT_SHA \
  -f ./server/Dockerfile \
  ./server

docker build \
  -t jgwhite/multi-worker:latest \
  -t jgwhite/multi-worker:$GIT_SHA \
  -f ./worker/Dockerfile \
  ./worker

docker push jgwhite/multi-client:latest
docker push jgwhite/multi-server:latest
docker push jgwhite/multi-worker:latest

docker push jgwhite/multi-client:$GIT_SHA
docker push jgwhite/multi-server:$GIT_SHA
docker push jgwhite/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image \
  deployments/client-deployment \
  client=jgwhite/multi-client:$GIT_SHA

kubectl set image \
  deployments/server-deployment \
  server=jgwhite/multi-server:$GIT_SHA

kubectl set image \
  deployments/worker-deployment \
  worker=jgwhite/multi-worker:$GIT_SHA

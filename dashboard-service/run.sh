#!/bin/sh

# run consul client
consul agent -node=dashboard -join=consul-server -data-dir=/tmp/consul -config-dir=./consul &

# run go service
go run main.go &

#wait 20

# run consul sidecar proxy
#consul connect proxy -sidecar-for dashboard &
consul connect envoy -sidecar-for dashboard &

# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?
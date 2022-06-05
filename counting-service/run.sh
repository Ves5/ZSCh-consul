#!/bin/sh

# run consul client
consul agent -node=counting-1 -join=consul-server -data-dir=/tmp/consul -config-dir=./consul &

# run go service
go run main.go &

#wait 20

# run consul sidecar proxy
#consul connect proxy -sidecar-for counting-1 &
consul connect envoy -sidecar-for counting-1 -admin-bind localhost:19001 &

# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?
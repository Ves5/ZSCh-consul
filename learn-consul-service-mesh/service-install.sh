###
# Server
###

# add PORT config into Consul KV for each service
docker exec -d consul-server consul kv put port/dashboard 9002
docker exec -d consul-server consul kv put port/counting1 9003
docker exec -d consul-server consul kv put port/counting2 9004
sleep 1s

###
# Container 1
###

# Download sample data layer service, Counting service
#docker exec -d consul-counting1 wget https://github.com/hashicorp/demo-consul-101/releases/download/0.0.3.1/counting-service_linux_amd64.zip
#sleep 7s
# Unzip Counting service
#docker exec -d consul-counting1 unzip counting-service_linux_amd64.zip
#sleep 7s
# Start Counting service as background process in container
docker exec -d consul-counting1 go run /app/main.go &
sleep 1s
# Start Consul Sidecar Proxy for Counting service
docker exec -d consul-counting1 consul connect proxy -sidecar-for counting &
sleep 1s

###
# Container 3
###

# Start Counting service as background process in container
docker exec -d consul-counting2 go run /app/main.go &
sleep 1s
# Start Consul Sidecar Proxy for Counting service
docker exec -d consul-counting2 consul connect proxy -sidecar-for counting &
sleep 1s

###
# Container 2
###

# Download sample data layer service, Dashboard service
#docker exec -d consul-dashboard wget https://github.com/hashicorp/demo-consul-101/releases/download/0.0.3.1/dashboard-service_linux_amd64.zip
#sleep 7s
# Unzip Counting service
#docker exec -d consul-dashboard unzip dashboard-service_linux_amd64.zip
#sleep 7s
# Start Dashboard service as background process in container
docker exec -d consul-dashboard go run /app/main.go &
sleep 1s
# Start Consul Sidecar Proxy for Dashboard service
docker exec -d consul-dashboard consul connect proxy -sidecar-for dashboard &
sleep 1s

# Create Consul intention with Dashboard as source and Counting as destination
docker exec -d consul-dashboard consul config write intention-config-entry.json
sleep 1s
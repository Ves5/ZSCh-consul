FROM hashicorp/consul:1.9.6

# install golang
COPY --from=golang:1.13-alpine /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

RUN apk update
RUN apk add git

RUN go get github.com/gorilla/mux
RUN go get github.com/hashicorp/consul/api

#RUN consul agent -node=counting-1 -join=consul-server -data-dir=/tmp/consul &

#CMD ["./run.sh"]
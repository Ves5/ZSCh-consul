FROM consul:1.12.1

COPY --from=golang:1.13-alpine /usr/local/go/ /usr/local/go/
 
ENV PATH="/usr/local/go/bin:${PATH}"

RUN apk update
RUN apk add git

WORKDIR /app
RUN go get github.com/gorilla/mux

COPY . .

RUN curl -L https://func-e.io/install.sh | sh -s -- -b /usr/local/bin
RUN export FUNC_E_PLATFORM=linux/amd64
RUN func-e use 1.18.3
RUN cp ~/.func-e/versions/1.18.3/bin/envoy /usr/local/bin/

#RUN consul agent -node=counting-1 -join=consul-server -data-dir=/tmp/consul &

CMD ["./run.sh"]
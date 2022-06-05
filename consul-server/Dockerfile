FROM consul:1.12.1

COPY consul.hcl /consul/config/

RUN curl -L https://func-e.io/install.sh | sh -s -- -b /usr/local/bin
RUN export FUNC_E_PLATFORM=linux/amd64
RUN func-e use 1.18.3
RUN cp ~/.func-e/versions/1.18.3/bin/envoy /usr/local/bin/

CMD ["consul", "agent", "-server", "-ui", "-node=server", "-bootstrap-expect=1", "-client=0.0.0.0", "-data-dir=/tmp/consul", "-config-dir=/consul/config"]
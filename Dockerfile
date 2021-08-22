FROM debian:buster
VOLUME /tmp
COPY . /kippo
RUN chmod 777 -R /kippo
RUN apt update
RUN apt-get install -y build-essential python-dev libmariadb-dev python-virtualenv python-pip
RUN groupadd -g 999 mario && \
    useradd -r -u 999 -g mario mario
USER mario
RUN cd kippo && cp kippo_copy.cfg kippo.cfg && virtualenv env && . ./env/bin/activate && \
    pip install twisted==15.1.0 pyasn1 pycrypto && ls . && ./start.sh

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

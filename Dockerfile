FROM debian:buster
VOLUME /tmp
COPY . /kippo
RUN chmod 777 -R /kippo
RUN apt update
RUN apt -y install build-essential
RUN apt -y install python-dev 
RUN apt -y install libmariadb-dev 
RUN apt -y install python-virtualenv 
RUN apt -y install python-pip

RUN groupadd -g 999 mario && \
    useradd -r -u 999 -g mario mario
USER mario
RUN cd kippo && cp kippo_copy.cfg kippo.cfg && virtualenv env && . ./env/bin/activate && \
    pip install twisted==15.1.0 pyasn1 pycrypto && ls . && ./start.sh

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

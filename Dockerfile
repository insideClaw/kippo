FROM debian:buster
COPY . /kippo
RUN chmod 777 -R /kippo
RUN cd kippo && cp kippo_copy.cfg kippo.cfg

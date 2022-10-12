FROM ubuntu:22.04
COPY . ./installer
WORKDIR ./installer
RUN ./pre-install.sh
RUN /usr/bin/python3.10 /installer/modoboa-installer/run.py --force --debug localhost 
RUN ./post-install.sh
CMD /installer/start.sh

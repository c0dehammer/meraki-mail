FROM ubuntu:20.04
COPY . ./installer
WORKDIR ./installer
RUN rm -rf ./modoboa-installer 
# RUN ./pre-install.sh
# RUN /usr/bin/python3 /installer/modoboa-installer/run.py --force --debug localhost 
# RUN ./post-install.sh
CMD /installer/start.sh

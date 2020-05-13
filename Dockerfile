FROM ansible/ansible:ubuntu1604

# install ansible
RUN apt-get update  && \
    apt-get install -y software-properties-common  && \
    apt-add-repository ppa:ansible/ansible  && \
    apt-get update  && \
    echo Y | apt-get install -y ansible

RUN apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
       jq \
       git \
       iputils-ping \
       libcurl3 \
       libicu55 \
       libunwind8 \
       netcat \
       sshpass \
       openssh-client \
       unzip \
       wget

RUN pip install --upgrade pip

# install Azure, aws, gce, CloudStack dependencies
RUN pip install ansible[azure] \
    boto \
    apache-libcloud \
    pyrax \
    cs

# clean
RUN apt-get clean

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]

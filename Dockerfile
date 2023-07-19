FROM ubuntu:22.04

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY ./aliyun.sourcelist /etc/apt/sources.list

WORKDIR /home/workspace

COPY ./ /home/workspace/clumsy-bird

RUN apt-get update \
    && apt-get install -y wget \
    && wget https://nodejs.org/download/release/v17.9.1/node-v17.9.1-linux-x64.tar.gz  \
    && mkdir /home/workspace/node && tar -xvzf node-v17.9.1-linux-x64.tar.gz -C /home/workspace \
    && rm node-v17.9.1-linux-x64.tar.gz

WORKDIR /home/workspace/clumsy-bird
ENV PATH /home/workspace/node-v17.9.1-linux-x64/bin:$PATH

RUN npm install -g grunt-cli \
    && npm install

ENTRYPOINT ["grunt", "connect"]
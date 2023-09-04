FROM python:latest

LABEL maintainer="OmniDB team"

ARG OMNIDB_VERSION=3.0.3--dockerfix-b

SHELL ["/bin/bash", "-c"]

USER root

RUN addgroup --system omnidb
RUN adduser --system omnidb --ingroup omnidb
RUN apt-get clean
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libsasl2-dev

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libldap2-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libssl-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends vim



USER omnidb:omnidb
ENV HOME /home/omnidb
WORKDIR ${HOME}


RUN wget https://github.com/joe-leonard/OmniDB/archive/${OMNIDB_VERSION}.tar.gz \
    && tar -xvzf ${OMNIDB_VERSION}.tar.gz \
    && mv OmniDB-${OMNIDB_VERSION} OmniDB

# 修改requirements.txt文件来指定Django的版本
RUN sed -i 's/Django.*/Django==3.2/' ${HOME}/OmniDB/requirements.txt

WORKDIR ${HOME}/OmniDB

RUN pip install -r requirements.txt

WORKDIR ${HOME}/OmniDB/OmniDB

RUN sed -i "s/LISTENING_ADDRESS    = '127.0.0.1'/LISTENING_ADDRESS    = '0.0.0.0'/g" config.py \
    && python omnidb-server.py --init \


EXPOSE 8000

CMD python omnidb-server.py

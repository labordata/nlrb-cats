FROM python:3.8-slim-buster

LABEL maintainer "Forest Gregg <fgregg@datamade.us>"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     make unzip \
  && apt-get clean \

RUN mkdir /app
WORKDIR /app
COPY . /app

RUN pip install -r requirements.txt


ENTRYPOINT ["make"]
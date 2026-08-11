FROM mongo:6

WORKDIR /action

RUN apt-get update && apt-get upgrade -y && apt-get install zip -y && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/action/entrypoint.sh"]

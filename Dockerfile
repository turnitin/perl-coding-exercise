FROM       debian:stable-slim
RUN        mkdir /app
WORKDIR    /app
ADD        cpanfile /app/
RUN        apt-get update
RUN        apt-get install -y make gcc cpanminus
RUN        cpanm --installdeps .
ADD        . /app

ENTRYPOINT [ "perl", "test.pl" ]

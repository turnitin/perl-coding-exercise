FROM perl:5.41.2

COPY app /usr/src/myapp
WORKDIR /usr/src/myapp

RUN cpanm --installdeps .

CMD [ "perl", "app.pl" ]

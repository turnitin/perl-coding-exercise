FROM perl:5.40.0

COPY app /usr/src/myapp
WORKDIR /usr/src/myapp

RUN cpanm --installdeps .

CMD [ "perl", "app.pl" ]

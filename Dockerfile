FROM perl:5.28

COPY app /usr/src/myapp
WORKDIR /usr/src/myapp

RUN cpanm --installdeps .

CMD [ "perl", "app.pl" ]

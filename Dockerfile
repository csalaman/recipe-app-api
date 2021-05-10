FROM python:3.7-alpine
MAINTAINER Carlos S.

# Run python unbuffered mode for docker containers (avoids complications)
ENV PYTHONUNBUFFERED 1

# Dependencies
COPY ./requirements.txt /requirements.txt
# Use alpine package manager; add postgres support to docker (security stuff) Mininal docker footprint without extra depend
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Create directory, set as working directory for project and copy files to Docker image
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create user to run Docker & switch user (for security purposes, otherwise will use root and vurnable to attacks)
RUN adduser -D user
USER user




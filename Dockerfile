FROM python:3.7-alpine
MAINTAINER Carlos S.

# Run python unbuffered mode for docker containers (avoids complications)
ENV PYTHONUNBUFFERED 1

# Dependencies
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Create directory, set as working directory for project and copy files to Docker image
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create user to run Docker & switch user (for security purposes, otherwise will use root and vurnable to attacks)
RUN adduser -D user
USER user




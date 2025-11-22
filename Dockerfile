FROM alpine:latest

# install the basics
RUN apk update && apk add git openssh-client python3 py3-pip bash

# Set the working directory in the container
WORKDIR /app
COPY "./app.py" .


# Clone the repository
RUN git clone https://github.com/vitiko98/qobuz-dl.git

# Switch to subdirectory
WORKDIR ./qobuz-dl

# Setup venv
RUN python3 -m venv .

# Install qobuz-dl requirements into the venv
RUN source bin/activate && pip install -r requirements.txt

# Copy and apply the patch the endless loop app
RUN mkdir patch
COPY patch/cli.py.patch patch/
RUN git apply patch/cli.py.patch

# Delete the patch
RUN rm -rf patch

# Volume mounts
VOLUME /appdata /download

# Defaults for needed environment variables
ENV QOBUZ_DL_UID=99
ENV QOBUZ_DL_GID=100


# Add qobuz-dl shorthand to /root/.bashrc
RUN echo -e "qobuz-dl() {\n\tcd /app/qobuz-dl\n\tsource bin/activate\n\tpython -W ignore -m qobuz_dl.cli dl \$@\n\tchown -R $QOBUZ_DL_UID:$QOBUZ_DL_GID /download/*\n\tchmod -R 777 /download/*\n\tdeactivate\n}" >> /root/.bashrc

# Endless loop
CMD ["python", "../app.py"]

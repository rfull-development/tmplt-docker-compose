# Copyright (c) 2023 RFull Development
# This source code is managed under the MIT license. See LICENSE in the project root.
FROM ubuntu:latest

ARG RUNNER_USER
ARG RUNNER_DOWNLOAD_URL
ARG RUNNER_FILE
ARG DOCKER_GID

RUN apt update && \
    apt install -y sudo curl
RUN echo "${RUNNER_USER} ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/github

# Install GitHub Actions Runner
RUN useradd -m ${RUNNER_USER}
USER ${RUNNER_USER}
WORKDIR /home/${RUNNER_USER}
RUN curl -o ${RUNNER_FILE} -L ${RUNNER_DOWNLOAD_URL} && \
    mkdir ./actions-runner && \
    tar xzf ${RUNNER_FILE} -C ./actions-runner && \
    rm -f ${RUNNER_FILE}
WORKDIR /home/${RUNNER_USER}/actions-runner
RUN sudo ./bin/installdependencies.sh

# (Optional) Install Docker client if DOCKER_GID is defined
WORKDIR /home/${RUNNER_USER}
COPY --chown=${RUNNER_USER}:${RUNNER_USER} ./install_docker.sh /home/${RUNNER_USER}/
RUN chmod +x ./install_docker.sh &&  \
    ./install_docker.sh && \
    rm install_docker.sh

# Clean up
RUN sudo apt clean && \
    sudo rm -rf /var/lib/apt/lists/*
WORKDIR /home/${RUNNER_USER}/actions-runner

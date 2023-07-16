# Copyright (c) 2023 RFull Development
# This source code is managed under the MIT license. See LICENSE in the project root.
FROM ubuntu:latest

ARG AGENT_USER
ARG AGENT_DOWNLOAD_URL
ARG AGENT_FILE
ARG DOCKER_GID

RUN apt update && \
    apt install -y sudo curl wget git dotnet-sdk-7.0
RUN echo "${AGENT_USER} ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/${AGENT_USER}

# Adding agent user
RUN useradd -m ${AGENT_USER}
USER ${AGENT_USER}

# Install OpenSSL
WORKDIR /home/${AGENT_USER}
COPY --chown=${AGENT_USER}:${AGENT_USER} ./install_openssl.sh .
RUN chmod +x install_openssl.sh && \
    ./install_openssl.sh && \
    rm install_openssl.sh

# Install Azure DevOps Pipelines Agent
WORKDIR /home/${AGENT_USER}
RUN curl -o ${AGENT_FILE} -L ${AGENT_DOWNLOAD_URL} && \
    mkdir ./pipelines-agent && \
    tar xzf ${AGENT_FILE} -C ./pipelines-agent && \
    rm -f ${AGENT_FILE}
WORKDIR /home/${AGENT_USER}/pipelines-agent

# (Optional) Install Docker client if DOCKER_GID is defined
WORKDIR /home/${AGENT_USER}
COPY --chown=${AGENT_USER}:${AGENT_USER} ./install_docker.sh .
RUN chmod +x ./install_docker.sh &&  \
    ./install_docker.sh && \
    rm install_docker.sh

# Clean up
RUN sudo apt clean && \
    sudo rm -rf /var/lib/apt/lists/*

WORKDIR /home/${AGENT_USER}/pipelines-agent
#ENTRYPOINT ["bash", "./run.sh"]

ARG DOTNETCORE_VERSION=3.1
FROM mcr.microsoft.com/dotnet/core/sdk:${DOTNETCORE_VERSION}

# This Dockerfile adds a non-root 'vscode' user with sudo access. However, for Linux,
# this user's GID/UID must match your local user UID/GID to avoid permission issues
# with bind mounts. Update USER_UID / USER_GID if yours is not 1000. See
# https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# [Optional] Install the Azure CLI
ARG INSTALL_AZURE_CLI="false"

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Setup workspace
COPY . /app
WORKDIR /app

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    #
    # Verify git, process tools, lsb-release (common in install instructions for CLIs) installed
    && apt-get -y install git iproute2 procps apt-transport-https gnupg2 curl lsb-release \
    #
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # Install the postgresql client
    && apt-get -y install postgresql-client-11 \
    # [Optional] Add sudo support for the non-root user
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    #
    # [Optional] Install the Azure CLI
    && if [ "$INSTALL_AZURE_CLI" = "true" ]; then \
        echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list \
        && curl -sL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - 2>/dev/null \
        && apt-get update \
        && apt-get install -y azure-cli; \
    fi \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Expose the project port
EXPOSE 5000

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=
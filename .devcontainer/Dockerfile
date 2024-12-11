# Use a base image with Docker-in-Docker support
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install essential tools and dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  vim \
  build-essential \
  software-properties-common \
  python3-pip \
  python3-venv \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Node.js (LTS) and Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
  apt-get install -y nodejs && \
  npm install -g yarn

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  apt-get update && apt-get install -y docker-ce-cli

# Add a non-root user (to match the remoteUser setting in devcontainer.json)
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME && \
  useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
  usermod -aG sudo $USERNAME && \
  echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
  chmod 0440 /etc/sudoers.d/$USERNAME

# Set the working directory
WORKDIR /workspace

# Set up Python environment
USER $USERNAME
RUN pip install --upgrade pip setuptools

# Final cleanup
USER root
RUN apt-get autoremove -y && apt-get clean -y

# Switch back to non-root user for better security
USER $USERNAME

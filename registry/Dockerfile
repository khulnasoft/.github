# Use an official base image (e.g., Ubuntu or Alpine)
FROM ubuntu:20.04

# Set environment variables for non-interactive installs
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages and dependencies
RUN apt-get update && apt-get install -y \
  curl \
  wget \
  git \
  vim \
  build-essential \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Set a working directory
WORKDIR /app

# Copy the application source code into the container
# Adjust this path as needed
COPY . /app

# Install any dependencies (e.g., Node.js, Python, etc.)
# For example, if your app uses Node.js, you can add:
# RUN curl -sL https://deb.nodesource.com/setup_14.x | bash && \
#     apt-get install -y nodejs

# Install application-specific dependencies (for example, npm packages)
# RUN npm install

# Expose ports (adjust based on your app's requirements)
EXPOSE 8080

# Set the default command to run your app
# Adjust this to your app's entry point, for example:
CMD ["./start.sh"]

# Alternatively, if your app runs with a specific service, for example, Node.js:
# CMD ["node", "app.js"]

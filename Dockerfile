# Set the Docker image you want to base your image off.
FROM elixir:1.6.6

ENV MIX_ENV prod
ENV PORT 4000

# Exposes this port from the docker container to the host machine
EXPOSE 4000

# Add nodejs
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - && apt-get install -y nodejs

# Install other stable dependencies that don't change often
RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y postgresql-client

# Add OS-level dependencies here


# Make App folder
RUN mkdir /app
WORKDIR /app

# Add the files to the image
ADD . .

# Cache Elixir deps
RUN mix local.rebar --force
RUN mix local.hex --force
RUN mix deps.get --only prod
RUN mix deps.compile

WORKDIR assets
# Cache Node deps
RUN npm i

# Compile JavaScript
RUN npm run deploy

WORKDIR ..

# Compile app
RUN mix compile
RUN mix phx.digest

# The command to run when this image starts up
CMD mix do deps.loadpaths --no-deps-check, phx.server

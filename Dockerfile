FROM node:18.7.0-alpine3.15
RUN apk add bash && \
    npm install -g wrangler

WORKDIR /src
ENV VERSION="1.0.0"
ENTRYPOINT ["/bin/bash"]

FROM node:16-alpine AS build
LABEL authors="Peter Edwards"

# Create app directory
WORKDIR /app

# COPY . /app/

# update dependencies and install git
RUN apk update && \
    apk add python3 && \
    apk add build-base && \
	apk add git && \
	apk add sed && \
	git clone https://github.com/sweetlilmre/PegaScape.git . && \
	git checkout package_updates && \
	sed -i 's/\(^.*"daemon":\)\(.*,\)/\1 true,/' config.json && \
    npm install

FROM node:16-alpine AS release

# RUN npm install pm2 -g

COPY --from=build /app /app

WORKDIR /app

EXPOSE 80

ENTRYPOINT [ "node", "start.js" ]

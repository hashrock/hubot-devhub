# Hubot DevHub Adapter

## Description

This is an [DevHub](https://github.com/volpe28v/DevHub) adapter for [Hubot](https://github.com/github/hubot).

## Installation and Setup

NOTICE: To use this adapter, you need Hubot(>= v2.3.0). This adapter only works when you select Socky as your WebSocket server.

* Run `npm install hubot-devhub --save` in the extracted `Hubot` directory to add the `hubot-devhub` adapter to your dependencies.
* Install dependencies with `npm install`
* Set your environment variables like: (Windows Users substitute `set` for `export`)
      * export HUBOT_DEVHUB_NAME="hu bot"
      * export HUBOT_DEVHUB_URL="http://localhost:3000"
      * Run hubot with `bin/hubot -a devhub`

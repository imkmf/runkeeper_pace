pace tracker for runkeeper
---

this is kind of a shitshow on the ruby-side, but the idea is that we talk to the runkeeper api to get our pace for our runs on the backend, and plot it using [c3.js](http://c3js.org/) on the frontend.

setup:

authorize an app using the [runkeeper api](http://runkeeper.com/developer/healthgraph/). get your client id/secret, then get an auth key - if you don't know how to do that, use the [run_keeper gem instructions](https://github.com/coop/run_keeper). set your `.env` with appropriate keys - see `.env.example` for an idea of how that all works.

this is pretty hacked together for my own use - it's a good motiviation boost to see progress (hopefully) :)

PRs accepted <3

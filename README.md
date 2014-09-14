docker-nodejs
=============

Generic Node.js image

Node.js base image
==================

This is a simple node.js image that is intended to be used as the base image for creating application specific images.

    Create a subdirectory called nodeapp and copy your node application code into it.
    When you build your image based on this image the contents of the nodeapp folder are copied into the new image and npm install is executed.
    When a container is run from your new images, node app.js is executed.

Folder structure for new images build:

/Dockerfile/nodeapp/<your app files>

Example dockerfile:

FROM educateme/nodejs
MAINTAINER Your name
ENV LAST_MODIFIED "2014-09-06 You"

VOLUME /nodeapp/optional-folder-you-want-as-a-volume

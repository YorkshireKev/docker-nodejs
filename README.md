Node.js Docker Image
====================

This is a simple node.js image that is intended to be used run a single node.js application, named app.js, from a mapped host volume folder.

The idea is that you can update your node.js app and simply restart the docker container to load the new version.

You don't need to build this base image yourself, you can pull a pre-built image from docker hub by typing: docker pull yorkshirekev/nodejs

If you want to have the container pull any dependant npm modules (rather than package them with your app), then you can simply run the image and override the node command to run npm install like so:
`docker run -it --rm --user 1000:1000 -v /path/to/your/node/app/folder:/nodeapp yorkshirekev/nodejs npm install`

Run your app:
`docker run -d --user 1000:1000 -v /path/to/your/node/app/folder:/nodeapp -p 8080:8080 --name nodeapp yorkshirekev/nodejs`

Two ports are exposed in the image; 8080 and 8443. These are intended to be used for http and https respectively (i.e. map them to 80 and 443 if exposing to the internet).

The --user parameter is used to ensure that the docker container can access the files mounted from your host folder. Set these to the user:group as used on your docker host. The UID/GID numbers have to be used rather than the names because the names won't match anything inside the container. 1000:1000 is user:group. Use the `id` command to determine your UID and GID numbers.



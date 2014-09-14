FROM ubuntu:14.04
MAINTAINER Kevin Ellis

ENV LAST_MODIFIED "2014-09-05 K Ellis"

# Install the tools needed to compile node.js from source
RUN apt-get update
RUN apt-get install wget build-essential python libssl-dev -y

# Download the node.js sourcecode from nodejs.org
WORKDIR /tmp
RUN wget http://nodejs.org/dist/v0.10.31/node-v0.10.31.tar.gz
RUN tar -xvf node-v0.10.31.tar.gz

# Compile and install node.js
WORKDIR /tmp/node-v0.10.31
RUN ./configure
RUN make
RUN make install

# Remove the temporary build files
WORKDIR /
RUN rm /tmp/node-v0.10.31.tar.gz ; rm -rf /tmp/node-v0.10.31

# Create a nodejs specific user and application directory
RUN groupadd nodejs -g 6633
RUN useradd nodejs -u 6633 -g nodejs
RUN mkdir /nodeapp
WORKDIR /nodeapp

# Copy in  the default 'instructions' node app
ADD app.js /nodeapp/app.js

# When this image is used as the base for an appliction specific image, so
# icopy the target app into the image and run npm install.
ONBUILD USER root
ONBUILD ADD nodeapp/ /nodeapp
ONBUILD RUN /usr/local/bin/npm install

#Expose ports. 8080 is intednded for http and 8443 is intended for https
EXPOSE 8080
EXPOSE 8443

USER nodejs
CMD ["/usr/local/bin/node", "app.js"]


# Docker configuration for Coursemology 2

1. Clone Coursemology2 repo to the host machine

    $ git clone https://github.com/Coursemology/coursemology2

2. Clone the Dockerfile and build the image

    $ git clone https://github.com/evansb/coursemology-docker
    $ cd coursemology-docker
    $ docker build -t coursemology2 .

3. Environment is ready, you can start building coursemology by mounting the
   repository

    $ cd ../coursemology2
    $ docker run -i -t -v $(pwd):/repo coursemology2 /bin/bash

    Inside the container
    # cd repo
    # bundle install
    # rake db:setup
    And so on, i.e follow Coursemology2 README

4. Make sure you commit the image after bundle install to update all the static files inside
   the container.

    $ docker ps
        CONTAINER ID        IMAGE
        511a5cac00cb        coursemology2:latest
    $ docker commit 511a5cac00cb coursemology2

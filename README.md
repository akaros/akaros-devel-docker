Docker for Akaros Development
=============================
This project provides a docker environment for development on akaros.  It comes
preinstalled with the akaros cross compiler, checked-out versions of the akaros
and go-akaros repos, and a number of useful tools for working with akaros in
general (vim, emacs, qemu-kvm, etc.).

When ran, the docker container will mount a home directory stored on your
workstation, so any work you do inside the container will persist across
invocations (so long as these changes are isolated to your home directory). All
you have to do is set up docker on your workstation and the scripts contained
in this repo take care of the rest.

These scripts basically launch a detached docker container with hostname
`akaros-devel` that you can ssh into and interact with as if it was a remote
workstation.

Installation notes on installing docker can be found at the bottom of this
document. The systems listed are the one's we've tested and have verified to
work for this project. If you can verify that it works on other setups, please
let us know, and we'll add installation notes as appropriate.

Happy coding!

Quickstart
----------
To get started, simply run the following. The output of the `./run` command
will give you instructions on attaching to your new docker container:
```
git clone https://github.com/klueska/akaros-devel-docker.git
cd akaros-devel-docker
./bootstrap
./run
```

Inside your docker container, the location of your akaros repos is:
```
~/projects/akaros
```

The location of your go-akaros repos is:
```
~/projects/go-akaros
```

More information on running akaros and go on akaros can be found in the
following locations:
```
~/projects/akaros/GETTING_STARTED
~/projects/go-akaros/misc/akaros/README
```

Have at it!

Notes on Installing Docker
--------------------------
### For ubuntu 14.04
Add the docker.io repository to your aptitude source list and install the
lxc-docker package.
```
wget -qO- https://get.docker.io/gpg | sudo apt-key add -
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get install lxc-docker
```

In order to use docker without `sudo` you will also have to create a `docker`
group, add yourself to it, and restart the docker service.  After adding
yourself to the `docker` group, don't forget to run `newgrp docker` (or logout
and back in) to make the changes take effect.
```
sudo groupadd docker
sudo usermod -G docker -a <username>
sudo service docker restart
newgrp docker
```

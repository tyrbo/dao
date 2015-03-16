# Dao

Dao is a tool meant to be used with Docker and Docker Compose. Dao scans running compose services and provides a proxying service on easy to remember hosts. Instead of http://192.168.100.100:49157, your web services will be available at friendlier URLs, like http://mproject.dao:3000.

_Dao is a work in progress. Some things might not work properly or as expected._

# Getting Started

Installing Dao is easy.

In a terminal, execute `curl https://raw.githubusercontent.com/tyrbo/dao/master/scripts/install | bash`.

This installs the following:

* Homebrew
* Brew Cask
* VirtualBox
* Git
* Docker
* Docker Compose
* Docker Machine

The script attempts to only install what is necessary.

It then clones down this repo, uses bundler to install the required gems, and sets up a few symlinks for ease of use. **It is expected that Ruby is already installed.**

# Starting a Virtual Machine

After installation, the first step is to create a virtual machine. This is accomplished with a single command.

`dao create`

# Setting Environment Variables

Once the virtual machine has been created, or if it's been stopped and started at any point, it is ideal to set (or reset) your environment variables. Again, this can be accomplished with a single command.

**Bash:** `$(dao env)`

**Fish:** `dao env | source -`

These commands should be ran in any terminal window you expect to interact with Docker, and must also be ran before starting daod.

# Start daod

Once the machine is running, and you've set your environment variables, it's time to start daod.
daod is responsible for scanning running containers, and setting up the magical hosts mentioned above.
daod will automatically exit if the virtual machine stops running, so you'll need to start it again if that occurs.

Again, this is accomplished with a single command. Don't worry if you don't see any output, that's completely normal.

`daod`

# Docker Compose and Naming Conventions

There is plenty of information available on Docker Compose. The official docs are available here: https://docs.docker.com/compose/.

Docker Compose names containers using the base folder of your project. If your project resides in `/Users/Dao/MyProject`, then Docker Compose would use names similar to `myproject_servicename_1`.

Dao uses these names to determine the host your project should be available at. In the above case, http://myproject.dao would be the 
end result.

# Ports

Docker Compose gives you the option specify both a host port and container port in the ports section of a `docker-compose.yml` file.

It is highly recommended to only set the container port, and to allow the host port to be randomized. Since any number of web applications can be supported simultaneously through dao, this should minimize or eliminate port conflicts.

Your service will always be available on the container port. If your container port is `3000`, even though the randomized port may be `49175`, the proxy will listen for requests at http://myproject.dao:3000.

# Todo

* Starting daod manually is a pain. Ideally, this will be automatically started after `dao create` or `dao start`, but the environment variables are a bit of a pain.
* Non-web ports will be listened on. If your `docker-compose.yml` file runs MySQL, and publicly exposes port 3306, a web proxy will be running on that port. This is unnecessary, and dao will soon™ have a better way of handling this problem through explicitly declaring what services to listen for, on a per-project basis.

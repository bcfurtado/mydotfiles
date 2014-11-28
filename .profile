# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Java Configuration
JAVA_HOME="/usr/lib/jvm/java-7-oracle"
PATH="$JAVA_HOME/bin:$PATH"

# Maven Configuration
M2_HOME="/home/bruno/Applications/apache-maven-3.0.5" 
M2="$M2_HOME/bin"
PATH="$M2:$PATH"

#check if still will be necessaring when running sonar with maven
SONAR_RUNNER_HOME="/home/bruno/Applications/sonarqube-4.5.1"
PATH="$SONAR_RUNNER_HOME/bin/linux-x86-64:$PATH"

# MongoDB Configuration
MONGO_HOME="/home/bruno/Applications/mongodb-linux-x86_64-2.6.5"
PATH="$MONGO_HOME/bin:$PATH"

# Redis.io Configuration
REDIS_HOME="/home/bruno/Applications/redis-2.8.5"
PATH="$REDIS_HOME/src:$PATH"

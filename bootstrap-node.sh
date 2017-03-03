#!/bin/sh

# Run on VM to bootstrap Puppet Agent nodes

if ps aux | grep "puppet agent" | grep -v grep 2> /dev/null
then
    echo "Puppet Agent is already installed. Moving on..."
    sudo puppet agent -t
    exit 0
else
    sudo apt-get update -yq
    sudo apt-get upgrade -yq
    sudo apt-get install -yq puppet
fi

if cat /etc/crontab | grep puppet 2> /dev/null
then
    echo "Puppet Agent is already configured. Exiting..."
    exit 0
else
# Add a cron for puppet to run every 30 mins.
    sudo puppet resource cron puppet-agent ensure=present user=root minute=30 \
        command='/usr/bin/puppet agent --onetime --no-daemonize --splay'

    sudo puppet resource service puppet ensure=running enable=true

    # Configure /etc/hosts file
    echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.5    puppet.example.com  puppet" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.10   node01.example.com  puppet" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.20   web01.example.com  web01" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.30   web02.example.com  web02" | sudo tee --append /etc/hosts 2> /dev/null


    # Add agent section to /etc/puppet/puppet.conf
    echo "" && echo "[agent]\nserver=puppet" | sudo tee --append /etc/puppet/puppet.conf 2> /dev/null

    sudo puppet agent --enable
fi
# Give puppet time to auto sign the certificate and kick off a run.
    sudo puppet agent -t --waitforcert 15
# added the code below as puppet runs produced a non-zero exit. Adding this for now keeps the vagrant run on track while I figure out the puppet issue and vagrant.
    exit 0
#!/bin/sh

# Run on VM to bootstrap Puppet Agent nodes

    echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.5    puppet.example.com  puppet" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.10   dc1pweb01.example.com  dc1pweb01" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.20   dc1dapp01.example.com  dc1dapp01" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.30   dc2pweb01.example.com  dc2pweb01" | sudo tee --append /etc/hosts 2> /dev/null

     sudo wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
     sudo dpkg -i puppetlabs-release-pc1-xenial.deb
     sudo apt-get update
     sudo apt-get install puppet-agent
     sudo systemctl start puppet
     sudo systemctl enable puppet
     sudo apt-get install git -yq
     exit 0


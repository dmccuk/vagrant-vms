Vagrant-Devops Udemy course code
=========================
All of the Vagrant code was developed on a windows 10 laptop. Local access to the website we'll create as part of this exercise will be via entering http://127.0.0.1 into your preferred web browser.

Pre-requisites
--------
1. Puppet modules must be in place. See step 4 on setup below.
2. I set my own puppet master to autosign = true.

Setup
--------
 1. Install Vagrant and Github.
 2. Clone this repo: https://github.com/dmccuk/vagrant-devops.git - This will create a vagrant-devops directory full of the code required for this piece of work.
 3. before you can run it, there are some dependancies. My code requires some puppet modules be setup and available.
 4. Clone this repo onto your puppet master: https://github.com/dmccuk/modules.git **Clone it to a safe place and move the modules into where you normally put them (somewhere like /etc/puppet/modules)**. It will create a directory called "modules" with the puppet modules required within.
 5. I've included a site.pp just as a reference but you probably won't need it.
 6. Now you can run "vagrant up" and see what happens.
 7. Hopefully there won't be any errors when it starts to run. I'm happy to help if there is an issue.
 8. Once the code has run, you should be able to visit the webpage and refresh. You should see each servername being load balanced appear on the screen in turn (with every refresh - F5). No login to the vagrant VM's should be required.
 
Assumptions
--------
 * I have assumed your puppet master is called "puppet".
 * If you don't automatically sign puppet certificate requests to your master, you will need to "puppet cert sign "node_name" before puppet will work. but the request will need to be made first. I've setup puppet to run every 30 mins on the vagrant VMs (and also set --waitforcert to 15 seconds) so once signed, puppet on each node will make the updates within that time.

If you have any questions, please raise an Issue and I will respond as soon as possible. Alternatively, if you are a student on the Udemy course "DevOps for Operations", then please contct me through Udemy.



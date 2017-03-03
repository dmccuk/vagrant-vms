Devops Test
=========================
This has been a great exercise to do as was quite a bit of fun. Just for you info, I took a few months off work to travel the world with my Wife and daughters (currently in Thailand). I'm back in April so I've been making contact with UK IT agencies. 

All of the Vagrant code was developed on a windows 10 laptop. I had no access to "vagrant ssh" and had to puttygen the key provided into a .ppk file. Then i could us puppet to login to the vagrant VMs. When i access the website, I need to use http://127.0.0.1 due to the way vagrant work on my PC. If i was on a Linux PC (Mine is back in the UK) i would access the website from the Server IP address or name.

Pre-requisites
--------
1. My Puppet modules must be in place.
2. I set my onw puppet master to autosign = true. For production I'd setup and autosign.conf with the company domain. If you don't have autosign set then you will need to manually sign the certificate.

Setup
--------
 1. Install Vagrant. I had to set this all up on Windows laptop as my linux laptop is back in the UK.
23. clone this repo: https://github.com/dmccuk/vagrant-devops.git - This will create a vagrant-devops directory full of the code required for this piece of work.
 3. before you can run it, there are some dependancies. My code requires some puppet modules be setup and available.
 4. Clone this repo onto your puppet master: https://github.com/dmccuk/modules.git **Clone it to a safe place and move the modules into where you normally put them (somewhere like /etc/puppet/modules)**. It will create a directory called "modules" with the puppet modules required within.
 5. I've included a site.pp just as a reference but you probably won't need it.
 6. Now you can run "vagrant up" and see what happens.
 7. Hopefully there won't be any errors when it starts to run. I'm happy to help if there is an issue.
 
Assumptions
--------
 * I have assumed your puppet master is called "puppet".
 * If you don't automatically sign puppet certificate requests to your master, you will need to "puppet cert sign "node_name" before puppet will work. but the request will need to be made first. I've setup puppet to run every 30 mins on the vagrant VMs (and also set --waitforcert to 15 seconds) so once signed, puppet on each node will make the updates within that time.

My Thoughts
---------
 * [ As part of this I also setup a puppet master in Vagrant (but don't supply the code here). That required some manual setup which you probably already know about. ]
 * [ I didn't carry on with the bonus points simply because I'm travelling round the world. My wife is already annoyed with me for doing this and I didn't want to make life worst in the short term for myself. ]
 * [ I decided to put most of the code into the "webapp" module. I would usually create a role for a node along with a profile and the profile would be made up of individual modules to do each job. This method does have the benefit of keeping everything together but doesn't scale so I wouldn't recommend it normally. ]
 * [ for the idempotent bit I used the notify option in puppet. If a file changes then the notify options will trigger the service specified to be restarted. If it doesn't change, it doesn't make any changes to the server or app. ]
 * [ For testing the web servers are serving my app, I didn't setup a test, instead if you go to http://127.0.0.1 (on Windows) I added the name of each specific node from facter so it's displayed on the page. As you refresh (F5) you will see the node name flip between one then the other. In the real world I'm experienced with serverspec and would setup a specific test for the open port, web page contents, etc. ]
 
Future Enhancements
--------- 
* With this setup (including a vagrant puppet master, you can setup Jenkins to bring up the whole environment and run a test of your puppet/application code at regular intervals or on a git commit. The vagrant environment would be created, tested, then destroyed in minutes with the code verified.
* The whole thing can be tested (with something like serverspec) and a report produced. Failures go back to the dev who committed the updated that failed. Once complete the whole environment can be destroyed until the next git commit.

I've enjoyed this piece of work while on my travels. 

Future
Thanks

Dennis

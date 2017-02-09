#GoCD Demo

A simple setup to bring up a GoCD server with 2 agents. 
This includes a config file which has a typical value stream configured which would help explain some of the concepts in GoCD.
Some users with varied roles and permissions are setup, check `<roles>` section in the config file for the exact details.

Just run a `vagrant up` from the checked out folder. This will bring up a VM with the server and agents running. Once the machine is up, you will be able to access the server from your browser using : http://localhost:8153

There are a few repositories setup under `/home/vagrant/repos` which are used by the pre-configured pipelines. You should be able to add new commits to them to trigger new builds in Go. 

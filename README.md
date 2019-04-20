# The "What did you InSpec" Workshop

The InSpec Workshop examples - presented by Gratien D'haese

If you have questions or remarks mail at gratien . dhaese @ gmail . com

## Pre-requisites
- Linux or Mac OS/X system
- vim editor or alike
- docker
- vagrant
- Oracle VirtualBox
- InSpec from Chef
- git (to clone this git repo: https://github.com/gdha/inspec-workshop)

## Start of docker mychefdf
- go to directory inspec-workshop/docker-chefdk
- run: `./build-chefdk`
- run: `./run-chefdk`
- (inside the container) run: `inspec exec /cookbooks/myaccount/test/integration/default/default_test.rb`

## In another Bash shell windows (on your Linux or Mac)
- go to directory `inspec-workshop/cookbooks/myaccount/test/integration/default`
- run: `docker ps -a`
- run: `docker rename $(docker ps -q) inspec-demo`
- run: `docker ps -a`
- run: `inspec exec default_test.rb -t docker://$(docker ps -q)`

## Remediate the mychefdk container with chef cookbook myaccount
- (inside the container) run: `chef-client -z -o myaccount`
- (inside the container) run: `inspec exec /cookbook/myaccount/test/integration/default/default_test.rb`
- (on Mac) run: `inspec exec default_test.rb -t docker://$(docker ps -q)`

## Demonstrate the dockerprofile
- go to directory `inspec-workshop/`
- (on Mac) run: `inspec exec dockerprofile/controls/docker.rb`
- run: `docker rename $(docker ps -q) inspec-demo`
- (on Mac) run: `inspec exec dockerprofile/controls/docker.rb`
- (on Mac) run: `inspec exec dockerprofile`

## Demonstrate InSpec Shell
- (on Mac) if container runs in detached mode run: `docker exec -it inspec-demo /bin/bash`
- (inside the container) run: `inspec shell`
- (inside the container) run: inspec> `help`
- (inside the container) run: inspec> `command('uname -s').stdout`
- (inside the container) run: inspec>
```
     describe file('/etc/gshadow') do
       it { should be_owned_by 'root' }  
     end 
```

## Demonstrate InSpec profile
- (inside the container) run: `inspec init profile newprofile`
- (inside the container) run: `inspec check newprofile`

## Demonstrate Vagrant with InSpec
- go to directory `inspec-workshop/vagrant-ubuntu18`
- (on Mac) run: `vagrant status`
- (on Mac) run: `vagrant up --provision`
- (on Mac) optional: `echo '192.168.33.10 client' >> /etc/hosts`
- (on Mac) run: `inspec exec -t ssh://client --password vagrant ../path-check/`
- (on Mac) run: `inspec exec -t ssh://client --password vagrant https://github.com/dev-sec/ssh-baseline`
```
     [expected output] Test Summary: 38 successful, 60 failures, 2 skipped
```
- (on Mac) run: `vagrant ssh`
- (inside vagrant): run: `cd /home/vagrant`
- (inside vagrant): run: `sudo ansible-playbook /vagrant/ansible-ssh-hardening.yml`
- (on Mac) run: `inspec exec -t ssh://client --password vagrant https://github.com/dev-sec/ssh-baseline`
```
     [expected output] Test Summary: 94 successful, 4 failures, 2 skipped
```
- (on Mac) run: `vagrant halt` (to stop the VM), or `vagrant destroy` (to stop&remove the VM)
 
## Demonstrate kitchen test together with InSpec
- go to directory `inspec-workshop/cookbooks/nginx_test`
- (on Mac) run: `cat recipes/default.rb`
- (on Mac) run: `kitchen converge`
- (on Mac) run: `kitchen verify`
```
    [expected output] Test Summary: 86 successful, 44 failures, 1 skipped
```
- (on Mac) run: `vi recipes/default.rb`

    uncomment line: # include_recipe 'os-hardening'

- (on Mac) run: `kitchen converge`
- (on Mac) run: `kitchen verify`
```
    [expected output] Test Summary: 129 successful, 1 failure, 1 skipped
```
- (on Mac) run: `kitchen destroy`

## LICENSE

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">What did you InSpec?</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://www.it3.be/" property="cc:attributionName" rel="cc:attributionURL">Gratien Dhaese</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

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
  (on Mac) run: `git clone https://github.com/gdha/inspec-workshop`
  *Note*: where-ever you see "(on Mac)" means on your local workstation, laptop (Unix alike preferred)
- (on Mac) run: `cd inspec-workshop`
- (on Mac) run: `export BASEDIR=$PWD`

## Start of docker mychefdf
- (on Mac) run: `cd $BASEDIR/docker-chefdk`
- (on Mac) run: `./build-chefdk`
- (on Mac) run: `./run-chefdk`
- (inside the container) run: `inspec exec /cookbooks/myaccount/test/integration/default/default_test.rb`

## In another Bash shell windows (on your Linux or Mac)
- (on Mac) run: `cd $BASEDIR/cookbooks/myaccount/test/integration/default`
- (on Mac) run: `inspec exec default_test.rb -t docker://$(docker ps -q)`

## Remediate the mychefdk container with chef cookbook myaccount
- (inside the container) run: `chef-client -z -o myaccount`
- (on Mac) run: `inspec exec default_test.rb -t docker://$(docker ps -q)`

## Demonstrate the dockerprofile
- (on Mac) run: `cd $BASEDIR`
- (on Mac) run: `inspec exec dockerprofile/controls/docker.rb`
- (on Mac) run: `docker rename $(docker ps -q) inspec-demo`
- (on Mac) run: `inspec exec dockerprofile/controls/docker.rb`
- (on Mac) run: `inspec exec dockerprofile`

## Demonstrate InSpec Shell (exercise for you)
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

## Demonstrate InSpec profile (exercise for you)
- (inside the container) run: `inspec init profile newprofile`
- (inside the container) run: `inspec check newprofile`
- (inside the container) run: `cd newprofile`
- browse and look at the different directories and files being created

## Launch Vagrant VM
- (on Mac) run: `cd $BASEDIR/vagrant-ubuntu18`
- (on Mac) run: `vagrant status`
- (on Mac) run: `vagrant up --provision`
- (on Mac) optional: `echo '192.168.33.10 client' >> /etc/hosts`

# Demonstrate the path-check InSpec profile (in different ways)
## Check on Mac itself via full path:
- (on Mac) run: `inspec exec $BASEDIR/path-check`
## Check on Mac itself via git repo:
- (on Mac) run: `inspec exec https://github.com/gdha/inspec-path-check`
## Check the docker container:
- (on Mac) run: `inspec exec -t docker://$(docker ps -q) path-check`
## Check the vagrant VM:
- (on Mac) run: `inspec exec -t ssh://client --password vagrant $BASEDIR/path-check`

# Demonstrate the ssh-baseline InSpec profile (on Vagrant VM)
- (on Mac) run: `inspec exec -t ssh://client --password vagrant https://github.com/dev-sec/ssh-baseline`
```
     [expected output] Test Summary: 38 successful, 59 failures, 3 skipped
```
- (on Mac) run: `vagrant ssh`
- (inside vagrant): run: `cd /home/vagrant` (optional)
- (inside vagrant): run: `sudo ansible-playbook /vagrant/ansible-ssh-hardening.yml`
- (inside vagrant): run: `exit`
- (on Mac) run: `inspec exec -t ssh://client --password vagrant https://github.com/dev-sec/ssh-baseline`
```
     [expected output] Test Summary: 94 successful, 3 failures, 3 skipped
```
- (on Mac) run: `vagrant halt` (to stop the VM), or `vagrant destroy` (to stop&remove the VM)
 
## Demonstrate kitchen test together with InSpec
- (on Mac) run: `cd $BASEDIR/cookbooks/nginx_test`
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

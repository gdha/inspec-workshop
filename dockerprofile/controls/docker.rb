title 'Docker inspec test example'

control 'docker-test-1' do
  impact 0.5
  desc 'inspec mychefdk container'
  
  describe docker_container('inspec-demo') do
    it { should exist }
    it { should be_running }
    its('id') { should_not eq '' }
    its('image') { should eq 'mychefdk' }
    its('ports') { should eq '' }
    its('command') { should eq '/bin/bash' }
  end
end

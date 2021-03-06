# # encoding: utf-8

# Inspec test for recipe myaccount::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root') do
    it { should exist }
  end

  describe user('gdha') do
    it { should exist }
    its('uid') { should eq 501 }
    its('group') { should eq 'users'}
    its('home') { should eq '/home/gdha' }
    its('shell') { should eq '/bin/bash' }
  end
end

# This is an example test, replace it with your own test.
describe port(80) do
  it { should_not be_listening }
end

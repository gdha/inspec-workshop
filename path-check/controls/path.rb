# encoding: utf-8
# copyright: 2018, The Authors

title 'DOT in PATH variable'

control 'path-1.0' do               # A unique ID for this control
  impact 1.0                        # The criticality, if this control fails.
  title 'DOT in PATH variable'
  desc 'An optional description...'
  describe os_env('PATH') do        # The actual test
    its('split') { should_not include('') }
    its('split') { should_not include('.') }
  end
end

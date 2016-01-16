#!/usr/bin/env ruby

require './git_clone'

require 'JSON'

# Main

file = File.new("#{ENV['HOME']}/.setup_environment/repos.json", 'r')
file_config = JSON.parse(file.read)

process_bundle(file_config)

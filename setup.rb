#!/usr/bin/env ruby

load_dir = File.dirname(
  File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
)

require "#{load_dir}/git_clone"

require 'JSON'

# Main

file = File.new("#{ENV['HOME']}/.setup_environment/repos.json", 'r')
file_config = JSON.parse(file.read)

process_bundle(file_config)

#!/usr/bin/env ruby

require 'fileutils'
require 'git'
require 'JSON'

@where = nil

def process_bundle(b, dir_ = '', indent = 0)
  b.each do |repo|
    bundle = repo['bundle']
    if bundle
      print "\t" * indent, "Synchronising bundle:\t", repo['name']
      puts
      if repo['dir']
        dir = repo['dir']
      else
        dir = dir_
      end
      dir += '/' if dir[-1] != '/'
      process_bundle(bundle, dir, indent + 1)
    else
      remote = repo['remote']

      dir = dir_
      dir += @where + '/' if @where
      dir += repo['dir']
      dir = dir.split('/')

      dir.delete('')
      dir.delete('.')

      item = dir[-1]
      dir = dir[0..dir.length - 2].join('/')

      clone_repo(remote, item, dir, indent)
    end
  end
end

def clone_repo(remote, item, dir, indent = 0)
  print "\t" * indent, Git.clone(remote, item, path: dir)
  puts
end

# Main

file = File.new('repos.json', 'r')
json_notparsed = file.read
file_config = JSON.parse(json_notparsed)

process_bundle(file_config)

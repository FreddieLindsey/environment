#!/usr/bin/env ruby

require 'fileutils'
require 'git'
require 'JSON'

@where = nil

file = File.new('imperial.json', 'r')
json_notparsed = file.read
file_config = JSON.parse(json_notparsed)

process_bundle(file_config)

def process_bundle(b)
  b.each do |repo|
    bundle = repo['bundle']
    if bundle
      puts "Synchronising bundle:\t", repo['name']
      process_bundle(bundle)
    else
      remote = repo['remote']

      dir = ''
      dir += where + '/' if where
      dir += repo['dir']
      dir = dir.split('/')

      dir.delete('')
      dir.delete('.')

      item = dir[-1]
      dir = dir[0..dir.length - 2].join('/')

      FileUtils.mkpath(dir)

      puts Git.clone(remote, item, path: dir)
    end
  end
end

#!/usr/bin/env ruby

require 'fileutils'
require 'git'
require 'JSON'

@where = nil

def process_bundle(b, dir_ = '', indent = 0)
  b.each do |repo|
    bundle = repo['bundle']
    if bundle
      print "\t" * indent, "Synchronising bundle:\t", repo['name'], "\n"
      if repo['dir']
        dir = dir_
        dir += repo['dir']
      else
        dir = dir_
      end
      FileUtils.mkpath(dir) if dir != ''
      dir += '/' if dir[-1] != '/'
      process_bundle(bundle, dir, indent + 1)
    else
      remote = repo['remote']

      dir = dir_
      dir += @where + '/' if @where
      dir += repo['dir']
      dir = dir.split('/')

      dir.delete('.')

      item = dir[-1]
      dir = dir[0..dir.length - 2].join('/')

      clone_repo(remote, item, dir, indent)
    end
  end
end

def clone_repo(remote, item, dir, indent = 0)
  git_dir = "#{dir}/#{item}"
  if File.directory?(dir) && File.directory?("#{git_dir}/.git")
    g = Git.open(git_dir)
    print "\t" * indent, "Fetching remote for:\t", item, "\n"
    g.remotes.each(&:fetch)
  elsif File.directory?(git_dir)
    print "\t" * indent, "Not a git repository, ignoring:\t", item, "\n"
  else
    Git.clone(remote, item, path: dir)
    print "\t" * indent, "Cloned:\t", item, "\n"
  end
end

# Main

file = File.new('repos.json', 'r')
file_config = JSON.parse(file.read)

process_bundle(file_config)

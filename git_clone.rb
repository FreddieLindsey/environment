#!/usr/bin/env ruby

require 'fileutils'
require 'git'

def process_bundle(b, dir_ = '', indent = 0)
  b.sort! { |a_, b_| a_['name'] <=> b_['name'] }

  b.each do |repo|
    bundle = repo['bundle']

    dir = dir_
    dir += repo['dir'] if repo['dir']

    if bundle
      print "\t" * indent, "Synchronising bundle:\t", repo['name'], "\n"
      FileUtils.mkpath(dir) if dir != ''
      dir += '/' if dir[-1] != '/'
      process_bundle(bundle, dir, indent + 1)
    else
      remote = repo['remote']
      dir = dir.split('/')
      dir.delete('.')

      item = dir[-1]
      dir = dir[0..dir.length - 2].join('/')

      clone_repo(remote, item, dir, repo['recursive'], indent, repo['name'])
    end
  end
end

def clone_repo(remote, item, dir, recursive, indent = 0, name = nil)
  name = item unless name
  git_dir = "#{dir}/#{item}"
  begin
    if File.directory?(dir) && File.directory?("#{git_dir}/.git")
      print "\t" * indent, "Checking git repository:\t", name
      g = Git.open(git_dir)
      print "\r\033[2K", "\t" * indent, "Fetching remote for:\t", name
      g.remotes.each(&:fetch)
      `git -C #{git_dir} submodule update --init >/dev/null 2>&1` if recursive
      commit = g.log[0]
      hash = commit.to_s
      hash = hash.length > 10 ? hash[0..9] : hash
      message = (commit.message).split("\n")[0]
      print "\r\033[2K", "\t" * indent, "Fetched:\t", name,
            ' @ ', hash, ' - ', message
      puts
    elsif File.directory?(git_dir)
      print "\t" * indent, "Not a git repository, ignoring:\t", name
      puts
    else
      print "\t" * indent, "Cloning:\t", name
      g = Git.clone(remote, item, path: dir)
      commit = g.log[0]
      hash = commit.to_s
      hash = hash.length > 10 ? hash[0..9] : hash
      print "\r\033[2K", "\t" * indent, "Cloned:\t", name,
            ' @ ', hash, ' - ', message
      `git -C #{git_dir} submodule update --init` if recursive
      puts
    end
  rescue Git::GitExecuteError
    print "\t" * indent, "Error (does the repo exist?):\t", item,
          ' => ', remote, "\n"
  end
end

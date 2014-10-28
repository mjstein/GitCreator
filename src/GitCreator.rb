require 'rubygems'
require 'git'
require 'logger'

class GitRecordCreator
  def initialize
    Dir.mkdir('./configuration') if not Dir.exists?('./configuration')
    if not git_repository_exists?
      puts "Git repo does not exist, creating"
      create_git_repository
    end
  end

  def commit_configuration_file
    config_file = 'config.yaml'
     configuration_file_exists?(config_file) 
      commit_file(config_file) 
  return true
  end

  private 

  def git_repository_exists?
    begin
      Git.open('configuration')
    rescue ArgumentError 
      return false
    end
    true
  end 

  def create_git_repository
    @g = Git.init('configuration')
    @g.config('user.name', 'User')
    @g.config('user.email', 'user@user.com')
  end

  def configuration_file_exists?(file)
    return File.exist?(file)
  end

  def commit_file(file)
    git_add(file)
    git_commit('bland')
  end

  def git_add(file)
    puts "Adding #{file} to index"
    @g.add(file)
  end

  def git_commit(message)
    puts "Commiting"
     @g.commit(message)
  end
end



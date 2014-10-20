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
end

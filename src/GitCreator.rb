require 'rubygems'
require 'git'
require 'logger'

class GitRecordCreator
  @@Configuration_file_location = './configration/'
  @@Confirguration_file_name = 'definitions.yaml'
  def initialize
    Dir.mkdir('./configuration') if not Dir.exists?('./configuration')
    if not git_repository_exists?
      puts "Git repo does not exist, creating"
      create_git_repository
    end
  end

  def commit_configuration_file
    p @g.index
    
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



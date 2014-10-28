require 'rubygems'
require 'git'
require 'logger'
require 'pp'
class GitRecordCreator
  def initialize
    Dir.mkdir('./configuration') if not Dir.exists?('./configuration/')
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
      @g = Git.open('configuration')
    rescue ArgumentError 
      return false
    end
    true
  end 

  def get_commit_message
    if previous_commit_exists?
      commit_message = @g.gcommit(get_latest_log).message
    else
      "No message"
    end
  end

  def get_latest_log
    return @g.log[0]
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
    git_commit("#{Time.now}, config.yaml")
  end
  
  def previous_commit_exists?
    !(@g.branches.to_s ==  '')
  end

  def git_add(file)
    puts "Adding #{file} to index"
    @g.add(file)
  end
  
  def get_diff_message
    if @g.log.size > 1
       puts @g.diff(@g.log[1], @g.log[0])
       puts @g.diff(@g.log[1], @g.log[0]).stats
    end
  end
  def git_commit(message)
    puts "Commiting"
    @g.commit(message)
   puts get_commit_message

   get_diff_message

  end

end



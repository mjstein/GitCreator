# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard :rspec, cmd: 'bundle exec rspec --format doc --color'   do  
#  watch /src/ files
  watch(%r{^src/(.+).rb$}) do |m|
  "spec/#{m[1]}_spec.rb"
  end

# watch /spec/ files
watch(%r{^spec/(.+).rb$}) do |m|
"spec/#{m[1]}.rb"
end
end

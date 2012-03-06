require 'rubygems'
require 'open-uri'
require 'singleton'
require 'json'

module JenkinsStatusTool
  class JenkinsBroker
    include Singleton
    
    def project_info project
      json["jobs"].select {|o| o["name"] == project}.first rescue Hash.new
    end
    
    def project_rcov_graph project
      open("http://#{Config.instance.jenkins}/job/#{project}/rcov/graph").read rescue nil
    end
    
    private
    def json
      JSON.parse open("http://#{Config.instance.jenkins}/api/json").read
    end
    
  end
end

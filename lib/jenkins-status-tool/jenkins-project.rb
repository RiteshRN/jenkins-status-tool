require 'ostruct'

module JenkinsStatusTool
  class JenkinsProject < OpenStruct

    def initialize hash
      super
      self.project = hash.fetch :project
      self.jenkins = JenkinsBroker::instance
    end
    
    def status
      case color
      when :red     then :fail
      when :blue    then :pass
      when :gray    then :inactive
      else :unknown
      end
    end

    def color
      data["color"].to_sym
    end
    
    def rcov format=:png
      case format
      when :png then
        jenkins.project_rcov_graph project
      else
        raise ArgumentError.new "#{format.inspect} isn't supported yet"
      end
    end
    
    private
    
    def data
      jenkins.project_info project
    end
    
  end
end
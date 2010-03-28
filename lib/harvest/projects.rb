class Harvest
  class Projects < BaseApi
    api_methods %w(all find create update delete deactivate activate)
    
    def all
      response = request(:get, credentials, "/projects")
      Harvest::Project.parse(response.body)
    end
    
    def find(id)
      response = request(:get, credentials, "/projects/#{id}")
      Harvest::Project.parse(response.body)
    end
    
    def create(project)
      response = request(:post, credentials, "/projects", :body => project.to_xml)
      id = response.headers["location"].first.match(/\/projects\/(\d+)/)[1]
      find(project.id)
    end
    
    def update(project)
      request(:put, credentials, "/projects/#{project.id}", :body => project.to_xml)
      find(project.id)
    end
    
    def delete(project)
      request(:delete, credentials, "/projects/#{project.id}")
      project.id
    end
    
    def deactivate(project)
      if project.active?
        request(:put, credentials, "/projects/#{project.id}/toggle", :headers => {'Content-Length' => '0'})
        project.active = false
      end
      project
    end
    
    def activate(project)
      if !project.active?
        request(:put, credentials, "/projects/#{project.id}/toggle", :headers => {'Content-Length' => '0'})
        project.active = true
      end
      project
    end
  end
end
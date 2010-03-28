class Harvest
  class Tasks < BaseApi
    api_methods crud
    
    def all
      response = request(:get, credentials, "/tasks")
      Harvest::Task.parse(response.body)
    end
    
    def find(id)
      response = request(:get, credentials, "/tasks/#{id}")
      Harvest::Task.parse(response.body)
    end
    
    def create(task)
      response = request(:post, credentials, "/tasks", :body => task.to_xml)
      id = response.headers["location"].first.match(/\/tasks\/(\d+)/)[1]
      find(task.id)
    end
    
    def update(task)
      request(:put, credentials, "/tasks/#{task.id}", :body => task.to_xml)
      find(task.id)
    end
    
    def delete(task)
      request(:delete, credentials, "/tasks/#{task.id}")
      task.id
    end
  end
end
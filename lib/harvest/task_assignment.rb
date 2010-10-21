module Harvest
  class TaskAssignment < BaseModel
    include HappyMapper
    
    tag 'task-assignment'
    element :id, Integer
    element :task_id, Integer, :tag => 'task-id'
    element :project_id, Integer, :tag => 'project-id'
    element :billable, Boolean
    element :deactivated, Boolean
    element :hourly_rate, Float, :tag => 'hourly-rate'
    element :budget, Float
    element :estimate, Float
    
    def task=(task)
      @task_id = task.to_i
    end
    
    def project=(project)
      @project_id = project.to_i
    end
    
    def active?
      !deactivated
    end
    
    def task_xml
      builder = Builder::XmlMarkup.new
      builder.task do |t|
        t.id(task_id)
      end
    end
    
    alias_method :billable?, :billable
  end
end
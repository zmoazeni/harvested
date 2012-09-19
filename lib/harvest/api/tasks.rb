module Harvest
  module API
    class Tasks < Base
      api_model Harvest::Task

      include Harvest::Behavior::Crud

      # Deactivating tasks is not yet supported by the Harvest API.

      # Deactivates the task. Does nothing if the task is already deactivated
      # 
      # @param [Harvest::Task] task the task you want to deactivate
      # @return [Harvest::Task] the deactivated task
      #def deactivate(task)
      #  if task.active?
      #    request(:post, credentials, "#{api_model.api_path}/#{task.to_i}/deactivate", :headers => {'Content-Length' => '0'})
      #    task.active = false
      #  end
      #  task
      #end
      
      # Activates the task. Does nothing if the task is already activated
      # 
      # @param [Harvest::Task] task the task you want to activate
      # @return [Harvest::Task] the activated task
      def activate(task)
        if !task.active?
          request(:post, credentials, "#{api_model.api_path}/#{task.to_i}/activate", :headers => {'Content-Length' => '0'})
          task.active = true
        end
        task
      end

    end
  end
end
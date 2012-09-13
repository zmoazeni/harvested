module Harvest
  module API
    class Tasks < Base
      api_model Harvest::Task

      include Harvest::Behavior::Crud

      # Activates the task. Does nothing if the task is already activated
      # 
      # @param [Integer] task_id the task you want to activate
      # @return [Boolean] the response of the activation request
      def activate(task_id)
        request(:post, credentials, "#{api_model.api_path}/#{task_id}/activate", :headers => {'Content-Length' => '0'})
      end
    end
  end
end
require './config/boot'
require './config/environment'

Zhong.schedule do
  category 'create evaluation' do
    every(3.seconds, 'start mass creating evaluation posts') do
      CreateEvaluationsProcessor.new.run
    end
  end
end


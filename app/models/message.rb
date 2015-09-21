class Message < ActiveRecord::Base
  attr_accessible :from_message, :text, :to_message, :topic_id
end

#coding:UTF-8
class Message < ActiveRecord::Base
  attr_accessible :from_message, :text, :to_message, :topic_id, :read
  validates :from_message, :to_message, :topic_id, :text, presence: true
end

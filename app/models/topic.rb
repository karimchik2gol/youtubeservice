class Topic < ActiveRecord::Base
  attr_accessible :best, :date_happing, :description, :from_topic, :happing_to, :name, :project_type, :to_topic, :type
end

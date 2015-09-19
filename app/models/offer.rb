class Offer < ActiveRecord::Base
  attr_accessible :application_deadline, :description, :user_id, :location_dependent, :location_dependent_boolean, :name, :project_type, :subscriber_range, :targe_audience_geos, :target_channel_categories
end

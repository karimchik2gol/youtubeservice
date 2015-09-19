class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :project_type
      t.string :name
      t.text :description
      t.string :application_deadline
      t.string :targe_audience_geos
      t.string :location_dependent
      t.boolean :location_dependent_boolean
      t.string :target_channel_categories
      t.string :subscriber_range
      t.integer :user_id

      t.timestamps
    end
  end
end

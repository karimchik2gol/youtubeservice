# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20151101140057) do

  create_table "admins", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "anketa", :force => true do |t|
    t.boolean  "create_videos"
    t.boolean  "making_channel_toghether"
    t.boolean  "cross_promotions_and_email_lists"
    t.boolean  "recommended_channel_swapping"
    t.boolean  "annotation_or_end_card_or_link_swapping"
    t.boolean  "open_to_other_types"
    t.boolean  "brand_product_integration"
    t.boolean  "product_reviews"
    t.boolean  "dedicated_videos"
    t.boolean  "revenue_affiliate"
    t.boolean  "spokesperson"
    t.boolean  "offyoutube_promotion"
    t.boolean  "including_brand_videos"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "from_message"
    t.integer  "to_message"
    t.string   "text"
    t.integer  "topic_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "read",         :default => false
  end

  create_table "offermessages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "offer_id"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "yslygi_id"
  end

  create_table "offers", :force => true do |t|
    t.string   "project_type"
    t.string   "name"
    t.text     "description"
    t.string   "application_deadline"
    t.string   "targe_audience_geos"
    t.string   "location_dependent"
    t.boolean  "location_dependent_boolean"
    t.string   "target_channel_categories"
    t.string   "subscriber_range"
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "textdescs", :force => true do |t|
    t.string   "name"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "to_topic"
    t.integer  "from_topic"
    t.string   "name"
    t.string   "type"
    t.string   "project_type"
    t.string   "happing_to"
    t.string   "date_happing"
    t.text     "description"
    t.string   "best"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "phone"
    t.string   "category"
    t.string   "city"
    t.integer  "youtube_info_id"
    t.integer  "anketa_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "youtube_info_ids", :force => true do |t|
    t.integer  "user_id"
    t.integer  "anketa_id"
    t.string   "name"
    t.text     "description"
    t.string   "trailer"
    t.integer  "video_count"
    t.datetime "published_at"
    t.string   "channel_id"
    t.text     "demographic"
    t.integer  "views_per_month"
    t.integer  "views"
    t.float    "average_views_per_video"
    t.float    "average_sharing"
    t.float    "average_likes"
    t.float    "average_posted_videos_per_month"
    t.text     "country"
    t.integer  "subscribers"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "refresh_token"
    t.string   "image"
    t.string   "gender"
    t.integer  "ageGteq"
    t.integer  "ageLteq"
    t.integer  "age_gteq"
    t.integer  "age_lteq"
    t.boolean  "create_videos"
    t.boolean  "making_channel_toghether"
    t.boolean  "cross_promotions_and_email_lists"
    t.boolean  "recommended_channel_swapping"
    t.boolean  "annotation_or_end_card_or_link_swapping"
    t.boolean  "open_to_other_types"
    t.boolean  "brand_product_integration"
    t.boolean  "product_reviews"
    t.boolean  "dedicated_videos"
    t.boolean  "revenue_affiliate"
    t.boolean  "spokesperson"
    t.boolean  "offyoutube_promotion"
    t.boolean  "including_brand_videos"
    t.boolean  "open_to_other_types_sponsor"
    t.string   "gender_percentage"
    t.boolean  "channel_size_limit"
    t.boolean  "obmen_like_yslygi"
    t.boolean  "obmen_like"
    t.boolean  "obmen_like_yslyga"
    t.boolean  "reklama_v_rolike"
    t.boolean  "reklama_v_rolike_yslyga"
  end

  create_table "yslygis", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "category"
    t.string   "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.integer  "to_topic"
  end

end

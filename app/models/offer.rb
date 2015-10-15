#coding:UTF-8
class Offer < ActiveRecord::Base
  attr_accessible :application_deadline, :description, :user_id, :location_dependent, :location_dependent_boolean, :name, :project_type, :subscriber_range, :targe_audience_geos, :target_channel_categories
  OFFERS_ARRAY_CATEGORY=[
  						["Создание видео вместе", "create_videos"],
  						["Создание нового канала вместе", "making_channel_toghether"],
  						["Продвижение вне Ютуба(соц. сети, e-mail рассылки, сайты)", "cross_promotions_and_email_lists"],
  						["Обмен \"Рекомендованные каналы\"", "recommended_channel_swapping"],
  						["Обмен ссылками на канал в описании", "annotation_or_end_card_or_link_swapping"],
  						["Обмен лайками", "obmen_like"],
  						["Обменой рекламой в ролике","reklama_v_rolike"],
  						["Другое", "open_to_other_types"]
  						]

  validates :name, :description, :project_type, format:{with: /[[:graph:]]/, message: "Поле заполнено неверно"}
  validates :application_deadline, format:{with: /^([0-9]{2}\/){2}[0-9]{4}$/, message: "Формат: ДД/ММ/ГГГГ"}
end

#coding:UTF-8
class Offer < ActiveRecord::Base
  attr_accessible :application_deadline, :description, :user_id, :location_dependent, :location_dependent_boolean, :name, :project_type, :subscriber_range, :targe_audience_geos, :target_channel_categories
  OFFERS_ARRAY_CATEGORY=["Создание видео вместе",
  						"Создание нового канала вместе",
  						"Продвижение вне Ютуба(соц. сети, e-mail рассылки, сайты)",
  						"Обмен \"Рекомендованные каналы\"",
  						"Обмен ссылками на канал в описании",
  						"Другое"]

  validates :name, :description, :project_type, format:{with: /[[:graph:]]/, message: "Поле заполнено неверно"}
  validates :application_deadline, format:{with: /^([0-9]{2}\/){2}[0-9]{4}$/, message: "Формат: ДД/ММ/ГГГГ"}
end

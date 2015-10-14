#coding:UTF-8
class Yslygi < ActiveRecord::Base
  attr_accessible :category, :date, :description, :name, :user_id, :to_topic
  OFFERS_ARRAY_CATEGORY=[
  						["Интеграция бренда/продукта в ваши видео", "brand_product_integration"],
  						["Отзывы о продуктах", "product_reviews"],
  						["Выделенное количество видео про бренд", "dedicated_videos"],
  						["Вы получаете процент от выручки(зачастую не предоплата)", "revenue_affiliate"],
  						["Докладчик", "spokesperson"],
  						["Продвижение вне YouTube(сайт, соц. сети)", "offyoutube_promotion"],
  						["Добавление видео про бренд/продукт в плейлист", "including_brand_videos"],
  						["Открыт к другим видам услуг", "open_to_other_types_sponsor"]
  						]

  validates :name, :description, :category, format:{with: /[[:graph:]]/, message: "Поле заполнено неверно"}
  validates :date, format:{with: /^([0-9]{2}\/){2}[0-9]{4}$/, message: "Формат: ДД/ММ/ГГГГ"}

end

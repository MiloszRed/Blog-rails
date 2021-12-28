class Post < ApplicationRecord
    has_many :comments, dependent: :destroy

    has_many_attached :images

    def image_urls
        images.map{|i| Rails.application.routes.url_helpers.url_for(i) }
    end
    
    validates :title, presence: true,
                        length: {minimum: 3, maximum: 100}

end

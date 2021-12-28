class Post < ApplicationRecord
    include Rails.application.routes.url_helpers

    has_many :comments, dependent: :destroy
    
    validates :title, presence: true,
                        length: {minimum: 3, maximum: 100}

end

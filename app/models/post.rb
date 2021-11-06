class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many_attached :images
    
    validates :title, presence: true,
                        length: {minimum: 3, maximum: 100}
    validate :image_type

    def thumbnail input
        return self.images[input].variant(resize: '300x300!').processed
    end

    private
    def image_type
        images.each do |image|
            if !image.content_type.in?(%('image/jpeg image/png image/jpg'))
                errors.add(:images, 'needs to be a JPEG, JPG or PNG')
            end
        end
    end
end

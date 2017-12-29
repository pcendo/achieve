class Blog < ApplicationRecord
    validates :title,      presence: true
    validates :content,    length: { in: 1..140 }
    validates :user_id,    presence: true
    validates :image,      presence: true

    has_many :favorites, dependent: :destroy
    has_many :favorite_users, through: :favorites, source: :user

    def user
        return User.find_by(id: self.user_id)
    end
    
    mount_uploader :image, ImageUploader
    
end

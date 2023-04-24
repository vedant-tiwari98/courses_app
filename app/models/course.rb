class Course < ApplicationRecord
    has_many :tutors, dependent: :destroy
    validates :title, presence: true
    validates :code, presence: true, uniqueness: true
    validates :description, length: { minimum: 10 }
    accepts_nested_attributes_for :tutors
end

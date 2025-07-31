class Lesson < ApplicationRecord
  belongs_to :course
  
  has_many :lesson_topics, dependent: :destroy
  has_many :topics, through: :lesson_topics
end

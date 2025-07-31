class Topic < ApplicationRecord

  has_many :lesson_topics, dependent: :destroy
  has_many :lessons, through: :lesson_topics
end

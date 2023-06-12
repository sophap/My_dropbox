class Dock < ApplicationRecord
  attribute :title, :string
  attribute :format, :string
  belongs_to :user
  has_many_attached :files
  

end

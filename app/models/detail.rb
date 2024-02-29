class Detail < ApplicationRecord
  belongs_to :person

  validates :detail_type, presence: true
end

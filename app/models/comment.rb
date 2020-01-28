# frozen_string_literal: true

# Model for comments
class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
end

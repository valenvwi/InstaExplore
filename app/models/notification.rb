class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true
end

# https://github.com/excid3/noticed

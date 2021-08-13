class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :boat

    # To create scopes
  # https://www.rubyguides.com/2019/10/scopes-in-ruby-on-rails/
  # https://stackoverflow.com/questions/23412719/rails-4-scope-with-argument/23412746
  # scope :upcomming_bookings, lambda { |user| where("start_date >= ? and user_id = ?", Date.today, user.id) }
  scope :upcomming, ->(user) { where("start_date >= ? and user_id = ?", Date.today, user.id) }
  scope :past, ->(user) { where("start_date < ? and user_id = ?", Date.today, user.id) }

end

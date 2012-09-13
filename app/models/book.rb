# == Schema Information
#
# Table name: books
#
#  id               :integer          not null, primary key
#  call_number      :string(255)
#  title            :string(255)
#  author           :string(255)
#  publication_year :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  borrowed_at      :datetime
#

class Book < ActiveRecord::Base
  attr_accessible :author, :borrowed_at, :call_number, :publication_year, :title, :user_id
  
  belongs_to :user
  
  #default_scope :order => "books.updated_at DESC" # ordered from most recent to least recently updated
  default_scope :order => "books.borrowed_at DESC" # ordered from most recent to least recently borrowed
  
  validates :title, :presence => true,
                    :length => { :maximum => 60 }
  validates :author, :presence => true,
                     :length => { :maximum => 40 }
  validates :call_number, :length => { :maximum => 40 }
  validates :publication_year, :presence => true,
                               :length => { :is => 4 }
end

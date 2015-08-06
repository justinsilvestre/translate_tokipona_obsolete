class Document < ActiveRecord::Base
  belongs_to :user
  has_many :translations

  validates :title, presence: true

  before_save :set_json

  private

  def set_json
  	require 'tokipona'
  	self.json = Parsing.new(original_text).json
  end
end

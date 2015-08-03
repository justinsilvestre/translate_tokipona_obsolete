class Document < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true

  before_save :set_json

  private

  def set_json
  	require_relative '../../lib/parsing/parsing'
  	self.json = Parsing.new(original_text).json
  end
end

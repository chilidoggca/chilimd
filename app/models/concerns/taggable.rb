module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, :as => :taggable, dependent: :destroy
    has_many :tags, :through => :taggings
    # has_many :tags, as: :taggable, through: :taggings
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip.downcase.capitalize).first_or_create!
    end
  end

  module ClassMethods
    def tag_counts
      Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
    end
  end
end

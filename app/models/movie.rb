class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def with_same_director
    return [] if self.director.blank?
    self.class.where(:director => self.director)
  end
end

require 'spec_helper'
describe Movie do
  describe "all_ratings" do
    it "should return list of all ratings" do
      Movie.all_ratings.should == %w(G PG PG-13 NC-17 R)
    end
  end
  describe "find_movies_with_same_director" do
    describe "when I have a director" do
      it "returns a relation if some exist with the same director" do
        @movie = FactoryGirl.create :movie, director:"George Lucas"
        result = @movie.with_same_director
        result.should be_an_instance_of ActiveRecord::Relation
      end
    end
    describe "when I have no director" do
      it "returns an empty array of movies" do
        @movie = FactoryGirl.create :movie, director:nil
        result = @movie.with_same_director
        result.should be_an_instance_of Array
        result.should == []
      end
    end
  end
end

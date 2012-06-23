require 'spec_helper'
describe "MoviesController" do
  describe "add director to existing movie" do
    before :each do
      @movie = FactoryGirl.create :movie, :director => nil
    end
    it 'should render the Movie edit page' do
      get :edit, @movie
      response.should render_template 'edit'
    end
  end
  describe "find movie with same director" do
  end
  describe "can't find similar movies if we don't know director" do
  end
end

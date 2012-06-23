require 'spec_helper'
describe MoviesController do
  describe "add director to existing movie" do
    before :each do
      @movie = FactoryGirl.create :movie, :director => nil
    end
    describe "from the edit page" do
      it 'should render the Movie edit page' do
        get :edit, id: @movie.id
        response.should render_template 'edit'
      end
    end
    describe "upon post with director non nil" do
      it 'should set the director' do
        post :update, id: @movie.id, movie: {'director' => 'George Lucas'} 
        assigns[:movie].director.should == 'George Lucas'
      end
    end
  end
  describe "find movie with same director" do

  end
  describe "can't find similar movies if we don't know director" do
  end
end

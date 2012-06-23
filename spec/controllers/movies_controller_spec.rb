require 'spec_helper'
describe MoviesController do
  describe "show a movie" do
    it "should render the show page" do
      @movie = FactoryGirl.create :movie
      get :show, :id => @movie.id
      response.status.should == 200
      response.should render_template('show')
    end
  end
  describe "create a movie" do
    it "should destroy the movie" do
      assert_difference 'Movie.count', 1 do
        post :create, :movie => { title:"foo", director:'goo', release_date:Date.today}
        response.should redirect_to(movies_path)
      end
    end
  end
  describe "destroy an existing movie" do
    it "should destroy the movie" do
      @movie = FactoryGirl.create :movie
      assert_difference 'Movie.count', -1 do
        post :destroy, :id => @movie.id, :method => 'delete'
        response.should redirect_to(movies_path)
      end
    end
  end
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
    it "should render the same results page with a movie" do
      @movie = FactoryGirl.create :movie, director:"George Lucas"
      Movie.should_receive(:find).with(@movie.id.to_s).and_return(@movie)
      fake_result = [FactoryGirl.build(:movie, director:"George Lucas")]
      @movie.stub(:with_same_director).and_return fake_result

      get :director, :id => @movie.id
      assigns(:same_directors).should == fake_result
      response.should render_template 'director'
    end
  end
  describe "can't find similar movies if we don't know director" do
    it "should flash notice and redirect to movies" do
      @movie = FactoryGirl.create :movie, director:nil
      Movie.should_receive(:find).with(@movie.id.to_s).and_return(@movie)
      @movie.should_not_receive(:with_same_director)

      get :director, :id => @movie.id
      response.should redirect_to(movies_path)
      flash[:notice].should == "'#{@movie.title}' has no director info"
    end
  end
end

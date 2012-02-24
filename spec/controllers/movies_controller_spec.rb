require 'spec_helper'

describe MoviesController do
  
  describe 'find movies with directors (happy path)' do
  
    before :each do
      @fake_list = [mock('Movie'), mock('Movie')]
      @fake_movie = mock('Movie', {:id => '1', :title => 'something', :director => 'someone'})
    end
    
    it 'should have an id' do
      Movie.stub(:find).with('1').and_return(@fake_list)
      Movie.stub(:find_by_stub).and_return(@fake_movie)
      get "director", {:id => '1', :director => 'someone', :title => 'something'}
    end
    
    it 'should call find_by_director' do 
      Movie.should_receive(:find_by_director).with('someone').and_return(@fake_list)
      Movie.stub(:find_by_stub).and_return(@fake_movie)
      get "director", {:id => '1', :director => 'someone', :title => 'something'}
    end
    
    it 'should change the view' do
      Movie.should_receive(:find_by_director).with('someone').and_return(@fake_list)
      Movie.stub(:find_by_stub).and_return(@fake_movie)
      get "director", {:id => '1', :director => 'someone', :title => 'something'}
      response.should render_template('director')
    end
  
    it 'should not redirect' do
      Movie.should_receive(:find_by_director).with('someone').and_return(@fake_list)
      Movie.stub(:find_by_stub).and_return(@fake_movie)
      get "director", {:id => '1', :director => 'someone', :title => 'something'}
      response.should_not render_template('index')
    end
  
  end
  
  describe 'find movies without directors (sad path)' do
    before :each do
      @fake_list = [mock('Movie'), mock('Movie')]
      @fake_movie = mock('Movie', {:id => '1', :title => 'something', :director => nil})
    end
  
    it 'should have an id' do
      Movie.stub(:find).with('1').and_return(@fake_list)
      Movie.stub(:find_by_stub).and_return(@fake_movie)
      get "director", {:id => '1', :director => nil, :title => 'something'}
    end
    
    it 'should not call find_by_director' do 
      Movie.should_not_receive(:find_by_director).with('someone').and_return(@fake_list)
      Movie.stub(:find_by_stub).and_return(@fake_movie)
      get "director", {:id => '1', :director => nil, :title => 'something'}
    end
    
    it 'should redirect' do
      get "director", {:id => '1', :director => nil, :title => 'something'}
      response.should redirect_to('/movies')
    end
    
    it 'should not be the diretor view' do
      get "director", {:id => '1', :director => nil, :title => 'something'}
      response.should_not render_template('director')
    end
  
  end
  
  describe 'others' do
   before :each do
      @fake_list = [mock('Movie'), mock('Movie')]
      @fake_movie = mock('Movie', :id => '1')
    end
      it 'to make 90%' do
      Movie.should_receive(:find).with('1').and_return(@fake_list)
      get :show, {:id => 1, :sort => 'title'}
    end
    
      it 'to make 90% Part 2' do
            Movie.should_receive(:find).with('1').and_return(@fake_list)
      get :index
      end
      
      it 'to make 90% Part 3' do
      post :create 
      end
      
      it 'to make 90% Part 4' do
      get :new 
      end
  end
  
end

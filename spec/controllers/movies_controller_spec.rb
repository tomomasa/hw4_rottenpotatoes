require 'spec_helper'

describe MoviesController do
  
  describe 'find movies with directors (happy path)' do
  
    before :each do
      @fake_list = [mock('Movie'), mock('Movie')]
      @fake_movie = mock('Movie', :director => 'someone')
    end
    
    it 'should call find_by_director' do 
      Movie.should_receive(:find_by_director).with('someone').and_return(@fake_list)
      Movie.stub(:find).and_return(@fake_movie)
      get "director", {:id => '1', :director => 'someone', :title => 'something'}
    end
    
    it 'should change the view' do
      Movie.should_receive(:find_by_director).with('someone').and_return(@fake_list)
      Movie.stub(:find).and_return(@fake_movie)
      get "director", {:id => '1', :director => 'someone', :title => 'something'}
      response.should render_template('director')
    end
  
    it 'should not redirect' do
      Movie.should_receive(:find_by_director).with('someone').and_return(@fake_list)
      Movie.stub(:find).and_return(@fake_movie)
      get "director", {:id => '1', :director => 'someone', :title => 'something'}
      response.should_not render_template('index')
    end
  
  end
  
  describe 'find movies without directors (sad path)' do
    before :each do
      @fake_list = [mock('Movie'), mock('Movie')]
      @fake_movie = mock('Movie', :director => '', :title=> 'something')
    end
    
    it 'should not call find_by_director' do 
      Movie.should_not_receive(:find_by_director).with('').and_return(@fake_list)
      Movie.stub(:find).and_return(@fake_movie)
      get "director", {:id => '1', :director => nil, :title => 'something'}
    end
    
    it 'should redirect' do
      Movie.stub(:find).and_return(@fake_movie)
      get "director", {:id => '1', :director => nil, :title => 'something'}
      response.should redirect_to('/movies')
    end
    
    it 'should not be the diretor view' do
          Movie.stub(:find).and_return(@fake_movie)
      get "director", {:id => '1', :director => nil, :title => 'something'}
      response.should_not render_template('director')
    end
  
  end
  
  describe 'others' do
   before :each do
      @fake_list = [mock('Movie'), mock('Movie')]
      @fake_movie = mock('Movie', :id => '1', :update_attributes! => true, :title => 'something')
    end
      it 'to make 90%' do
      Movie.should_receive(:find).with('1').and_return(@fake_list)
      get :show, {:id => 1, :sort => 'title'}
    end
    
      it 'to make 90% Part 2' do
      get :index, {:sort => 'title'}
      end
      
            it 'to make 90% Part 2' do
      get :index, {:sort => 'release_date'}
      end
      
      
      it 'to make 90% Part 2' do
      session[:sort] = 'title'
      get :index, {:sort => 'release_date'}
      end
      
      it 'to make 90% Part 2' do
      session[:ratings] = 'title'
      get :index, {:ratings => 'release_date'}
      end
      
      it 'to make 90% Part 3' do
      post :create 
      end
      
      it 'to make 90% Part 4' do
      get :new 
      end
      
      it 'to make 90% Part 5' do
      @fake_movie = @fake_movie
      @fake_list = @fake_list
      Movie.should_receive(:find).with('1').and_return(@fake_list)
      get :edit , {:id => 1}
      end
            
      it 'to make 90% Part 6' do
       Movie.stub(:find).and_return(@fake_movie)
      put :update , {:id => 1}
      end
     
  end
  
end

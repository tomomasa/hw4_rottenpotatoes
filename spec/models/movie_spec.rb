require 'spec_helper'

describe Movie do

  describe 'find movies with same directors' do
  
    before :each do
      @fake_list = [mock('Movie'), mock('Movie')]
      @fake_movie = mock('Movie', {:title => 'title', :director => 'someone'})
    end
    
    it 'should call the model method to filter by director' do
      Movie.should_receive(:find_all_by_director).with("someone").and_return(@fake_list)
      Movie.find_by_director("someone")
    end
    
    it 'should call the model method to filter by director' do
      Movie.should_receive(:find_all_by_director).with("director").and_return(@fake_list)
      Movie.stub(:where).and_return(@fake_movie)
      Movie.find_by_director("director")
    end  
    
    it 'should call the model method but not do anything else' do
      Movie.should_not_receive(:raondom).with("director").and_return(@fake_list)
      Movie.find_by_director("director")
    end
       
    it 'should have all_ratings' do
      Movie.all_ratings.should == %w(G PG PG-13 NC-17 R)   
    end
     
  end
  
end

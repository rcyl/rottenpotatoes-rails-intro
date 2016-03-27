class Movie < ActiveRecord::Base
  
  def self.all_ratings
    #maps all_ratings to key value pairs to match params
    self.pluck(:rating).uniq.map{ |x| [x,1] }.to_h 
  end
  
end

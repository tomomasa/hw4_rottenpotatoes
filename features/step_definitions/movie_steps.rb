# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  first = page.body.index(e1)
  second = page.body.index(e2)
  first.should < second
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  list = rating_list.split(", ")
  list.each do |rate|
    if uncheck
      step ('I uncheck "ratings_' + rate + '"')
    else
      step ('I check "ratings_' + rate + '"')
    end
  end
end

Then /I should not see any of the movies/ do 
  rows = page.all(:css, '#movies/tbody/tr')
  rows.length.should == 0
end

Then /I should see all of the movies/ do
  rows = page.all(:css, '#movies/tbody/tr')
  rows.length.should == 10
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  movie = Movie.find_by_title(title)
  movie.director.should == director
end


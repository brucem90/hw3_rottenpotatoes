# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  Movie.create(:title => movie["title"], :rating => movie["rating"], :release_date => movie["release_date"])
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  pos_e1 = page.body.index(e1)
  pos_e2 = page.body.index(e2)
  if pos_e1 < pos_e2 then before = true else before = nil end
  before.should == true
end

Then /I should not see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  pos_e1 = page.body.index(e1)
  pos_e2 = page.body.index(e2)
  if pos_e1 > pos_e2 then after = true else after = nil end
  after.should == true
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(', ')
  if !uncheck
    ratings.each do |rating|
      check('ratings_'+rating) #step "When I check '#{rating}'"
    end
  else
    ratings.each do |rating|
      uncheck('ratings_'+rating)
    end
  end
end

When /I (un)?check all the ratings/ do |uncheck|
  ratings = ['G','PG','PG-13','R']
  if !uncheck
    ratings.each do |rating|
      check('ratings_'+rating)
    end
  else
    ratings.each do |rating|
      uncheck('ratings_'+rating)
    end
  end
end

Then /^(?:|I )should see all of the movies/ do
  value = Movie.count
  rows = page.all('#movies tbody/tr').size
  rows.should == value
end
# When /^(?:|I )press "([^"]*)"$/ do |button|
#  click_button(button)
# end



# Then /^(?:|I )should see "([^"]*)" before "([^"]*)"$/ do |str1, str2|
#  match = /#{str1}.*#{str2}/m =~ page.body
# end


# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  e1_index = page.html.index(e1)
  e2_index = page.html.index(e2)
  flunk "#{e1} does not appear in the page" unless e1_index
  flunk "#{e2} does not appear in the page" unless e2_index
  flunk "#{e1} does not appear before #{e2}" unless e1_index < e2_index
end

Then /I should (see|not see)? the movies: (.*)/ do |see, movie_list|
  movie_list.split(",").map(&:strip).each do |title|
    step %Q{I should #{see} "#{title}"}
  end
end

Then /I should see (all|none) of the movies/ do |modifier|
  titles = Movie.all.map(&:title)
  see = modifier == "none" ? "not see" : "see"
  titles.each do |title|
    step %Q{I should #{see} "#{title}"}
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.gsub(/\s*/, '').split(',').each do |rating|
    step %Q{I #{uncheck ? "un" : ''}check "ratings[#{rating}]"}
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

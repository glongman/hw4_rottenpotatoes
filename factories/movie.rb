FactoryGirl.define do
  factory :movie do
    sequence(:title) {|n| "Movie #{n}"}
    rating {"PG"}
    release_date {Date.today}
    sequence(:director) {|n| "Director #{n}"}
  end
end

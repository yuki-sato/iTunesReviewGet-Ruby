
  require_relative "itunesreviews"
  
  reviews = ITunesReviews.new
  reviews.getReviewsFromNew("jp","343200656")
  
  reviews.reviews.each do |aReview|
    puts "start["+aReview.rate.to_s+"] Date["+aReview.updated.to_s+"]title: "+aReview.title
  end
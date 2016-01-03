module BooksHelper
  def get_rating_data(book)
    @rating_counts = book.ratings.length
    @avg_rating = 0.0
    @scores = Array.new(5) { |e| e = 0.0 }
    if @rating_counts > 0
      book.ratings.each do |r|
        @avg_rating += r.score
        case r.score
        when 2 then @scores[4] += 1
        when 4 then @scores[3] += 1
        when 6 then @scores[2] += 1
        when 8 then @scores[1] += 1
        when 10 then @scores[0] += 1
        end
      end
      @avg_rating = (@avg_rating/@rating_counts*10).round.to_f/10
      for i in 0..4
        @scores[i] = (@scores[i]/@rating_counts*1000).round.to_f/10
      end
    end
  end
end

class Paginator::PagesGroup
  attr_reader :last, :current, :count

  def initialize(current:, last:, count:)
    @last = last
    @current = current
    @count = count
  end

  def generate
    (first_page..last_page).each do |page_number|
      yield(page_number)
    end
  end

  private

  def left_spread
    @left_spread ||= count / 2
  end

  def right_spread
    @right_spread ||= count.odd? ? left_spread : (left_spread - 1)
  end

  def first_page
    @first_page ||= pagination_beginning? ? 1 : current - left_spread
  end

  def last_page
    @last_page ||= begin
      return last if pagination_ending?
      right_half_count = current + right_spread
      left_half_count = left_spread - current + 1

      if pagination_beginning?
        tail_pages = right_half_count + left_half_count
        return tail_pages > last ? last : tail_pages
      end

      right_half_count
    end
  end

  def pagination_beginning?
    current <= left_spread
  end

  def pagination_ending?
    current >= last - right_spread
  end
end

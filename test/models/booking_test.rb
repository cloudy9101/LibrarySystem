require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  setup do
    @username = 'John'
    @book = books(:one)
    @count = @book.count

    @book_no_stock = books(:two)
    @book_no_stock.update(count: 0)
    @wrong_book_id = 0
  end

  test 'make new booking when book available' do
    result = Booking.make(@username, @book.id)

    assert_equal(@book.name, result.book.name)
    assert_equal(@username, result.username)
    assert_equal(@count - 1, @book.reload.count)
  end

  test 'make new booking when book unavaliable' do
    result = Booking.make(@username, @book_no_stock.id)

    assert_equal("Selected book's stock is empty.", result)
  end

  test "make new booking when book isn't exist" do
    result = Booking.make(@username, @wrong_book_id)

    assert_equal("The book isn't exist.", result)
  end
end

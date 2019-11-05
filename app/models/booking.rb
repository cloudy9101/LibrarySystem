class Booking < ApplicationRecord
  belongs_to :book
  BOOK_STOCK_IS_EMPTY = "Selected book's stock is empty.".freeze
  BOOK_IS_NOT_EXIST = "The book isn't exist.".freeze

  def self.make(username, book_id)
    book = Book.find_by(id: book_id)
    return BOOK_IS_NOT_EXIST unless book
    return BOOK_STOCK_IS_EMPTY unless book.count.positive?

    booking = new(book_id: book.id, username: username)
    booking.save
    book.update(count: book.count - 1)

    booking
  end
end

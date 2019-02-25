class AddCompanyRefToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :company, foreign_key: true
  end
end

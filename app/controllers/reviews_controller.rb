class ReviewsController < ApplicationController
	
  def new 
    @review = Review.new()
    @product_approved = Product.where(:status => "approved")
	end 
  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to @review
    else
      render 'new'
    end 
  end 
  def show
    @review = Review.find(params[:id]) 
  end 
  def index
    @users = User.all 
    @reviews = Review.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 250)
    @reviewsall = Review.all.order("created_at DESC")
    @favorited_reviews = Review.all.where(:staff_favorite => true)
    @positive_review_count = Review.where("rating > ?", 3).count()
    if !Date.today.monday?
     @need_response = Review.where("rating < ?", 4).where("DATE(created_at) = ?", Date.yesterday)
    else 
      @friday = Date.today - 3 
      @need_response = Review.where("rating < ?", 4).where(:created_at => @friday.beginning_of_day..Date.yesterday.end_of_day)
    end 
   respond_to do |format|
    format.html
    if params[:type] == "1"
      format.csv { send_data @reviewsall.to_csv, filename: "Reviews-#{Date.today}.csv" }
    end 
    if params[:type] == "2"
      format.csv { send_data @need_response.to_csv, filename: "Reviews-#{Date.today}.csv" }
    end
  end 
  end 
  def update
    @review = Review.find(params[:id]) 
    @review.update(review_params)
  end 
  private 
  def review_params
      params.require(:review).permit(:text, :rating, :status, :product_id, :author_first, :author_last, :author_email, :staff_favorite, :vote)
  end 
end

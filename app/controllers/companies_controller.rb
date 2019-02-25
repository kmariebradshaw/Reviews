class CompaniesController  < ApplicationController
  def show
    @company = Company.find(params[:id]) 
    @reviews = @company.reviews.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 250) 
    @favorited_reviews = @reviews.all.where(:staff_favorite => true)
    @positive = @reviews.where("rating >= ?", 4).count
    @pending_reviews = @reviews.where(:status => "pending")
    if @company.id == 1 
      render :layout => 'application.html.erb'
    else 
      render :layout => 'pacas.html.erb'
    end 
  end 
  def index
  end 


end

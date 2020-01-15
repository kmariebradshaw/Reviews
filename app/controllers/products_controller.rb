class ProductsController < ApplicationController
  def new 
    @product = Product.new
  end 
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to '/products'
    else
      render 'new'
    end 
  end 
  def show
    @product = Product.find(params[:id]) 
    @reviews = @product.reviews.where(:status => "approved").order("created_at DESC").limit(5) 
    @no_reviews = Review.all.where(:status => "approved").order("created_at DESC").limit(5)
  end 
  def index
    @products = Product.all 
  end 
  def edit
    @product = Product.find(params[:id])
  end 
  def update
    @product = Product.find(params[:id]) 
     if @product.update(product_params)
      redirect_to '/products'
     else
      render 'edit'
    end
  end 
  def destroy
    @product = Product.find(params[:id])
    @product.destroy 
    redirect_to '/products'
  end
  private 
  def product_params
      params.require(:product).permit(:title, :status)
  end 
end

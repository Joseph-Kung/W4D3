class CatsController < ApplicationController
  before_action :user_verify, only: [:edit, :update]
  
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    if user_verify?
      @owner = true
    end
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end
  
  def user_verify
    # byebug
    if current_user
      current_user.cats.each do |cat|
        #byebug
        return if cat.id.to_s == params[:id]
      end
    end
    redirect_to cats_url 
  end
  
  def user_verify?
    # byebug
    if current_user
      current_user.cats.each do |cat|
        #byebug
        return true if cat.id.to_s == params[:id]
      end
    end
    false
  end
  
  

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end

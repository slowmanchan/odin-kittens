class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @kittens }
      format.json { render :json => @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @kitten }
      format.json { render :json => @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(strong_params)
    if @kitten.save
      flash[:success] = "New kitten made"
      redirect_to @kitten
    else
      flash.now[:danger] = "Invalid kitten paramaters"
      render 'new'
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update_attributes(strong_params)
      flash[:success] = "Kitten updated"
      redirect_to @kitten
    else
      flash.now[:danger] = "Invalid kitten stuff"
      render 'edit'
    end
  end

  def destroy
    Kitten.find(params[:id]).destroy
    flash[:success] = "Removed"
    redirect_to kittens_path
  end

  private

    def strong_params
      params.require(:kitten).permit(:name,
                                      :age, :cuteness, :softness)
    end
end

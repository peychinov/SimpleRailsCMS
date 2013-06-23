class CategoriesController < PublicController
  
  # GET /categories
  # GET /categories.json
  def index
    respond_to do |format|
      format.html { @categories = Category.all }
      format.json { render json: Category.children_json(params[:id]) }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

end

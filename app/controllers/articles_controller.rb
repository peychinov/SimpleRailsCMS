class ArticlesController < PublicController
  
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.search(params)

    respond_to do |format|
      format.html
      format.json { render json: @articles }
    end
  end

  def search
    @articles = Article.search(params)
    categories = Category.for_articles(@articles)
    @categories_json = Category.children_json(params[:id], categories.map(&:id)).to_json

    respond_to do |format|
      format.html
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

end

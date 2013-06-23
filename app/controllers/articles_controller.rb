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
    # all search results
    all_search_results = Article.search(params.merge({ per_page: 1000 }))
    categories = Category.for_articles(all_search_results)
    @categories_json = Category.children_json(params[:id], categories.map(&:id)).to_json

    # those are only the paginated search results
    @articles = Article.search(params)

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

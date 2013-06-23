class Admin::ArticlesController < Admin::AdminController
  
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  def search
    @articles = Article.search(params.merge({ per_page: 1000 }))
    categories = Category.for_articles(@articles)
    @categories_json = Category.children_json(params[:id], categories.map(&:id)).to_json

    respond_to do |format|
      format.html
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to admin_articles_url, notice: t('articles.flash.created') }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to admin_articles_url, notice: t('articles.flash.updated') + undo_link }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to admin_articles_url, notice: t('articles.flash.deleted') + undo_link }
      format.json { head :no_content }
    end
  end

  private

    def undo_link
      view_context.link_to(view_context.image_tag("undo.png"), revert_version_path(@article.versions.scoped.last), :method => :post, title: 'Undo', class: 'tipped')
    end
end

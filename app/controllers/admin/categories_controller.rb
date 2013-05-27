class Admin::CategoriesController < Admin::AdminController
  
  # GET /categories
  # GET /categories.json
  def index
    respond_to do |format|
      format.html { @categories = Category.all }
      format.json { render json: Category.children_json(params[:id]) }
    end
  end

  def for_articles
    articles = Article.search(params)
    categories = Category.for_articles(articles)
    categories_json = Category.children_json(params[:id], categories.map(&:id))

    respond_to do |format|
      format.json { render json: categories_json }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_url, notice: t("categories.flash.created") }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to admin_categories_url, notice: t("categories.flash.updated") + undo_link }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: t('categories.flash.deleted') + undo_link }
      format.json { head :no_content }
    end
  end

  private

    def undo_link
      view_context.link_to(view_context.image_tag("undo.png"), revert_version_path(@category.versions.scoped.last), :method => :post, title: 'Undo', class: 'tipped')
    end

end

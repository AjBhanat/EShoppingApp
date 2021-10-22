class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all

  end

  # GET /categories/1 or /categories/1.json
  def show
    @child_categories = Category.where(id: CategoryLink.where(parent_id: @category.id).pluck(:category_id))
    @parent_categories = Category.where(id: CategoryLink.where(category_id: @category.id).pluck(:parent_id))
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new()
    @category.name = category_params[:name]
    @category.description = category_params[:description]
    parent_ids = category_params[:parent_ids].reject(&:empty?).map(&:to_i)
    puts(parent_ids)
    respond_to do |format|
      if @category.save
        parent_ids.each do |parent_id|
          puts("parent_id = #{parent_id}")
          @category_link = CategoryLink.new(category_id:@category.id, parent_id: parent_id)
          @category_link.save!
        end
        format.html { redirect_to @category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  #
  # Code not updated as not implementing update method
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.fetch(:category, {})
    end
end

class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.save
    if @list.save
      redirect_to list_path(@list), notice: "List successfully created"
    else
      render :new, status: :unprocessable_entity
    end

      # respond_to do |format|
      #   if @garden.save
      #     format.html { redirect_to garden_url(@garden), notice: "Garden was successfully created." }
      #     format.json { render :show, status: :created, location: @garden }
      #   else
      #     format.html { render :new, status: :unprocessable_entity }
      #     format.json { render json: @garden.errors, status: :unprocessable_entity }
      #   end
      # end

  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end

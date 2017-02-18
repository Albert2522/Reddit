class SubsController < ApplicationController
  before_action :set_sub, only: [:show, :edit, :update, :destroy]

  # GET /subs
  # GET /subs.json
  def index
    @subs = Sub.all
  end

  # GET /subs/1
  # GET /subs/1.json
  def show
    set_sub
  end

  # GET /subs/new
  def new
    @sub = Sub.new
  end

  # GET /subs/1/edit
  def edit
    @sub = Sub.new
  end

  # POST /subs
  # POST /subs.json
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to subs_url
    else
      flash[:error] = @sub.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /subs/1
  # PATCH/PUT /subs/1.json
  def update
    set_sub
      if @sub.update(sub_params)
        redirect_to subs_url
      else
        flash[:error] = @sub.errors.full_messages
        render :edit
      end
  end

  # DELETE /subs/1
  # DELETE /subs/1.json
  def destroy
    set_sub
    @sub.destroy
    redirect_to subs_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub
      @sub = Sub.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_params
      params.require(:sub).permit(:title, :description, :moderator_id, :user_id)
    end
end

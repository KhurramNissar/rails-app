class ManagersController < ApplicationController
  def index
    @managers = Manager.all
  end

  def show
    @manager= Manager.find(params[:id])
  end

  def new
    @manager = Manager.new
  end

  def create
    @manager = Manager.new(manager_params)

    if @manager.save
      redirect_to @manager
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @manager = Manager.find(params[:id])
  end

  def update
    @manager = Manager.find(params[:id])

    if @manager.update(manager_params)
      redirect_to @manager
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def manager_params
      params.require(:manager).permit(:name)
    end
end

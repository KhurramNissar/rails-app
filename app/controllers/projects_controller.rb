class ProjectsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_project
  before_action :set_project, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  # GET /projects or /projects.json
  def index
    # @projects = Project.all
    # @Projects = Project.includes(:task)
    @projects = current_user.projects
  end

  # GET /projects/1 or /projects/1.json
  def show
    @task = @project.tasks.build
    # @emails = @project.users
    # @user = User.find(params[:id])
    # @project = @user.email

  end

  # GET /projects/new
  def new
    @project = current_user.projects.build
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
   
    respond_to do |format| 
      if @project.save

        CurdNotificationMailer.create_notification(@project).deliver_now

        # UserMailer.with(user: @user).welcome_email.deliver_later
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        CurdNotificationMailer.update_notification(@project).deliver_now
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    CurdNotificationMailer.delete_notification(@project).deliver_now

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description, :user_id)
    end
end

class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    send_file @task.filename_output
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    @task.save

    filename = File.join("/tmp", 'test.csv')

    uploaded_io = params[:task][:file_input]

    filename = Rails.root.join('/tmp', @task.id.to_s + "-" + uploaded_io.original_filename)

    File.open(filename, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    @task.status = 'Создана'

    @task.filename_input = filename

    @task.filename_output = Rails.root.join('/tmp', @task.id.to_s + "-output-" + uploaded_io.original_filename)

#    file = File.open(filename,"w"){|f| f.write params[:task][:file_input].read}

#    @task.filename_input = filename

    respond_to do |format|
      if @task.save

        TaskRunningJob.perform_later(@task)

        format.html { redirect_to tasks_url, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    if @task.filename_input != nil 
      File.delete(@task.filename_input) if File.exist?(@task.filename_input)
    end

    if @task.filename_output != nil
      File.delete(@task.filename_output) if File.exist?(@task.filename_output)
    end

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Задача успешно удалена." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:status, :file_input)
    end
end

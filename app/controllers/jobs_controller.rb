class JobsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]
	before_action :find_job, only: [:show, :edit, :update, :destroy]
	
	def index
		if params[:category].blank?
			@jobs = Job.all.order("created_at DESC")
		else
			@category = Category.find_by(name: params[:category])
			@jobs = Job.where(category_id: @category.id).order("created_at DESC")
		end
	end

	def show
		@reviews = Review.where(job_id: @job.id).order("created_at DESC")
	end

	def new
		@job = current_user.jobs.build
	end

	def create
		@job = current_user.jobs.build(jobs_params)
		if @job.save
			redirect_to @job
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @job.update(jobs_params)
			redirect_to @job
		else 
			render :edit
		end
	end

	def destroy
		if @job.destroy
			redirect_to root_path
		end
	end

	private
	 def jobs_params
	 	params.require(:job).permit(:title, :description, :company, :url, :category_id)
	 end

	 def find_job
	 	@job = Job.find(params[:id])
	 end
end

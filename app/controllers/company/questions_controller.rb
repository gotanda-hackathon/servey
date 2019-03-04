class Company::QuestionsController < Company::BaseController

	def index
		@questions = Question.all
	end

	def new
		@question = Question.new
		question_section = @question.question_sections.build
		question_detail = question_section.question_details.build
		question_detail.question_detail_choices.build
	end

	def create
		@user = User.first
		@question = @user.questions.build(admin_question_params)
		if @question.save
			redirect_to company_questions_path
		else
			render :new
		end
	end

	def edit
		@question = Question.find_by(id: params[:id])
	end

	def update
	end

	private
	def admin_question_params
		params[:question] ? params.require(:question).permit(
				Question.permit_params
		) : {}
	end
end

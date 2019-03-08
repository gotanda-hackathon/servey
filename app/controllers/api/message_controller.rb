class Api::MessageController < ApplicationController
	protect_from_forgery :except => [:webhook,:set_session_value]
  before_action :set_session_value

  def set_session_value
		@params = JSON.parse(request.body.read)

		@google = GoogleHomeConversation.order(id: :desc).find_by(conversation_id: @params["originalDetectIntentRequest"]["payload"]["conversation"]["conversationId"])
		@customer = @google.customer if @google
		#mode 0:ログイン 1:ログインコード 2: 設問  4: なし

		@response_start_type = @params["queryResult"]["parameters"]["code"]

		case @google&.mode
			when nil
			when 0
				@response_start_type = 'login_code'
				@google = GoogleHomeConversation.new(conversation_id: @params["originalDetectIntentRequest"]["payload"]["conversation"]["conversationId"], mode: 1, login_code: @params["queryResult"]["queryText"])
				@google.save(validate: false)
			when 1
				@response_start_type = 'password'
				@customer = Customer.find_by(encrypted_password: @params["queryResult"]["queryText"], login_code: @google.login_code)
				@google = GoogleHomeConversation.new(conversation_id: @params["originalDetectIntentRequest"]["payload"]["conversation"]["conversationId"],customer_id: @customer&.id.to_i, mode: 4)
				@google.save(validate: false)
				@opt = {
						customer: @customer&.name,
						point: @customer&.point,
						login_status: @customer.present? ? 'success' : 'failed'
				}
			when 3
			when 4
		end

		if @response_start_type == 'start'
			@opt = {
					customer_id: @google.customer_id
			}
		elsif @response_start_type == 'answer'
			@opt = {
			 			question_detail_id: @google.question_detail_id,
						customer_id: @google.customer_id
			}
		else
			@opt = {} unless @opt
		end
	end

	def webhook
		payload, opt = GoogleHomeApi::WebHook.response_start(@response_start_type, @opt, params)
		p payload

		case @response_start_type
			when 'start'
				@google = GoogleHomeConversation.new(conversation_id: @params["originalDetectIntentRequest"]["payload"]["conversation"]["conversationId"],customer_id: @customer&.id.to_i, mode: 2, question_detail_id: opt[:question_detail_id])
				@google.save(validate: false)
				session[:question_detail_id] = opt[:question_detail_id]
			when 'answer'
				@google = GoogleHomeConversation.new(conversation_id: @params["originalDetectIntentRequest"]["payload"]["conversation"]["conversationId"],customer_id: @customer&.id.to_i, mode: opt[:question_detail_id].present? ? 2 : 4, question_detail_id: opt[:question_detail_id].to_i)
				@google.save(validate: false)
			when 'login'
				@google = GoogleHomeConversation.new(conversation_id: @params["originalDetectIntentRequest"]["payload"]["conversation"]["conversationId"], mode: 0)
				@google.save(validate: false)
			when 'login_code'
		end

		render json: payload.to_json
	end
end
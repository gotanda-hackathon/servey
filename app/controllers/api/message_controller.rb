class Api::MessageController < ApplicationController
	protect_from_forgery :except => [:webhook]
  before_action :set_session_value

  def set_session_value
		case params["queryResult"]["parameters"]["code"]
			when 'start'
				@opt = {
						user_id: session[:user_id]
				}
			when 'answer'
				@opt = {
						question_detail_id: session[:question_detail_id],
						user_id: session[:user_id]
				}
			else
				@opt = {}
		end
	end

	def webhook
		params = JSON.parse(request.body.read)
		p params
		payload, opt = GoogleHomeApi::WebHook.response_start(params["queryResult"]["parameters"]["code"], @opt, params)
		p payload
		case params["queryResult"]["parameters"]["code"]
			when 'start'
				session[:question_detail_id] = opt[:question_detail_id]
			when 'answer'

		end

		render json: payload.to_json
	end
end
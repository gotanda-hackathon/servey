class Api::MessageController < ApplicationController
	protect_from_forgery :except => [:webhook]
	def webhook
		params = JSON.parse(request.body.read)
		p params
		payload = GoogleHomeApi::WebHook.response_start(params["queryResult"]["parameters"]["code"])
		render json: payload.to_json
	end
end
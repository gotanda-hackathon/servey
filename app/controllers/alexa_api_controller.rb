class AlexaApiController < ApplicationController
  protect_from_forgery :except => [:index]
  
  def index
    response = {"question": { "id": 1,
                              "title": "食べ物に関する調査",
                              "question_detail": { "id": 1,
                                                   "title": "アレルギーはありますか",
                                                   "question_detail_choices": { "1": "はい",
                                                                                "2": "いいえ" }
                                                   }
                            }
                }
    render :json => response.to_json
  end
end

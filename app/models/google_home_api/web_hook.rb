class GoogleHomeApi::WebHook
  class << self
    def response_start(code, opt, params)
      send("#{code}_response", opt, params)
    end

    #ログインする
    def login_response(opt, params)
      question = Question.last
      question_section = question.question_sections.first
      question_detail = question_section.question_details.first
      {
          "followupEventInput": {
              "name": "REDEIVED_WEB_HOOK",
              "languageCode": "jp",
              "parameters": {
                  "survey_title": "それでは開始します。#{question.explanation}第1問目です。#{question_detail.title}",
                  "question_detail_id": question_detail.id
              }
          }
      }
    end

    #アンケートに答える
    def start_response(opt, params)
      question = Question.last
      question_section = question.question_sections.first
      question_detail = question_section.question_details.first
      respons_hash = {
          "followupEventInput": {
              "name": "REDEIVED_WEB_HOOK",
              "languageCode": "jp",
              "parameters": {
                  "survey_title": "それでは開始します。第1問目です。#{question.explanation}#{question_detail.title}",
                  "question_detail_id": question_detail.id
              }
          }
      }
      return respons_hash, {question_detail_id: question_detail.id}
    end

    def answer_response(opt, params)
      p opt
      p params
      question_detail = QuestionDetail.find(opt[:question_detail_id])
      if question_detail
        answer_text = params[:queryResult][:parameters][:any]
        if answer_text

        end
      end
      question = Question.last
      question_section = question.question_sections.first
      question_detail = question_section.question_details.first
      respons_hash = {
          "followupEventInput": {
              "name": "REDEIVED_WEB_HOOK",
              "languageCode": "jp",
              "parameters": {
                  "survey_title": "ご回答ありがとうございます。第2問目です。#{question.explanation}#{question_detail.title}",
                  "question_detail_id": question_detail.id
              }
          }
      }
      return respons_hash, {question_detail_id: question_detail.id}
    end
  end
end
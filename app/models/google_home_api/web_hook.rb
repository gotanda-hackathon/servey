class GoogleHomeApi::WebHook
  class << self
    def response_start(code)
      send("#{code}_response")
    end

    #アンケートに答える
    def start_response
      question = Question.last
      question_section = question.question_sections.first
      question_detail = question_section.question_details.first

      {
          "followupEventInput": {
              "name": "REDEIVED_WEB_HOOK",
              "languageCode": "jp",
              "parameters": {
                  "survey_title": "それでは開始します。#{question.title}#{question.explanation}第一問目です。#{question_detail.title}",
                  "question_detail_id": question_detail.id
              }
          }
      }
    end
  end
end
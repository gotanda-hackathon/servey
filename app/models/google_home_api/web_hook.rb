class GoogleHomeApi::WebHook
  class << self
    def response_start(code, opt, params)
      send("#{code}_response", opt, params)
    end

    #ログインする
    def welcome_response(opt, params)
      {
          "followupEventInput": {
              "name": "REDEIVED_WEB_HOOK",
              "languageCode": "jp",
              "parameters": {
                  "survey_title": "こんにちは！アンケートアプリです！説明を聞きたい方は、説明を聞く、ログインする方はログインするとお答えください。",
              }
          }
      }
    end
    #ログインする
    def login_response(opt, params)
      {
          "followupEventInput": {
              "name": "REDEIVED_WEB_HOOK",
              "languageCode": "jp",
              "parameters": {
                  "survey_title": "ログインですね。それではあなたのログインコードを教えてください。",
              }
          }
      }
    end

    def login_code_response(opt, params)
      {
          "followupEventInput": {
              "name": "REDEIVED_WEB_HOOK",
              "languageCode": "jp",
              "parameters": {
                  "survey_title": "次にあなたのパスワードを教えてください。",
              }
          }
      }
    end

    def password_response(opt, params)

      if opt[:login_status] == 'success'
        {
            "followupEventInput": {
                "name": "REDEIVED_WEB_HOOK",
                "languageCode": "jp",
                "parameters": {
                    "survey_title": "#{opt[:customer]}さん、こんにちは。現在のポイント数は#{opt[:point]}ポイントです。アンケートに答えてポイントを貯める場合は、アンケートに答えるとお答えください。",
                }
            }
        }
      else
        {
            "followupEventInput": {
                "name": "REDEIVED_WEB_HOOK",
                "languageCode": "jp",
                "parameters": {
                    "survey_title": "ログインに失敗しました。このままアンケートに答える方はアンケートに答える、再度ログインを試してみる場合は、ログインするとお答えください。",
                }
            }
        }
      end
    end

    #アンケートに答える
    def start_response(opt, params)
      customer = Customer.find(opt[:customer_id].to_i)
      Answer.where(customer_id: customer.id)
      question = Question.where.not(id: Answer.where(customer_id: customer.id).pluck(:question_id)).first
      question_section = question.question_sections.first
      question_detail = question_section.question_details.first
      respons_hash = {
          "followupEventInput": {
              "name": "REDEIVED_WEB_HOOK",
              "languageCode": "jp",
              "parameters": {
                  "survey_title": "#{question.explanation}それでは開始します。#{question_section.explanation}第1問目です。#{question_detail.title}",
              }
          }
      }
      return respons_hash, {question_detail_id: question_detail.id}
    end

    def answer_response(opt, params)
      p customer = Customer.find(opt[:customer_id].to_i)
      p params
      question_detail = QuestionDetail.find(opt[:question_detail_id])
      question_section = question_detail.question_section
      question = question_section.question
      answer = Answer.find_by(question_id: question.id, customer_id: customer.id)
      answer = Answer.new(question_id: question.id, customer_id: customer.id) unless answer
      if question_detail
        answer_text = params[:queryResult][:parameters][:any]
        if answer_text
          answer_detail = answer.answer_details.build(question_detail_id: question_detail.id)
          answer_detail.answer_detail_contents.build(short_description: answer_text)
        end
      end
      answer.save(validate: false)
      customer.point += 1
      customer.save(validate: false)


      next_question_detail = question_section.question_details.order(:id).where("id > ?", question_detail.id).first
      if next_question_detail
        respons_hash = {
            "followupEventInput": {
                "name": "REDEIVED_WEB_HOOK",
                "languageCode": "jp",
                "parameters": {
                    "survey_title": "ご回答ありがとうございます。続いての問題です。#{next_question_detail.title}",
                }
            }
        }
      else
        next_question_section = question.question_sections.order(:id).where("id > ?", question_section.id).first
        if next_question_section
          next_question_detail = next_question_section.question_details.order(:id).first
          respons_hash = {
              "followupEventInput": {
                  "name": "REDEIVED_WEB_HOOK",
                  "languageCode": "jp",
                  "parameters": {
                      "survey_title": "ご回答ありがとうございます。これでセクションは終わりです。続いてのセクションです。#{next_question_section.explanation}#{next_question_detail.title}",
                  }
              }
          }
        else
          respons_hash = {
              "followupEventInput": {
                  "name": "REDEIVED_WEB_HOOK",
                  "languageCode": "jp",
                  "parameters": {
                      "survey_title": "アンケートはこれで全て終了です。お疲れ様でした。#{customer.name}さんの現在のポイントは#{customer.point}ポイントです。続けてアンケートに答える方は、アンケートに答えるとお答えください。",
                  }
              }
          }
        end
      end
      return respons_hash, {question_detail_id: next_question_detail&.id}
    end
  end
end
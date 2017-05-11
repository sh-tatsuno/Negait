class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :company_name, :gender_name, :profile_user_path, :date_judge, :category_name

  def configure_permitted_parameters
  # sign_inのときに、group_keyも許可する
    devise_parameter_sanitizer.permit(:sign_in, keys:[:sex, :company, :nickname])
  # sign_upのときに、group_keyも許可する
    devise_parameter_sanitizer.permit(:sign_up, keys:[:sex, :company, :nickname])
  #account_updateのときに、group_keyも許可する
    devise_parameter_sanitizer.permit(:account_update, keys:[:sex, :company, :nickname])
  end

  def gender_name(num)
    gender_list = ["男性", "女性"]
    return gender_list[num-1]
  end

  def profile_user_path(current_user)
    return user_path(current_user) + "/profile"
  end

  def company_name(num)
    company_list =[
    "RHD リクルートホールディングス",
    "RCA リクルートキャリア",
    "RJB リクルートジョブズ",
    "RSF リクルートスタッフィング",
    "RSC リクルート住まいカンパニー",
    "RMP リクルートマーケティングパートナーズ",
    "RLS リクルートライフスタイル",
    "RMS リクルートマネジメントソリューションズ",
    "RAD リクルートアドミニストレーション",
    "RSC リクルートコミュニケーションズ",
    "RSC リクルートテクノロジーズ",
    "RMT リクルートメディアテクノロジーラボ",
    "Indeed",
    "その他"
    ]
    return company_list[num-1]
  end

  def category_name(name)
    category_list ={
    "colleages" => "仲間募集",
    "study" => "勉強会開催",
    "items" => "物が欲しい/いらない",
    "consultation" => "相談に乗って欲しい",
    "introduction" => "紹介したい人がいる",
    "free_talking" => "よもやま",
    "others" => "その他"
    }
    return category_list[name]
  end

  def date_judge(created_time,days)
    date = (days * (60*60*24) - (Time.now - created_time))
    timeend = 0
    if date < 0
      timeend = 1
    end
    date = (14 * (60*60*24) - (Time.now - created_time))
    day = (date / (60*60*24)).floor
    date -= day * (60*60*24)
    hour = (date / (60*60)).floor
    min = ((date % (60*60))/60).floor
    return {date: "#{day}日#{hour}時間#{min}分", timeend: timeend}
  end

  def support_notification(user_id)
    #user_idを1にする
    update_supportnotification(support_id, 1)
  end

  private
  def update_supportnotification(support_id, num)
    support = Support.find(support_id)
    support.update("notification = #{num}")
  end


end

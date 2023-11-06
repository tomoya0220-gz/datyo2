class AccountsController < ApplicationController
  # GET /register
  def new
      # 新規登録ページを表示する
  end


  # POST /accounts
  def create
    # アカウント作成処理を実行する
    # `rodauth`はRodauthのインスタンスを返します。
    rodauth = RodauthApp.rodauth
    rodauth.create_account(login: params[:email], password: params[:password])

    if rodauth.account_from_login(params[:email])
      # アカウントが正常に作成された後の処理
      # 例えば、ユーザーをアカウント確認ページにリダイレクトさせる
      flash[:success] = "Account created successfully. Please check your email to verify your account."
      redirect_to verify_account_path
    else
      # アカウント作成に失敗した場合の処理
      flash[:error] = "There was a problem creating your account."
      render :new
  end

  # 他のアクション（例: アカウントの検証やパスワードのリセットなど）をここに追加...
end

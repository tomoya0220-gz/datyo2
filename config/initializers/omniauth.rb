Rails.application.config.middleware.use OmniAuth::Builder do
    provider :line, "LINE_KEY", "LINE_SECRET"
end

OmniAuth.config.on_failure = Proc.new do |env|
    # 例外処理をここに記述します
    # env['omniauth.error.type']に失敗の種類が入ります
    # env['omniauth.error.strategy']で失敗したストラテジーを取得可能です

    # 例: エラーページにリダイレクトする
    message_key = env['omniauth.error.type']
    error_description = URI.escape("Authentication error: #{message_key}")
    [302, {'Location' => "/auth/failure?message=#{message_key}&strategy=#{env['omniauth.error.strategy'].name}&description=#{error_description}"}, ['Redirecting...']]

end
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :line, "LINE_KEY", "LINE_SECRET"
end
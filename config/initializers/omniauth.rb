Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "406756120839.apps.googleusercontent.com", "MU5rqznED4POqscKP0SSChhc",
           {
               access_type: 'offline',
               scope: "userinfo.email,https://www.googleapis.com/auth/calendar",
               approval_prompt: "auto"
           }
end
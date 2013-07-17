Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "953710332848.apps.googleusercontent.com", "SNtMHcdphfzU0qVPPUtnexIO",
           {
               access_type: 'offline',
               scope: "userinfo.email,https://www.google.com/calendar/feeds",
               approval_prompt: "auto"
           }
end
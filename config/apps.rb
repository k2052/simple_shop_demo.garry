##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  # enable :sessions
  set :session_secret, '456c5677ad8d4c00be705b630d427bc0b7038286802a269fa6755f603a86b207'
end

# Mounts the core application for this project
Padrino.mount("SimpleShopDemoGarry").to('/')
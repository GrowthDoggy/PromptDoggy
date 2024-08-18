class SettingsController < ApplicationController
  layout 'sidebar'
  def show
    @full_api_key = current_user.api_keys.first&.token
    @masked_api_key = mask_api_key(@full_api_key) if @full_api_key
  end

  private

  def mask_api_key(api_key)
    visible_part = api_key[0, 4]
    hidden_part = "*" * (api_key.length - 4)
    "#{visible_part}#{hidden_part}"
  end
end

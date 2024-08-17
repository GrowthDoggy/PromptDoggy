class Api::BaseController < ApplicationController
  include ApiKeyAuthenticatable
end

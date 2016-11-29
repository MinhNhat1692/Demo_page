class Apikey < ApplicationRecord
  class << self
    def get_admin_api
      key = Apikey.first
      key == nil ? "no" : key.adminapi
    end

    def get_search_only_api
      key = Apikey.first
      key == nil ? "no" : key.soapi
    end
  end
end

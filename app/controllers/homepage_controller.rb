class HomepageController < ApplicationController
  require "tempfile"
  before_action :get_services, only: [:services, :reg]

  def home
  end

  def services
  end

  def reg
  end

  def post_reg
    conn = Faraday.new(url: Settings.server) do |faraday|
      faraday.request :url_encoded
      faraday.request :multipart
      faraday.response :logger
      faraday.adapter :net_http
    end
    img_name = params[:avatar].tempfile
    img = File.open(img_name, "r") { |io| io.read }
    result = Base64.encode64 img
    params[:avatar] = "data:#{params[:avatar].content_type};base64," + result
    res = conn.post "/api/add_customer/#{Apikey.get_admin_api}", params
    if res.status == 200
      @result = JSON.parse res.body
      if @result["message"] == "Success"
        @ordermap = @result["result"]
      end
    end
  end

  def result
    conn = Faraday.new(url: Settings.server) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
    res = conn.get "/api/getResult/#{Apikey.get_search_only_api}", params
    if res.status == 200
      result = JSON.parse res.body
      if result["message"] == "Success"
        @result = result["result"]
      else
        @result = result
      end
      render json: @result
    end
  end

  private
    def get_services
      conn = Faraday.new(url: Settings.server) do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
      res = conn.get "/api/services/#{Apikey.get_search_only_api}"
      if res.status == 200
        @result = JSON.parse res.body
        if @result["message"] == "Success"
          @services = @result["result"]
        else
          @services = []
        end
      end
    end
end

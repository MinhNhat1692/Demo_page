class ApikeysController < ApplicationController
  before_action :get_api_key
  
  def new
  end

  def create
    if @apikey.new_record?
      @apikey = Apikey.new api_params
      if @apikey.valid?
        @apikey.save
        redirect_to root_path
      else
        render "new"
      end
    else
      if @apikey.update api_params
        redirect_to root_path
      else
        render "new"
      end
    end
  end
  
  private
    def get_api_key
      @apikey = Apikey.first.present? ? Apikey.first : Apikey.new
    end

    def api_params
      params.require(:apikey).permit(:appid, :soapi, :mapi, :adminapi)
    end
end

class Api::V1::Merchants::SearchController < ApplicationController
  def show
    search_param = permit_params.to_h.first

    begin

      merchant = Merchant.where("#{search_param[0]} like ?", "%#{search_param[1]}%").limit(1).first

      merchant_data = {
        id: merchant.id,
        type: 'merchant',
        attributes: merchant.attributes
      }

      render json: merchant_data
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :no_content
    end
  end

  private

  def permit_params
    params.except(:controller, :action).permit!
  end
end
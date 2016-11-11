class Api::V1::CepsController < ApplicationController
  def index
    cep = BuscaEndereco.cep((params[:cep].to_s).gsub(/[\.-]/, "")) rescue nil

    respond_to do |format|
      format.json do
        if cep
          render json: { data: cep, status: "ok" }
        else
          render json: { status: "not_found" }
        end
      end
    end
  end
end

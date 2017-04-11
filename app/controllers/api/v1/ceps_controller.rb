# frozen_string_literal: true

module Api
  module V1
    class CepsController < ApplicationController
      def index
        cep = begin
                BuscaEndereco.cep(params[:cep].to_s.gsub(/[\.-]/, ""))
              rescue
                nil
              end

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
  end
end

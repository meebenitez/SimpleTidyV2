class TipsController < ApplicationController

    def index
        @tips = Tip.all
        render json: @tips.to_json, status: 200
    end


    
end


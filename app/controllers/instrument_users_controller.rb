class InstrumentUsersController < ApplicationController
    def create
        skip_authorization
        InstrumentUser.create! user_id: params[:profile_id], instrument_id: params[:instrument_id]
    end

    def destroy
        skip_authorization
        InstrumentUser.where(user_id: params[:profile_id], instrument_id: params[:id]).destroy_all
    end
end

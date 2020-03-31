class InstrumentUsersController < ApplicationController
    def create
        skip_authorization
        InstrumentUser.create! user_id: params[:profile_id], instrument_id: params[:instrument_id]
        # @profile = Profile.find(params[:profile_id])
    end

end

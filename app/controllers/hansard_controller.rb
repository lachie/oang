class HansardController < ApplicationController
  def index
    @dates = Hansard.dates
  end

  def show
    if params[:id][2] == 'minor-heading'
      @section = Section.find(params[:id] * '/')
      return render :action => 'show_section'
    else
      @hansard = Hansard.find(params[:id] * '/')
    end
  end
end

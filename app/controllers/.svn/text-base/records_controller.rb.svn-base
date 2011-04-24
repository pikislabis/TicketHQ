class RecordsController < ApplicationController
  include AuthenticatedSystem
  
  before_filter :authorize
  before_filter :find_record, :only => [:show, :edit, :update, :destroy]
  
  def show
  end
  
  private
    def find_record
      @record = Record.find(params[:id])
    end
end

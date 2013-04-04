class HomeController < ApplicationController
  def index
    # Bugsnag.notify RuntimeError.new("rails2 ohai")
    raise "BROKEN"
    render :text => "worked"
  end
end

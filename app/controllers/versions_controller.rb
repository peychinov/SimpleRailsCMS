class VersionsController < ApplicationController
  def revert
    @version = Version.find(params[:id])
    if @version.reify
      @version.reify.save!
    else
      @version.item.destroy
    end

    action = params[:redo] == 'true' ? "undo" : "redo"
    link = view_context.link_to(view_context.image_tag("#{action}.png"), revert_version_path(@version.next, :redo => !params[:redo]), :method => :post, title: action, class: 'tipped')

    redirect_to :back, :notice => "Undid #{@version.event}. #{link}"
  end
end

class TrashController < ApplicationController
  expose(:trashed) { current_user.incidents.trashed }
  expose(:items) { params[:item_ids] ? trashed.find(params[:item_ids]) : trashed.none  }


  def restore
    items.each(&:restore)
    respond_with items, location: trashcan_url
  end

  def restore_all
    trashed.restore_all
    respond_with trashed, location: incidents_url
  end

  def destroy
    items.each(&:destroy)
    respond_with items, location: trashcan_url
  end

  def empty
    trashed.empty
    respond_with trashed, location: incidents_url
  end
end

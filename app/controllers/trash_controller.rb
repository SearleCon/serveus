class TrashController < ApplicationController
  expose(:trashed, strategy: TrashCanStrategy)

  def restore
    trashed.each(&:restore)
    respond_with trashed, location: trashcan_url
  end

  def restore_all
    trashed.restore_all
    respond_with trashed, location: incidents_url
  end

  def destroy
    trashed.each(&:destroy)
    respond_with trashed, location: trashcan_url
  end

  def empty
    trashed.empty
    respond_with trashed, location: incidents_url
  end
end

class TrashController < ApplicationController
  expose(:trashed){ current_user.incidents.trashed }
  expose(:trash){ trashed.find(params[:id]) }




  def restore
    trash.restore
    redirect_to trashcan_url
  end

  def restore_all

  end

  def destroy
    trash.destroy
    redirect_to trashcan_url
  end

  def empty

  end


end

module Trashable
  extend ActiveSupport::Concern

  included do
    default_scope   -> { where(trashed: false) }
    scope :trashed, -> { where(trashed: true) }
  end

  def trash
    update_column(:trashed, true) and freeze
  end

  def restore
    update_column :trashed, false
  end

  def destroy
    trashed ? super : trash
  end


  module ClassMethods
    def trash_all
      update_all(trashed: true)
    end

    def restore_all
     trashed.update_all(trashed: false)
    end
  end



end
class TrashableGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)
  argument :model_name, type: :string, default: 'User'


  def self.next_migration_number(dirname)
    next_migration_number = current_migration_number(dirname) + 1
  end


  def generate_migration
    migration_template 'migration.rb', File.join('db', 'migrate', file_name)
  end

  private
  def file_name
    "AddTrashedTo#{model_name.tableize.upcase}.rb".underscore
  end

end

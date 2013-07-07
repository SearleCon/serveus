require 'paratrooper'

namespace :deploy do
  desc 'Deploy app in production environment'
  task :production do
    Paratrooper::Deploy.new("serveus").deploy
  end
end
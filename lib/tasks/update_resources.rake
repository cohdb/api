namespace :update_resources do
  desc 'TODO'
  task english: :environment do
    Resources::RelicResources.parse_resources(:english)
  end
end

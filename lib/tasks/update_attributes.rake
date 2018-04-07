namespace :update_attributes do
  desc 'TODO'
  task all: :environment do
    Relic::Attributes::Ebps.parse_attributes
    Relic::Attributes::Sbps.parse_attributes
    Relic::Attributes::Upgrades.parse_attributes
    Relic::Attributes::Abilities.parse_attributes
    Relic::Attributes::Commanders.parse_attributes
    Relic::Attributes::IntelBulletins.parse_attributes
    Relic::Attributes::SkinPacks.parse_attributes
    Relic::Attributes::Faceplates.parse_attributes
    Relic::Attributes::VehicleDecals.parse_attributes
    Relic::Attributes::Fatalities.parse_attributes
  end

  desc 'TODO'
  task ebps: :environment do
    Relic::Attributes::Ebps.parse_attributes
  end

  desc 'TODO'
  task sbps: :environment do
    Relic::Attributes::Sbps.parse_attributes
  end

  desc 'TODO'
  task upgrades: :environment do
    Relic::Attributes::Upgrades.parse_attributes
  end

  desc 'TODO'
  task abilities: :environment do
    Relic::Attributes::Abilities.parse_attributes
  end

  desc 'TODO'
  task commanders: :environment do
    Relic::Attributes::Commanders.parse_attributes
  end

  desc 'TODO'
  task intel_bulletins: :environment do
    Relic::Attributes::IntelBulletins.parse_attributes
  end

  desc 'TODO'
  task skin_packs: :environment do
    Relic::Attributes::SkinPacks.parse_attributes
  end

  desc 'TODO'
  task faceplates: :environment do
    Relic::Attributes::Faceplates.parse_attributes
  end

  desc 'TODO'
  task vehicle_decals: :environment do
    Relic::Attributes::VehicleDecals.parse_attributes
  end

  desc 'TODO'
  task fatalities: :environment do
    Relic::Attributes::Fatalities.parse_attributes
  end
end

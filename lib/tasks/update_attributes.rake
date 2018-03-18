namespace :update_attributes do
  desc 'TODO'
  task all: :environment do
    Attributes::Ebps.parse_attributes
    Attributes::Sbps.parse_attributes
    Attributes::Upgrades.parse_attributes
    Attributes::Abilities.parse_attributes
    Attributes::Commanders.parse_attributes
    Attributes::IntelBulletins.parse_attributes
    Attributes::SkinPacks.parse_attributes
    Attributes::Faceplates.parse_attributes
    Attributes::VehicleDecals.parse_attributes
    Attributes::Fatalities.parse_attributes
  end

  desc 'TODO'
  task ebps: :environment do
    Attributes::Ebps.parse_attributes
  end

  desc 'TODO'
  task sbps: :environment do
    Attributes::Sbps.parse_attributes
  end

  desc 'TODO'
  task upgrades: :environment do
    Attributes::Upgrades.parse_attributes
  end

  desc 'TODO'
  task abilities: :environment do
    Attributes::Abilities.parse_attributes
  end

  desc 'TODO'
  task commanders: :environment do
    Attributes::Commanders.parse_attributes
  end

  desc 'TODO'
  task intel_bulletins: :environment do
    Attributes::IntelBulletins.parse_attributes
  end

  desc 'TODO'
  task skin_packs: :environment do
    Attributes::SkinPacks.parse_attributes
  end

  desc 'TODO'
  task faceplates: :environment do
    Attributes::Faceplates.parse_attributes
  end

  desc 'TODO'
  task vehicle_decals: :environment do
    Attributes::VehicleDecals.parse_attributes
  end

  desc 'TODO'
  task fatalities: :environment do
    Attributes::Fatalities.parse_attributes
  end
end

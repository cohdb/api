# frozen_string_literal: true
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
module CommandTypes
  # Movement
  SCMD_MOVE = 'SCMD_Move'
  CMD_MOVE = 'CMD_Move'
  SCMD_ATTACKMOVE = 'SCMD_AttackMove'
  SCMD_CAPTURE = 'SCMD_Capture'
  SCMD_STOP = 'SCMD_Stop'
  CMD_RALLYPOINT = 'CMD_RallyPoint'
  SCMD_LOAD = 'SCMD_Load'
  CMD_UNLOADSQUADS = 'CMD_UnloadSquads'
  SCMD_UNLOADSQUADS = 'SCMD_UnloadSquads'
  SCMD_UNLOAD = 'SCMD_Unload'
  SCMD_ATTACK = 'SCMD_Attack'
  CMD_ATTACKFROMHOLD = 'CMD_AttackFromHold'
  SCMD_FACE = 'SCMD_Face'
  SCMD_PICKUPSLOTITEM = 'SCMD_PickUpSlotItem'
  SCMD_CAPTURETEAMWEAPON = 'SCMD_CaptureTeamWeapon'
  SCMD_RECREW = 'SCMD_Recrew'

  # Retreat
  SCMD_RETREAT = 'SCMD_Retreat'

  # Reinforce
  SCMD_REINFORCEUNIT = 'SCMD_ReinforceUnit'

  # Units
  CMD_BUILDSQUAD = 'CMD_BuildSquad'

  # Structures
  PCMD_CONSTRUCTSTRUCTURE = 'PCMD_ConstructStructure'
  PCMD_CONSTRUCTFENCE = 'PCMD_ConstructFence'
  PCMD_CONSTRUCTFIELD = 'PCMD_ConstructField'
  SCMD_BUILDSTRUCTURE = 'SCMD_BuildStructure'

  # Abilities
  SCMD_ABILITY = 'SCMD_Ability'
  PCMD_ABILITY = 'PCMD_Ability'
  CMD_ABILITY = 'CMD_Ability'

  # Upgrades
  CMD_UPGRADE = 'CMD_Upgrade'
  SCMD_UPGRADE = 'SCMD_Upgrade'

  # Commander
  PCMD_SETCOMMANDER = 'PCMD_SetCommander'

  # Misc
  CMD_CANCELPRODUCTION = 'CMD_CancelProduction'
  SCMD_CANCELPRODUCTION = 'SCMD_CancelProduction'
  PCMD_AIPLAYER = 'PCMD_AIPlayer'
  PCMD_SURRENDER = 'PCMD_Surrender'
  CMD_DESTROY = 'CMD_Destroy'
  SCMD_DESTROY = 'SCMD_Destroy'

  MOVEMENT_COMMAND_TYPES = Set[SCMD_MOVE,
                               CMD_MOVE,
                               SCMD_ATTACKMOVE,
                               SCMD_CAPTURE,
                               SCMD_STOP,
                               CMD_RALLYPOINT,
                               SCMD_LOAD,
                               CMD_UNLOADSQUADS,
                               SCMD_UNLOADSQUADS,
                               SCMD_UNLOAD,
                               SCMD_ATTACK,
                               CMD_ATTACKFROMHOLD,
                               SCMD_FACE,
                               SCMD_PICKUPSLOTITEM,
                               SCMD_CAPTURETEAMWEAPON,
                               SCMD_RECREW].freeze
  UNIT_COMMAND_TYPES = [CMD_BUILDSQUAD].freeze
  STRUCTURE_COMMAND_TYPES = [PCMD_CONSTRUCTSTRUCTURE,
                             PCMD_CONSTRUCTFENCE,
                             PCMD_CONSTRUCTFIELD].freeze
  UPGRADE_COMMAND_TYPES = [CMD_UPGRADE, SCMD_UPGRADE].freeze
  ABILITY_COMMAND_TYPES = [SCMD_ABILITY,
                           PCMD_ABILITY,
                           CMD_ABILITY].freeze
  COMMANDER_COMMAND_TYPES = [PCMD_SETCOMMANDER].freeze
  RETREAT_COMMAND_TYPES = [SCMD_RETREAT].freeze
  REINFORCE_COMMAND_TYPES = [SCMD_REINFORCEUNIT].freeze

  MOVEMENT = 'Movement'
  UNITS = 'Units'
  STRUCTURES = 'Structures'
  UPGRADES = 'Upgrades'
  ABILITIES = 'Abilities'
  COMMANDER = 'Commander'
  RETREAT = 'Retreat'
  REINFORCE = 'Reinforce'

  def self.entity_name_functions
    unit_entity_name = proc { |entity_id| Relic::Attributes::Sbps.to_localized_string(entity_id, :english) }
    structure_entity_name = proc { |entity_id| Relic::Attributes::Ebps.to_localized_string(entity_id, :english) }
    ability_entity_name = proc { |entity_id| Relic::Attributes::Abilities.to_localized_string(entity_id, :english) }
    upgrade_entity_name = proc { |entity_id| Relic::Attributes::Upgrades.to_localized_string(entity_id, :english) }
    commander_entity_name = proc { |entity_id| Relic::Attributes::Commanders.to_localized_string(entity_id, :english) }
    unk_structure_entity_name = proc { |_| 'UNKNOWN Structure' }

    {
      CMD_BUILDSQUAD => unit_entity_name,
      PCMD_CONSTRUCTSTRUCTURE => structure_entity_name,
      PCMD_CONSTRUCTFENCE => structure_entity_name,
      PCMD_CONSTRUCTFIELD => structure_entity_name,
      SCMD_ABILITY => ability_entity_name,
      PCMD_ABILITY => ability_entity_name,
      CMD_ABILITY => ability_entity_name,
      CMD_UPGRADE => upgrade_entity_name,
      SCMD_UPGRADE => upgrade_entity_name,
      PCMD_SETCOMMANDER => commander_entity_name,
      SCMD_BUILDSTRUCTURE => unk_structure_entity_name
    }
  end

  def self.command_categories
    {
      SCMD_MOVE => MOVEMENT,
      CMD_MOVE => MOVEMENT,
      SCMD_ATTACKMOVE => MOVEMENT,
      SCMD_CAPTURE => MOVEMENT,
      SCMD_STOP => MOVEMENT,
      CMD_RALLYPOINT => MOVEMENT,
      SCMD_LOAD => MOVEMENT,
      CMD_UNLOADSQUADS => MOVEMENT,
      SCMD_UNLOADSQUADS => MOVEMENT,
      SCMD_UNLOAD => MOVEMENT,
      SCMD_ATTACK => MOVEMENT,
      CMD_ATTACKFROMHOLD => MOVEMENT,
      SCMD_FACE => MOVEMENT,
      SCMD_PICKUPSLOTITEM => MOVEMENT,
      SCMD_CAPTURETEAMWEAPON => MOVEMENT,
      SCMD_RECREW => MOVEMENT,
      CMD_BUILDSQUAD => UNITS,
      PCMD_CONSTRUCTSTRUCTURE => STRUCTURES,
      PCMD_CONSTRUCTFENCE => STRUCTURES,
      PCMD_CONSTRUCTFIELD => STRUCTURES,
      SCMD_BUILDSTRUCTURE => STRUCTURES,
      CMD_UPGRADE => UPGRADES,
      SCMD_UPGRADE => UPGRADES,
      SCMD_ABILITY => ABILITIES,
      PCMD_ABILITY => ABILITIES,
      CMD_ABILITY => ABILITIES,
      PCMD_SETCOMMANDER => COMMANDER,
      SCMD_RETREAT => RETREAT,
      SCMD_REINFORCEUNIT => REINFORCE
    }
  end

  def self.command_text_functions
    build = proc { |cmd| "Starts building #{cmd.entity_name}" }
    cancel_produce = proc { |_| 'Cancels production of a unit or upgrade' }
    commander = proc { |cmd| "Selects commander #{cmd.entity_name}" }
    global_upgrade = proc { |cmd| "Begins researching global upgrade #{cmd.entity_name}" }
    squad_upgrade = proc { |cmd| "Begins researching squad upgrade #{cmd.entity_name}" }
    move = proc { |cmd| "Issues move order at (#{cmd.x.round}, #{cmd.z.round})" }
    attack_move = proc { |cmd| "Issues attack move order at (#{cmd.x.round}, #{cmd.z.round})" }
    rally_point = proc { |cmd| "Sets a rally point at (#{cmd.x.round}, #{cmd.z.round})" }
    load = proc { |_| 'Issues squad load order' }
    unload = proc { |_| 'Issues squad unload order' }
    unload_pos = proc { |cmd| "Issues unload order at (#{cmd.x.round}, #{cmd.z.round})" }
    capture = proc { |_| 'Issues capture order' }
    stop = proc { |_| 'Issues stop order' }
    attack = proc { |_| 'Issues attack order' }
    attack_hold = proc { |_| 'Issues attack from hold' }
    destroy = proc { |_| 'Issues destroy order' }
    retreat = proc { |_| 'Retreats a squad' }
    reinforce = proc { |_| 'Reinforces a unit' }
    pick_up = proc { |_| 'Issues an order to pick up a weapon' }
    cap_weapon = proc { |_| 'Issues an order to capture a team weapon' }
    recrew = proc { |_| 'Issues a recrew order' }
    face = proc { |_| 'Issues squad facing order' }
    ai = proc { |_| 'AI has taken control' }
    ability = proc do |cmd|
      result = "Uses ability #{cmd.entity_name}"
      result = "#{result} at (#{cmd.x.round}, #{cmd.z.round})" unless cmd.x.zero? && cmd.y.zero? && cmd.z.zero?
      result
    end
    surrender = proc { |_| 'Issues surrender order' }

    {
      CMD_BUILDSQUAD => build,
      SCMD_BUILDSTRUCTURE => build,
      PCMD_CONSTRUCTSTRUCTURE => build,
      PCMD_CONSTRUCTFENCE => build,
      PCMD_CONSTRUCTFIELD => build,
      CMD_CANCELPRODUCTION => cancel_produce,
      SCMD_CANCELPRODUCTION => cancel_produce,
      PCMD_SETCOMMANDER => commander,
      CMD_UPGRADE => global_upgrade,
      SCMD_UPGRADE => squad_upgrade,
      CMD_MOVE => move,
      SCMD_MOVE => move,
      SCMD_ATTACKMOVE => attack_move,
      CMD_RALLYPOINT => rally_point,
      SCMD_LOAD => load,
      CMD_UNLOADSQUADS => unload,
      SCMD_UNLOADSQUADS => unload,
      SCMD_UNLOAD => unload_pos,
      SCMD_CAPTURE => capture,
      SCMD_STOP => stop,
      SCMD_ATTACK => attack,
      CMD_ATTACKFROMHOLD => attack_hold,
      CMD_DESTROY => destroy,
      SCMD_DESTROY => destroy,
      SCMD_RETREAT => retreat,
      SCMD_REINFORCEUNIT => reinforce,
      SCMD_PICKUPSLOTITEM => pick_up,
      SCMD_CAPTURETEAMWEAPON => cap_weapon,
      SCMD_RECREW => recrew,
      SCMD_FACE => face,
      PCMD_AIPLAYER => ai,
      CMD_ABILITY => ability,
      SCMD_ABILITY => ability,
      PCMD_ABILITY => ability,
      PCMD_SURRENDER => surrender
    }
  end
end
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize

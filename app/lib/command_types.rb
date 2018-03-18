module CommandTypes
  # Movement
  SCMD_MOVE = 'SCMD_Move'.freeze
  CMD_MOVE = 'CMD_Move'.freeze
  SCMD_ATTACKMOVE = 'SCMD_AttackMove'.freeze
  SCMD_CAPTURE = 'SCMD_Capture'.freeze
  SCMD_STOP = 'SCMD_Stop'.freeze
  CMD_RALLYPOINT = 'CMD_RallyPoint'.freeze
  SCMD_LOAD = 'SCMD_Load'.freeze
  CMD_UNLOADSQUADS = 'CMD_UnloadSquads'.freeze
  SCMD_UNLOADSQUADS = 'SCMD_UnloadSquads'.freeze
  SCMD_UNLOAD = 'SCMD_Unload'.freeze
  SCMD_ATTACK = 'SCMD_Attack'.freeze
  CMD_ATTACKFROMHOLD = 'CMD_AttackFromHold'.freeze
  SCMD_FACE = 'SCMD_Face'.freeze
  SCMD_PICKUPSLOTITEM = 'SCMD_PickUpSlotItem'.freeze
  SCMD_CAPTURETEAMWEAPON = 'SCMD_CaptureTeamWeapon'.freeze
  SCMD_RECREW = 'SCMD_Recrew'.freeze

  # Retreat
  SCMD_RETREAT = 'SCMD_Retreat'.freeze

  # Reinforce
  SCMD_REINFORCEUNIT = 'SCMD_ReinforceUnit'.freeze

  # Units
  CMD_BUILDSQUAD = 'CMD_BuildSquad'.freeze

  # Structures
  PCMD_CONSTRUCTSTRUCTURE = 'PCMD_ConstructStructure'.freeze
  PCMD_CONSTRUCTFENCE = 'PCMD_ConstructFence'.freeze
  PCMD_CONSTRUCTFIELD = 'PCMD_ConstructField'.freeze
  SCMD_BUILDSTRUCTURE = 'SCMD_BuildStructure'.freeze

  # Abilities
  SCMD_ABILITY = 'SCMD_Ability'.freeze
  PCMD_ABILITY = 'PCMD_Ability'.freeze
  CMD_ABILITY = 'CMD_Ability'.freeze

  # Upgrades
  CMD_UPGRADE = 'CMD_Upgrade'.freeze
  SCMD_UPGRADE = 'SCMD_Upgrade'.freeze

  # Commander
  PCMD_SETCOMMANDER = 'PCMD_SetCommander'.freeze

  # Misc
  CMD_CANCELPRODUCTION = 'CMD_CancelProduction'.freeze
  SCMD_CANCELPRODUCTION = 'SCMD_CancelProduction'.freeze
  PCMD_AIPLAYER = 'PCMD_AIPlayer'.freeze
  PCMD_SURRENDER = 'PCMD_Surrender'.freeze
  CMD_DESTROY = 'CMD_Destroy'.freeze
  SCMD_DESTROY = 'SCMD_Destroy'.freeze

  MOVEMENT_COMMAND_TYPES = [SCMD_MOVE,
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

  MOVEMENT = 'Movement'.freeze
  UNITS = 'Units'.freeze
  STRUCTURES = 'Structures'.freeze
  UPGRADES = 'Upgrades'.freeze
  ABILITIES = 'Abilities'.freeze
  COMMANDER = 'Commander'.freeze
  RETREAT = 'Retreat'.freeze
  REINFORCE = 'Reinforce'.freeze
end

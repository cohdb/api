class Command < ApplicationRecord
  include CommandTypes

  belongs_to :player

  scope :for_player, ->(player) { player.nil? ? all : where(player: player) }

  def entity_name
    @entity_name ||= if UNIT_COMMAND_TYPES.include?(command_type)
                       Relic::Attributes::Sbps.to_localized_string(entity_id, :english)
                     elsif STRUCTURE_COMMAND_TYPES.include?(command_type)
                       Relic::Attributes::Ebps.to_localized_string(entity_id, :english)
                     elsif ABILITY_COMMAND_TYPES.include?(command_type)
                       Relic::Attributes::Abilities.to_localized_string(entity_id, :english)
                     elsif UPGRADE_COMMAND_TYPES.include?(command_type)
                       Relic::Attributes::Upgrades.to_localized_string(entity_id, :english)
                     elsif COMMANDER_COMMAND_TYPES.include?(command_type)
                       Relic::Attributes::Commanders.to_localized_string(entity_id, :english)
                     elsif command_type == SCMD_BUILDSTRUCTURE
                       'UNKNOWN structure'
                     else
                       "UNHANDLED #{entity_id}"
                     end
  end

  def command_category
    @command_category ||= if MOVEMENT_COMMAND_TYPES.include?(command_type)
                            MOVEMENT
                          elsif UNIT_COMMAND_TYPES.include?(command_type)
                            UNITS
                          elsif (STRUCTURE_COMMAND_TYPES + [SCMD_BUILDSTRUCTURE]).include?(command_type)
                            STRUCTURES
                          elsif UPGRADE_COMMAND_TYPES.include?(command_type)
                            UPGRADES
                          elsif ABILITY_COMMAND_TYPES.include?(command_type)
                            ABILITIES
                          elsif COMMANDER_COMMAND_TYPES.include?(command_type)
                            COMMANDER
                          elsif RETREAT_COMMAND_TYPES.include?(command_type)
                            RETREAT
                          elsif REINFORCE_COMMAND_TYPES.include?(command_type)
                            REINFORCE
                          end
  end

  def command_text
    @command_text ||= case command_type
                      when CMD_BUILDSQUAD, SCMD_BUILDSTRUCTURE, PCMD_CONSTRUCTSTRUCTURE, PCMD_CONSTRUCTFENCE, PCMD_CONSTRUCTFIELD
                        "Starts building #{entity_name}"
                      when CMD_CANCELPRODUCTION, SCMD_CANCELPRODUCTION
                        'Cancels production of a unit or upgrade'
                      when PCMD_SETCOMMANDER
                        "Selects commander #{entity_name}"
                      when CMD_UPGRADE
                        "Begins researching global upgrade #{entity_name}"
                      when SCMD_UPGRADE
                        "Begins researching squad upgrade #{entity_name}"
                      when CMD_MOVE, SCMD_MOVE
                        "Issues move order at (#{x.round}, #{z.round})"
                      when SCMD_ATTACKMOVE
                        "Issues attack move order at (#{x.round}, #{z.round})"
                      when CMD_RALLYPOINT
                        "Sets a rally point at (#{x.round}, #{z.round})"
                      when SCMD_LOAD
                        'Issues squad load order'
                      when CMD_UNLOADSQUADS, SCMD_UNLOADSQUADS
                        'Issues squad unload order'
                      when SCMD_UNLOAD
                        "Issues unload order at (#{x.round}, #{z.round})"
                      when SCMD_CAPTURE
                        'Issues capture order'
                      when SCMD_STOP
                        'Issues stop order'
                      when SCMD_ATTACK
                        'Issues attack order'
                      when CMD_ATTACKFROMHOLD
                        'Issues attack from hold order'
                      when CMD_DESTROY, SCMD_DESTROY
                        'Issues destroy order'
                      when SCMD_RETREAT
                        'Retreats a squad'
                      when SCMD_REINFORCEUNIT
                        'Reinforces a unit'
                      when SCMD_PICKUPSLOTITEM
                        'Issues an order to pick up a weapon'
                      when SCMD_CAPTURETEAMWEAPON
                        'Issues an order to capture a team weapon'
                      when SCMD_RECREW
                        'Issues a recrew order'
                      when SCMD_FACE
                        'Issues squad facing order'
                      when PCMD_AIPLAYER
                        'AI has taken control'
                      when CMD_ABILITY, SCMD_ABILITY, PCMD_ABILITY
                        if x == 0.0 && y == 0.0 && z == 0.0
                          "Uses ability #{entity_name}"
                        else
                          "Uses ability #{entity_name} at (#{x.round}, #{z.round})"
                        end
                      when PCMD_SURRENDER
                        'Issues surrender order'
                      else
                        "Issues #{command_type} with #{entity_name} at #{x&.round(2)} #{y&.round(2)} #{z&.round(2)}"
                      end
  end
end

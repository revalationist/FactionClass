function Player:GetFaction()
  for index, faction in pairs(allFactions) do
    bool, index = faction:IsMember(self)
    if bool then 
      print("Player IS in", faction.Name)
      return faction
    else print("Player is not in", faction.Name) end
  end
  
  return Civilians
end

function Player:MoveFaction(newFaction)
  local faction = self:GetFaction()
  print("Moving player to", newFaction.Name)
  if faction.Name != newFaction.Name then
    faction:RemoveMember(self)
    newFaction:AddMember(self)
  end
end
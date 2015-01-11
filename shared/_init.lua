print("Loading base faction class...")

fTable = {}

class("Faction")

function Faction:__init(args)
  self.Morale = 0
  self.Balance = 0
  self.Members = {}
  self.Name = args
  
  fTable[self.Name] = self
  
  if IsValid(LocalPlayer) then
    Execution = "client"
    print("Constructing faction " .. args .. ": LocalPlayer is valid, execution variable set to client.")
  else
    Execution = "server"
    print("Constructing faction " .. args .. ": LocalPlayer is invalid, execution variable set to server.")
  end
end

function Faction:ThrowError(line, name)
  Console:Print("Illegal attempt to call method " .. name .. " on line " .. line .. ", in script: " .. Execution .. "/_init.lua.", Color.Red)
  Console:Print("This usually means you are trying to change a faction's values, such as balance, from the client.", Color.Red)
end

function Faction:GetName()
  return self.name
end




function Faction:GetMorale()
  return self.Morale
end


function Faction:GetBalance()
  return self.Balance
end


function Faction:GetMembers()
  return self.Members
end

function Faction:GetMemberCount()
  return #self.Members
end


function Faction:IsMember(player)
  for index, value in pairs(self:GetMembers()) do
    if value == player then
      return true, index
    end
  end
  
  return false, -1
end


if not IsValid(LocalPlayer) then
  function Faction:SetBalance(new)
    local eArgs = {}
    eArgs.faction = self
    eArgs.old = self.Balance
    eArgs.new = new
    eArgs.execution = Execution
    
    self.Balance = new
    Network:Broadcast("FactionBalanceChanged", eArgs)
  end
  
  function Faction:SetMorale(new) 
    local eArgs = {}
    eArgs.faction = self.Name
    eArgs.old = self.Morale
    eArgs.new = new
    eArgs.execution = Execution
    
    self.Morale = new
    
    Network:Broadcast("FactionMoraleChanged", eArgs)
  end
  
  function Faction:SetName(new)
    local eArgs = {}
    eArgs.faction = self.Name
    eArgs.old = self.Name
    eArgs.new = new
    eArgs.execution = Execution
    
    Network:Broadcast("FactionNameChanged", eArgs)
    self.name = new
  end
  
  function Faction:AddMember(player)
    print("defining method IsMember")
    local bool, index = self:IsMember(player)
    if not bool then
      table.insert(self.Members, player)
        
      local eArgs = {}
      eArgs.faction = self.Name
      eArgs.player = player
      eArgs.execution = Execution

      Network:Broadcast("PlayerAddedToFaction", eArgs)
      Chat:Send(player, "You have been added to " .. self.Name .. ".", factionColours[self])
    end
  end

  function Faction:RemoveMember(player)
    local bool, index = self:IsMember(player)
    if bool and index > -1 then
      self.Members[index] = nil
      
      local eArgs = {}
      eArgs.faction = self.Name
      eArgs.player = player
      eArgs.execution = Execution
      
      Network:Broadcast("PlayerRemovedFromFaction", eArgs)
      Chat:Send(player, "You have been removed from " .. self.Name .. ".", factionColours[self])
    end
  end

end


Roaches = Faction("Roaches")
Reapers = Faction("Reapers")
UlarBoys = Faction("Ular Boys")
Military = Faction("Panau Armed Forces")
Civilians = Faction("Civilians")

allFactions = {Roaches, Reapers, UlarBoys, Military, Civilians}
factionColours = {[Roaches] = Color.Cyan, [Reapers] = Color.Red, [UlarBoys] = Color.Yellow, [Military] = Color.Green, [Civilians] = Color.Gray}

print("Sucessfully loaded base faction class!")

function Player:GetFaction()
  for i, v in pairs(allFactions) do
    bool, index = v:IsMember(self)
    if bool then return v end
  end
  
  return Civilians
end

Events:Subscribe("ClientModuleLoad", function(args)
    Military:AddMember(args.player)
end)
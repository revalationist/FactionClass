print("Loading client-side factions script...")

<<<<<<< HEAD

=======
>>>>>>> f6db7b226f3ac23449e508dc3877ecd46fb0908e
class("SyncChanges")

function SyncChanges:__init()
  Network:Subscribe("FactionBalanceChanged", self, self.UpdateClientBalance)
  Network:Subscribe("FactionMoraleChanged", self, self.UpdateClientMorale)
  Network:Subscribe("FactionNameChanged", self, self.UpdateName)
  Network:Subscribe("PlayerAddedToFaction", self, self.UpdateForAddition)
  Network:Subscribe("PlayerRemovedFromFaction", self, self.UpdateForRemoval)
end

function SyncChanges:UpdateClientBalance(args)
  print("Received balance change for Roaches")
  local faction = fTable[args.faction]
  faction.Balance = args.new -- make no mistake, client and server balances are seperate. these functions are simply to update client facts as they are to be used for information only
end

function SyncChanges:UpdateClientMorale(args)
  local faction = fTable[args.faction]
  faction.Morale = args.new
end

function SyncChanges:UpdateName(args)
  local faction = fTable[args.faction]
  faction.name = new
end

function SyncChanges:UpdateForAddition(args)
  local faction = fTable[args.faction]
  table.insert(faction.Members, args.player)
end

function SyncChanges:UpdateForRemoval(args)
  local faction = fTable[args.faction]
  local bool, index = faction:IsMember(args.player)
  faction.Members[index] = nil
end

SyncChanges = SyncChanges()


Events:Subscribe("LocalPlayerChat", function(args)
    if args.text == "/roaches" then
      Chat:Print(tostring(Roaches:GetBalance()), Color.Blue)
      return false
    end
    
    return true
end)
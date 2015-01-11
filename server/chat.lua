class("ChatCommands")

function ChatCommands:__init()

  Events:Subscribe("PlayerChat", self, self.Main)
end

function ChatCommands:Main(args)
  args.textSplit = string.split(args.text, " ")
  if args.textSplit[1] == "/deposit" then
    if args.textSplit[2] then
      if tonumber(args.textSplit[2]) ~= nil then
        if args.player:GetMoney() > tonumber(args.textSplit[2]) then
          local faction = args.player:GetFaction()
          faction:SetBalance(faction:GetBalance() + tonumber(args.textSplit[2]))
          Chat:Send(args.player, "You have sucessfully deposited $" .. args.textSplit[2] .. " into the fund of " .. faction:GetName() .. ".", Color.Green)
          args.player:SetMoney(args.player:GetMoney() - tonumber(args.textSplit[2]))
          return false
        else
          Chat:Send(args.player, "Not enough money!", Color.Red)
          return false
        end
      end
    end
  end
  
  if args.textSplit[1] == "/join" then
    success = false
    for i, v in pairs(allFactions) do
      if args.textSplit[2] == string.gsub(v.Name, " ", "") then
        if v.Name != args.player:GetFaction().Name then
          args.player:MoveFaction(v)
          success = true
          return false
        else
          success = true
          return false
        end
      end
    end
    if not success then
      Chat:Send(args.player, "A faction with the name you entered does not exist.", Color.DarkGray)
      return false
    end
  end
  
  if args.text == "/leave" then
    local faction = args.player:GetFaction()
    if faction.Name != Civilians.Name then
      args.player:MoveFaction(Civilians)
      return false
    else
      return false
    end
  end

  
  return true
end

    
ChatCommands = ChatCommands()
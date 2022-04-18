if not SERVER then return end

local names = {""}

local function fetchNames()
    print("[NPCNamer] Fetching names")
    http.Fetch("https://raw.githubusercontent.com/dominictarr/random-name/master/first-names.json", 
        function(body, length, headers, code)
            names = util.JSONToTable(body)
            print("[NPCNamer] Success! Found " .. #names .. " names.")
        end, function(message) 
            names = {}
            print("[NPCNamer] Error! message: " .. message)
        end
    )
end

hook.Add("OnEntityCreated", "namethatmfnpc", function(ent)
    if not IsValid(ent) or not ent:IsNPC() or not ent:GetName() == nil or not ent:GetName() == "" then return end

    local pickName = names[math.random(#names)]
    
    ent:SetNWString("Name", pickName)
    ent:SetName(pickName)
end)

timer.Create("checkIfNPCNamesIsWorking", 10, 0, function() 
    if #names > 2 then print("[NPCNamer] Ending timer.") timer.Remove("checkIfNPCNamesIsWorking") return end
    fetchNames()
end)

concommand.Add("npcnamer_fixnames", function(ply)
    if not ply:IsAdmin() then return end

    fetchNames()
end)

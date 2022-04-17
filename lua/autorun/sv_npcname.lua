if not SERVER then return end
local names = {}
http.Fetch("https://raw.githubusercontent.com/dominictarr/random-name/master/first-names.json", 
    function(body, length, headers, code) 
        names = util.JSONToTable(body) 
    end, function(message) 
        names = {"ERROR"}
        print("[NPCName] Error! message: " .. message)
    end
)

hook.Add("OnEntityCreated", "namethatmfnpc", function(ent)
    if not IsValid(ent) or not ent:IsNPC() or ent:GetName() == nil then return end

    local pickName = names[math.random(#names)]
    
    ent:SetNWString("Name", pickName)
    ent:SetName(pickName)
end)


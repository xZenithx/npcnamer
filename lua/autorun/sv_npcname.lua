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
    if IsValid(ent) then 
        if type(ent) == "NPC" then
            if ent:GetName() == nil then
                ent:SetName(names[math.Round(math.Rand(1,#names))])
            end
        end
    end
end)
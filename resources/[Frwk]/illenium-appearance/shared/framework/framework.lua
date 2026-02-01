Framework = {}

function Framework.ESX()
    return GetResourceState("framework") ~= "missing"
end

function Framework.QBCore()
    return GetResourceState("qb-core") ~= "missing"
end

function Framework.Ox()
    return GetResourceState("ox_core") ~= "missing"
end

function Framework.HasTracker()
    return false
end

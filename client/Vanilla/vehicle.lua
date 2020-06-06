Vehicle = {}
Vehicle.__index = Vehicle

function Vehicle.Create(model, pos, head, network, scriptCheck)
  local newVehicle = {}
  setmetatable(newVehicle, Vehicle)

  if type(model) == "string" then
    model = GetHashKey(model)
  end

  local timeStarted = GetGameTimer() + 5000

  RequestModel(model)
  while not HasModelLoaded(model) do
    Citizen.Wait(0)
    if timeStarted < GetGameTimer() then
      return nil
    end
  end

  newVehicle.Handle = CreateVehicle(model, pos.x, pos.y, pos.z, head, network, scriptCheck)

  return newVehicle
end

function Vehicle.FromHandle(handle)
  local newVehicle = {}
  setmetatable(newVehicle, Vehicle)

  newVehicle.Handle = handle

  return newVehicle
end

function Vehicle.Cast(data)
  return setmetatable(data)
end

function Vehicle:IsEngineRunning()
  return GetIsVehicleEngineRunning(self.Handle)
end

function Vehicle:DoorLockStatus()
  return GetVehicleDoorLockStatus(self.Handle)
end

function Vehicle:GetDirtLevel()
  return GetVehicleDirtLevel(self.Handle)
end

function Vehicle:SetDirtLevel(level)
  SetVehicleDirtLevel(self.Handle, level)
end

function Vehicle:RegisterNetworked()
  if not NetworkGetEntityIsNetworked(self.Handle) then
    NetworkRegisterEntityAsNetworked(self.Handle)
  end
end

function Vehicle:GetNetworkedId()
  self:RegisterNetworked()
  return VehToNet(self.Handle)
end

function Vehicle:CanTiresBurst()
  return GetVehicleTyresCanBurst(self.Handle)
end

function Vehicle:IsTireDamaged(wheel, completely)
  return IsVehicleTyreBurst(self.Handle, wheel, completely)
end

function Vehicle:BurstTire(wheel, onRim, damage)
  SetVehicleTyreBurst(self.Handle, wheel, onRim, damage)
end

function Vehicle:FixWheel(wheel)
  SetVehicleTyreFixed(self.Handle, wheel)
end
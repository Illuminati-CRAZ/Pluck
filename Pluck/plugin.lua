function draw()
    imgui.Begin("Pluck")
    
    state.IsWindowHovered = imgui.IsWindowHovered()

    local snap = state.GetValue("snap") or 4

    _, snap = imgui.InputInt("Snap", snap)

    if imgui.Button("Pluck") then
        for _, object in pairs(state.SelectedHitObjects) do
            if object.EndTime == 0 then --if object is a note, replace with LN
                local timingPoint = map.GetTimingPointAt(object.StartTime)
                local bpm = timingPoint.Bpm
                local mspb = 60000 / bpm
                local length = mspb / snap
                actions.PlaceHitObject(utils.CreateHitObject(object.StartTime, object.Lane, object.StartTime+length, object.HitSound))
                actions.RemoveHitObject(object)
            end
        end
    end

    state.SetValue("snap", snap)

    imgui.End()
end

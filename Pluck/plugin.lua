function draw()
    imgui.Begin("Pluck")

    local snap = state.GetValue("snap") or 4

    local timingPoint = state.CurrentTimingPoint
    local bpm = timingPoint.Bpm
    local mspb = 60000 / bpm
    local length = mspb / snap

    _, snap = imgui.InputInt("Snap", snap)

    if imgui.Button("Pluck") then
        for _, object in pairs(state.SelectedHitObjects) do
            if object.EndTime == 0 then --if object is a note, replace with LN
                actions.PlaceHitObject(utils.CreateHitObject(object.StartTime, object.Lane, object.StartTime+length, object.HitSound))
                actions.RemoveHitObject(object)
            end
        end
    end

    imgui.Text("")
    imgui.Text("BPM: " .. bpm)
    imgui.Text("ms per Beat: " .. mspb)
    imgui.Text("LN Length: " .. length)

    state.SetValue("snap", snap)

    imgui.End()
end

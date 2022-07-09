----- // ESP Library || pluto ☆#0061 // -----

----- // Module Start // -----

local ESP = {_SHIFT = Vector3.new(4.5, 6, 0), BlacklistedObjects = {}, RenderObjects = {}, RenderConnections = {}}
ESP.__index = ESP

----- // Table Functions // -----

function ESP:IsBlacklistedObject(a)
    local x = self.BlacklistedObjects
    if (table.find(x, a)) then
        return (true)
    else
        return (false)
    end
end

function ESP:AddBlacklistedObject(a)
    local x = self.BlacklistedObjects
    if (not table.find(x, a)) then
        table.insert(x, a); return (a)
    end
end

function ESP:RemoveBlacklistedObject(a)
    local x = self.BlacklistedObjects
    if (table.find(x, a)) then
        table.remove(x, table.find(x, a)); return (a)
    end
end

function ESP:ClearBlacklistedObjects(a)
    local x = self.BlacklistedObjects
    local function Clear()
        for _, v in ipairs(x) do
            table.remove(x, v)
        end
        table.clear(x)
    end
    if (a and type(a) == 'number') then
        for i = 1, a do
            Clear()
        end
    elseif (a and a == 'Recursive') then
        repeat
            Clear()
        until (#x <= 0)
    else
        Clear()
    end
end

function ESP:ClearRenderObjects(a)
    local x = self.RenderObjects
    local function Clear()
        for _, v in ipairs(x) do
            v:Remove()
        end
        table.clear(x)
    end
    if (a and type(a) == 'number') then
        for i = 1, a do
            Clear()
        end
    elseif (a and a == 'Recursive') then
        repeat
            Clear()
        until (#x <= 0)
    else
        Clear()
    end
end

function ESP:ClearRenderConnections(a)
    local x = self.RenderConnections
    local function Clear()
        for _, v in ipairs(x) do
            if (typeof(v) == 'RBXScriptConnection' and v.Connected) then
                v:Disconnect()
            end
        end
        table.clear(x)
    end
    if (a and type(a) == 'number') then
        for i = 1, a do
            Clear()
        end
    elseif (a and a == 'Recursive') then
        repeat
            Clear()
        until (#x <= 0)
    else
        Clear()
    end
end

----- // Object Functions // -----

function ESP:GetObjectRender(a)
    local x = game:GetService('Workspace').CurrentCamera
    local _, y = x:WorldToViewportPoint(a.CFrame.Position)
    return (y)
end

function ESP:GetCustomRender(a)
    local x = game:GetService('Workspace').CurrentCamera
    local _, y = x:WorldToViewportPoint(a)
    return (y)
end

function ESP:GetObjectVector(a, b, c)
    local x = game:GetService('Workspace').CurrentCamera
    local y, _ = x:WorldToViewportPoint(a.CFrame.Position)
    if (b and c) then
        return (Vector2.new(y.X - b, y.Y - c))
    end
    return (Vector2.new(y.X, y.Y))
end

function ESP:GetCustomVector(a, b, c)
    local x = game:GetService('Workspace').CurrentCamera
    local y, _ = x:WorldToViewportPoint(a)
    if (b and c) then
        return (Vector2.new(y.X - b, y.Y - c))
    end
    return (Vector2.new(y.X, y.Y))
end

function ESP:SetObjectProperties(a, ...)
    for i, v in pairs({...}) do
        for x, y in pairs(a) do
            v[x] = y
        end
    end
end

----- // Player Functions // -----

function ESP:GetHumanoids(a)
    local x = {}
    local y = game:GetService(a)
    if (a and a == 'Players') then
        for _, v in ipairs(y:GetPlayers()) do
            if (v and v.Character and v.Character:FindFirstChild('Humanoid')) then
                table.insert(x, v.Character:WaitForChild('Humanoid'))
            end
        end
    elseif (a and a == 'Workspace') then
        for _, v in ipairs(y:GetDescendants()) do
            if (v and v:IsA('Humanoid')) then
                table.insert(x, v)
            end
        end
    end
    return (x)
end

function ESP:GetRootParts(a)
    local x = {}
    local y = game:GetService(a)
    if (a and a == 'Players') then
        for _, v in ipairs(y:GetPlayers()) do
            if (v and v.Character and v.Character:FindFirstChild('HumanoidRootPart')) then
                table.insert(x, v.Character:WaitForChild('HumanoidRootPart'))
            end
        end
    elseif (a and a == 'Workspace') then
        for _, v in ipairs(y:GetDescendants()) do
            if (v and v:IsA('BasePart') and v.Name == 'HumanoidRootPart') then
                table.insert(x, v)
            end
        end
    end
    return (x)
end

function ESP:GetMagnitude(a)
    local x = game:GetService('Players').LocalPlayer

    if (not x.Character:FindFirstChild('HumanoidRootPart')) or (not a) then
        return ('Studs')
    end

    return (math.floor((x.Character:WaitForChild('HumanoidRootPart').CFrame.Position - a.CFrame.Position).Magnitude))
end

----- // Deprecated Functions // -----

function ESP:SetTextPosition(a, b, c)
    local x = self._SHIFT or a.Size
    local y = a.CFrame

    local _a = y * CFrame.new(0, c, 0) * CFrame.new(0, x.Y / 2, 0)

    b.Position = ESP:GetCustomVector(_a.Position)
end

function ESP:SetQuadPosition(a, b, c)
    local x = self._SHIFT or a.Size
    local y = a.CFrame

    local _a = y * CFrame.new(0, c, 0) * CFrame.new(x.X / 2, x.Y / 2, 0)
    local _b = y * CFrame.new(0, c, 0) * CFrame.new(-x.X / 2, x.Y / 2, 0)
    local _c = y * CFrame.new(0, c, 0) * CFrame.new(x.X / 2, -x.Y / 2, 0)
    local _d = y * CFrame.new(0, c, 0) * CFrame.new(-x.X / 2, -x.Y / 2, 0)

    b.PointA = ESP:GetCustomVector(_b.Position)
    b.PointB = ESP:GetCustomVector(_a.Position)
    b.PointC = ESP:GetCustomVector(_c.Position)
    b.PointD = ESP:GetCustomVector(_d.Position)
end

----- // Methods // -----

function ESP.new(a, b)
    local x = Drawing.new(a)
    for i, v in pairs(b) do
        x[i] = v
    end
    table.insert(ESP.RenderObjects, x); return (x)
end

function ESP.Create(a, b, ...)
    local x = game:GetService('Workspace')
    local y = {...}
    local z = {
        Part1 = ESP.new('Line', y[1]),
        Part2 = ESP.new('Text', y[2]),
        Part3 = ESP.new('Text', y[3]),
        Part4 = ESP.new('Circle', y[4]),
    }

    local Part5 = ESP.Outline(a, y[1])
    z.Part2.Text = tostring(b)

    local function Update()
        local c
        c = game:GetService('RunService').RenderStepped:Connect(function()
            if (x:IsAncestorOf(a)) then
                if (ESP:GetObjectRender(a)) then
                    z.Part1.To = ESP:GetObjectVector(a)
                    z.Part4.Position = ESP:GetObjectVector(a)
                    z.Part2.Position = ESP:GetObjectVector(a, 0, 40)
                    z.Part3.Position = ESP:GetObjectVector(a, 0, 25)

                    z.Part3.Text = string.format('[%s] [%s]', ESP:GetMagnitude(a), tostring(a.Name))

                    for _, v in pairs(z) do
                        v.Visible = true
                    end
                else
                    for _, v in pairs(z) do
                        v.Visible = false
                    end
                end
            else
                for _, v in pairs(z) do
                    v:Remove()
                end
                c:Disconnect()
            end
        end)
    end
    task.spawn(Update)
end

function ESP.Connect(a, b, ...)
    local x
    local y = {...}
    local function Check(z)
        task.wait()
        if (z and z:IsA('BasePart') and not ESP:IsBlacklistedObject(z)) then
            ESP.Create(z, table.unpack(y)); ESP:AddBlacklistedObject(z)
        end
    end
    if (b and b == 'Children') then
        for _, v in ipairs(a:GetChildren()) do
            Check(v)
        end
        x = a.ChildAdded:Connect(Check)
    elseif (b and b == 'Descendants') then
        for _, v in ipairs(a:GetDescendants()) do
            Check(v)
        end
        x = a.DescendantAdded:Connect(Check)
    end
    table.insert(ESP.RenderConnections, x); return (x)
end

function ESP.Outline(a, b)
    local x = game:GetService('Workspace')
    local y = {
        Part1 = ESP.new('Line', b),
        Part2 = ESP.new('Line', b),
        Part3 = ESP.new('Line', b),
        Part4 = ESP.new('Line', b),
        Part5 = ESP.new('Line', b),
        Part6 = ESP.new('Line', b),
        Part7 = ESP.new('Line', b),
        Part8 = ESP.new('Line', b),
        Part9 = ESP.new('Line', b),
        Part10 = ESP.new('Line', b),
        Part11 = ESP.new('Line', b),
        Part12 = ESP.new('Line', b),
    }

    local function Update()
        local z
        z = game:GetService('RunService').RenderStepped:Connect(function()
            if (x:IsAncestorOf(a)) then
                if (ESP:GetObjectRender(a)) then
                    local _a = a.Size.X / 2
                    local _b = a.Size.Y / 2
                    local _c = a.Size.Z / 2

                    local d = ESP:GetCustomVector(a.CFrame * CFrame.new(-_a, _b, -_c).Position)
                    local e = ESP:GetCustomVector(a.CFrame * CFrame.new(-_a, _b, _c).Position)
                    local f = ESP:GetCustomVector(a.CFrame * CFrame.new(_a, _b, _c).Position)
                    local g = ESP:GetCustomVector(a.CFrame * CFrame.new(_a, _b, -_c).Position)

                    local h = ESP:GetCustomVector(a.CFrame * CFrame.new(-_a, -_b, -_c).Position)
                    local i = ESP:GetCustomVector(a.CFrame * CFrame.new(-_a, -_b, _c).Position)
                    local j = ESP:GetCustomVector(a.CFrame * CFrame.new(_a, -_b, _c).Position)
                    local k = ESP:GetCustomVector(a.CFrame * CFrame.new(_a, -_b, -_c).Position)

                    y.Part1.To = e
                    y.Part1.From = d

                    y.Part2.To = f
                    y.Part2.From = e

                    y.Part3.To = g
                    y.Part3.From = f

                    y.Part4.To = d
                    y.Part4.From = g

                    y.Part5.To = i
                    y.Part5.From = h

                    y.Part6.To = j
                    y.Part6.From = i

                    y.Part7.To = k
                    y.Part7.From = j

                    y.Part8.To = h
                    y.Part8.From = k

                    y.Part9.To = d
                    y.Part9.From = h

                    y.Part10.To = e
                    y.Part10.From = i

                    y.Part11.To = f
                    y.Part11.From = j

                    y.Part12.To = g
                    y.Part12.From = k

                    for _, v in pairs(y) do
                        v.Visible = true
                    end
                else
                    for _, v in pairs(y) do
                        v.Visible = false
                    end
                end
            else
                for _, v in pairs(y) do
                    v:Remove()
                end
                z:Disconnect()
            end
        end)
    end
    task.spawn(Update)
end

function ESP.Highlight(a, b)
    local x = game:GetService('Workspace')
    local y = {
        Part1 = ESP.new('Quad', b),
        Part2 = ESP.new('Quad', b),
        Part3 = ESP.new('Quad', b),
        Part4 = ESP.new('Quad', b),
        Part5 = ESP.new('Quad', b),
        Part6 = ESP.new('Quad', b),
    }

    local function Update()
        local z
        z = game:GetService('RunService').RenderStepped:Connect(function()
            if (x:IsAncestorOf(a)) then
                if (ESP:GetObjectRender(a)) then
                    local _a = a.Size.X / 2
                    local _b = a.Size.Y / 2
                    local _c = a.Size.Z / 2

                    local d = ESP:GetCustomVector(a.CFrame * CFrame.new(-_a, _b, -_c).Position)
                    local e = ESP:GetCustomVector(a.CFrame * CFrame.new(-_a, _b, _c).Position)
                    local f = ESP:GetCustomVector(a.CFrame * CFrame.new(_a, _b, _c).Position)
                    local g = ESP:GetCustomVector(a.CFrame * CFrame.new(_a, _b, -_c).Position)

                    local h = ESP:GetCustomVector(a.CFrame * CFrame.new(-_a, -_b, -_c).Position)
                    local i = ESP:GetCustomVector(a.CFrame * CFrame.new(-_a, -_b, _c).Position)
                    local j = ESP:GetCustomVector(a.CFrame * CFrame.new(_a, -_b, _c).Position)
                    local k = ESP:GetCustomVector(a.CFrame * CFrame.new(_a, -_b, -_c).Position)

                    y.Part1.PointA = d
                    y.Part1.PointB = e
                    y.Part1.PointC = f
                    y.Part1.PointD = g

                    y.Part2.PointA = h
                    y.Part2.PointB = i
                    y.Part2.PointC = j
                    y.Part2.PointD = k

                    y.Part3.PointA = d
                    y.Part3.PointB = e
                    y.Part3.PointC = i
                    y.Part3.PointD = h

                    y.Part4.PointA = e
                    y.Part4.PointB = f
                    y.Part4.PointC = j
                    y.Part4.PointD = i

                    y.Part5.PointA = f
                    y.Part5.PointB = g
                    y.Part5.PointC = k
                    y.Part5.PointD = j

                    y.Part6.PointA = g
                    y.Part6.PointB = d
                    y.Part6.PointC = h
                    y.Part6.PointD = k

                    for _, v in pairs(y) do
                        v.Visible = true
                    end
                else
                    for _, v in pairs(y) do
                        v.Visible = false
                    end
                end
            else
                for _, v in pairs(y) do
                    v:Remove()
                end
                z:Disconnect()
            end
        end)
    end
    task.spawn(Update)
end

function ESP.Spotlight(a, b)
    local x = Instance.new('Highlight')

    if (b) then
        for i, v in pairs(b) do
            x[i] = v
        end
    end

    if (not x.Parent) then
        x.Parent = a
    end

    return (x)
end

return (ESP)

----- // Module End // -----

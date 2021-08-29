---------- // ESP Library || ophiuchus#1234 // ----------

----- // Module Start // -----

local ESP = {PointerShift = Vector3.new(4.5, 6, 0), RenderObjects = setmetatable({}, {__mode = 'kv'})}
ESP.__index = ESP

----- // Functions // -----

function ESP:ClearRenderObjects()
    local x = self.RenderObjects
    repeat
        for i, _ in pairs(x) do
            x[i]:Remove(); table.remove(x, i)
        end
    until (not x[1])
end

function ESP:GetAllHumanoids()
    local x = {}
    local y = game:GetService('Workspace')
    for _, v in pairs(y:GetDescendants()) do
        if (v and v:IsA('Humanoid')) then
            table.insert(x, v)
        end
    end
    return (x)
end

function ESP:GetAllRootParts()
    local x = {}
    local y = game:GetService('Workspace')
    for _, v in pairs(y:GetDescendants()) do
        if (v and v:IsA('BasePart') and v.Name == 'HumanoidRootPart') then
            table.insert(x, v)
        end
    end
    return (x)
end

function ESP:GetCustomRender(a)
    local x = game:GetService('Workspace').CurrentCamera
    local _, y = x:WorldToViewportPoint(a)
    return (y)
end

function ESP:GetObjectRender(a)
    local x = game:GetService('Workspace').CurrentCamera
    local _, y = x:WorldToViewportPoint(a.Position)
    return (y)
end

function ESP:GetCustomVector(a, b, c)
    local x = game:GetService('Workspace').CurrentCamera
    local y, _ = x:WorldToViewportPoint(a)
    if (b and c) then
        return (Vector2.new(y.X - b, y.Y - c))
    end
    return (Vector2.new(y.X, y.Y))
end

function ESP:GetObjectVector(a, b, c)
    local x = game:GetService('Workspace').CurrentCamera
    local y, _ = x:WorldToViewportPoint(a.Position)
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
    return (true)
end

----- // Object-Specific Functions // ------

function ESP:SetQuadrilateralPointers(a, b, c)
    local x = self.PointerShift or a.Size
    local y = a.CFrame

    local _a = y * CFrame.new(0, c, 0) * CFrame.new(x.X / 2, x.Y / 2, 0)
    local _b = y * CFrame.new(0, c, 0) * CFrame.new(-x.X / 2, x.Y / 2, 0)
    local _c = y * CFrame.new(0, c, 0) * CFrame.new(x.X / 2, -x.Y / 2, 0)
    local _d = y * CFrame.new(0, c, 0) * CFrame.new(-x.X / 2, -x.Y / 2, 0)

    local _e = ESP:GetCustomVector(_a.Position)
    local _f = ESP:GetCustomVector(_b.Position)
    local _g = ESP:GetCustomVector(_c.Position)
    local _h = ESP:GetCustomVector(_d.Position)

    b.PointA = Vector2.new(_f.X, _f.Y)
    b.PointB = Vector2.new(_e.X, _e.Y)
    b.PointC = Vector2.new(_g.X, _g.Y)
    b.PointD = Vector2.new(_h.X, _h.Y)
end

function ESP:SetTextPointers(a, b, c)
    local x = self.PointerShift or a.Size
    local y = a.CFrame

    local _a = y * CFrame.new(0, c, 0) * CFrame.new(0, x.Y / 2, 0)
    local _b = ESP:GetCustomVector(_a.Position)

    b.Position = Vector2.new(_b.X, _b.Y)
end

----- // Methods // -----

function ESP.new(a, b)
    local x = Drawing.new(a)
    for i, v in pairs(b) do
        x[i] = v
    end
    table.insert(ESP.RenderObjects, x); return (x)
end

function ESP.Outline(a, b)
    local x = game:GetService('Workspace')
    local Drawings = {
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

    local c
    c = game:GetService('RunService').RenderStepped:Connect(function()
        if (x:IsAncestorOf(a)) then
            local y, z = ESP:GetObjectVector(a), ESP:GetObjectRender(a)
            if (z) then
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

                Drawings.Part1.To = e
                Drawings.Part1.From = d

                Drawings.Part2.To = f
                Drawings.Part2.From = e

                Drawings.Part3.To = g
                Drawings.Part3.From = f

                Drawings.Part4.To = d
                Drawings.Part4.From = g

                Drawings.Part5.To = i
                Drawings.Part5.From = h

                Drawings.Part6.To = j
                Drawings.Part6.From = i

                Drawings.Part7.To = k
                Drawings.Part7.From = j

                Drawings.Part8.To = h
                Drawings.Part8.From = k

                Drawings.Part9.To = d
                Drawings.Part9.From = h

                Drawings.Part10.To = e
                Drawings.Part10.From = i

                Drawings.Part11.To = f
                Drawings.Part11.From = j

                Drawings.Part12.To = g
                Drawings.Part12.From = k

                for _, v in pairs(Drawings) do
                    v.Visible = true
                end
            else
                for _, v in pairs(Drawings) do
                    v.Visible = false
                end
            end
        else
            for _, v in pairs(Drawings) do
                v:Remove()
            end
            c:Disconnect()
        end
    end)
end

function ESP.Highlight(a, b)
    local x = game:GetService('Workspace')
    local Drawings = {
        Part1 = ESP.new('Quad', b),
        Part2 = ESP.new('Quad', b),
        Part3 = ESP.new('Quad', b),
        Part4 = ESP.new('Quad', b),
        Part5 = ESP.new('Quad', b),
        Part6 = ESP.new('Quad', b),
    }

    local c
    c = game:GetService('RunService').RenderStepped:Connect(function()
        if (x:IsAncestorOf(a)) then
            local y, z = ESP:GetObjectVector(a), ESP:GetObjectRender(a)
            if (z) then
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

                Drawings.Part1.PointA = d
                Drawings.Part1.PointB = e
                Drawings.Part1.PointC = f
                Drawings.Part1.PointD = g

                Drawings.Part2.PointA = h
                Drawings.Part2.PointB = i
                Drawings.Part2.PointC = j
                Drawings.Part2.PointD = k

                Drawings.Part3.PointA = d
                Drawings.Part3.PointB = e
                Drawings.Part3.PointC = i
                Drawings.Part3.PointD = h

                Drawings.Part4.PointA = e
                Drawings.Part4.PointB = f
                Drawings.Part4.PointC = j
                Drawings.Part4.PointD = i

                Drawings.Part5.PointA = f
                Drawings.Part5.PointB = g
                Drawings.Part5.PointC = k
                Drawings.Part5.PointD = j

                Drawings.Part6.PointA = g
                Drawings.Part6.PointB = d
                Drawings.Part6.PointC = h
                Drawings.Part6.PointD = k

                for _, v in pairs(Drawings) do
                    v.Visible = true
                end
            else
                for _, v in pairs(Drawings) do
                    v.Visible = false
                end
            end
        else
            for _, v in pairs(Drawings) do
                v:Remove()
            end
            c:Disconnect()
        end
    end)
end

return (ESP)

----- // Module End // -----

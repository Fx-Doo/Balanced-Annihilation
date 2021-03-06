
function widget:GetInfo()
	return {
		name      = 'Energy Conversion Info',
		desc      = 'Displays energy conversion info',
		author    = 'Niobium',
		date      = 'May 2011',
		license   = 'GNU GPL v2',
		layer     = 0,
		enabled   = true,
	}
end

--------------------------------------------------------------------------------
-- Var
--------------------------------------------------------------------------------
local enableAsSpec = true

local alterLevelFormat = string.char(137) .. '%i'

local customScale			= 0.85
local bgcorner				= ":n:"..LUAUI_DIRNAME.."Images/bgcorner.png"
local barbg					= ":n:"..LUAUI_DIRNAME.."Images/resbar.dds"
local barGlowCenterTexture = LUAUI_DIRNAME.."Images/barglow-center.dds"
local barGlowEdgeTexture = LUAUI_DIRNAME.."Images/barglow-edge.dds"
local sliderMinimum			= 12
local sliderMaximum			= 88

local customPanelWidth 		= 115
local customPanelHeight 	= 37
local customPanelPadding	= 4
local customFontSize 		= 12

local xRelPos, yRelPos		= 0.88, 0.966
local vsx, vsy				= gl.GetViewSizes()
local widgetScale			= customScale
local panelWidth 			= customPanelWidth
local panelHeight 			= customPanelHeight
local panelPadding			= customPanelPadding
local fontSize				= customFontSize
local xPos, yPos            = xRelPos*vsx, yRelPos*vsy
local curLevel				= 0

--------------------------------------------------------------------------------
-- Speedups
--------------------------------------------------------------------------------
local format = string.format

local glBeginText = gl.BeginText
local glEndText = gl.EndText
local glTranslate			= gl.Translate
local glColor				= gl.Color
local glPushMatrix			= gl.PushMatrix
local glPopMatrix			= gl.PopMatrix
local glTexture				= gl.Texture
local glRect				= gl.Rect
local glTexRect				= gl.TexRect
local glText				= gl.Text
local glGetTextWidth		= gl.GetTextWidth
local glCreateList			= gl.CreateList
local glCallList			= gl.CallList
local glDeleteList			= gl.DeleteList
local enabled				= true

local spGetMyTeamID = Spring.GetMyTeamID
local spGetTeamRulesParam = Spring.GetTeamRulesParam
local spSendLuaRulesMsg = Spring.SendLuaRulesMsg
local spGetSpectatingState = Spring.GetSpectatingState

local myPlayerID = Spring.GetMyPlayerID()
local _, _, spec, _, _, _, _, _ = Spring.GetPlayerInfo(myPlayerID)

--------------------------------------------------------------------------------
-- Funcs
--------------------------------------------------------------------------------

function widget:PlayerChanged()
	_, _, spec, _, _, _, _, _ = Spring.GetPlayerInfo(myPlayerID)
	if spec and not enableAsSpec then
		widgetHandler:RemoveWidget()
	end
	createList()
end

function widget:Initialize()
	
	if ( spec == true and not enableAsSpec) then
		Spring.Echo("<Energy Conversion Info> Spectator mode. Widget removed.")
		widgetHandler:RemoveWidget()
	else
		processGuishader()
	end
	
	dList = gl.CreateList(function()end)
end

function processGuishader()
	if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].InsertRect(xPos-panelPadding, yPos-panelPadding, xPos+panelWidth+panelPadding, yPos+panelHeight+panelPadding, 'energyconversion')
	end
end

function widget:Shutdown()
	if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].RemoveRect('energyconversion')
	end
end


local function DrawRectRound(px,py,sx,sy,cs)
	gl.TexCoord(0.8,0.8)
	gl.Vertex(px+cs, py, 0)
	gl.Vertex(sx-cs, py, 0)
	gl.Vertex(sx-cs, sy, 0)
	gl.Vertex(px+cs, sy, 0)
	
	gl.Vertex(px, py+cs, 0)
	gl.Vertex(px+cs, py+cs, 0)
	gl.Vertex(px+cs, sy-cs, 0)
	gl.Vertex(px, sy-cs, 0)
	
	gl.Vertex(sx, py+cs, 0)
	gl.Vertex(sx-cs, py+cs, 0)
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.Vertex(sx, sy-cs, 0)
	
	local offset = 0.05		-- texture offset, because else gaps could show
	local o = offset
	
	-- top left
	if py <= 0 or px <= 0 then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, py, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(px+cs, py, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(px+cs, py+cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(px, py+cs, 0)
	-- top right
	if py <= 0 or sx >= vsx then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, py, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(sx-cs, py, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(sx-cs, py+cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(sx, py+cs, 0)
	-- bottom left
	if sy >= vsy or px <= 0 then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, sy, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(px+cs, sy, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(px+cs, sy-cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(px, sy-cs, 0)
	-- bottom right
	if sy >= vsy or sx >= vsx then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, sy, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(sx-cs, sy, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(sx, sy-cs, 0)
end

function RectRound(px,py,sx,sy,cs)
	local px,py,sx,sy,cs = math.floor(px),math.floor(py),math.ceil(sx),math.ceil(sy),math.floor(cs)
	
	gl.Texture(bgcorner)
	gl.BeginEnd(GL.QUADS, DrawRectRound, px,py,sx,sy,cs)
	gl.Texture(false)
end

function createList(force)

	local newCurLevel = spGetTeamRulesParam(spGetMyTeamID(), 'mmLevel')
	if (newCurLevel ~= curLevel or force) and type(newCurLevel) == 'number' then
		curLevel = newCurLevel
		
		if dList ~= nil then
			gl.DeleteList(dList)
		end
		
		local sliderX = (panelWidth-(panelPadding*4)) * curLevel
		
		dList = gl.CreateList(function()
			gl.PushMatrix()
				
				-- Panel
				glColor(0, 0, 0, 0.6)
				--glRect(0, 0, panelWidth, panelHeight)
				RectRound(xPos-panelPadding, yPos-panelPadding, xPos+panelWidth+panelPadding, yPos+panelHeight+panelPadding, 6*widgetScale)
				
				local borderPadding = 3.3*widgetScale
				glColor(1,1,1,0.022)
				RectRound(xPos-panelPadding+borderPadding, yPos-panelPadding+borderPadding, xPos+panelWidth+panelPadding-borderPadding, yPos+panelHeight+panelPadding-borderPadding, 5*widgetScale)
				
				glTranslate(xPos, yPos, 0)
				-- Text
				glColor(1, 1, 1, 1)
				glBeginText()
					glText('Energy Conversion',panelPadding, panelHeight-panelPadding-fontSize, fontSize, 'od')
				glEndText()
				
				-- Bar
				glColor(0,0,0, 0.11)
				glRect((panelWidth-(panelPadding*2))+(1*widgetScale), panelPadding+(panelHeight/7.5)-(1*widgetScale), (panelPadding*2)-(1*widgetScale), panelPadding+(panelHeight/4.7)+(1*widgetScale))
				glColor(1,1,1,1)
				glTexture(barbg)
				glTexRect((panelWidth-(panelPadding*2)), panelPadding+(panelHeight/7.5), panelPadding*2, panelPadding+(panelHeight/4.7))
				
				glColor(1, 1, 0, 0.77)
				glTexture(barbg)
				glTexRect(sliderX + (panelPadding*2), panelPadding+(panelHeight/7.5), panelPadding*2, panelPadding+(panelHeight/4.7))
				
				-- bar glow
				glowSize = (((panelHeight/7.5)-1) - ((panelHeight/4.7)+1)) * 3
				glColor(1, 1, 0, 0.06)
				glTexture(barGlowCenterTexture)
				glTexRect(sliderX + (panelPadding*2), panelPadding+(panelHeight/7.5) - glowSize, panelPadding*2, panelPadding+(panelHeight/4.7) + glowSize)
				glTexture(barGlowEdgeTexture)
				glTexRect(panelPadding*2+(glowSize*2), panelPadding+(panelHeight/7.5) - glowSize, panelPadding*2, panelPadding+(panelHeight/4.7) + glowSize)
				glTexRect(sliderX + (panelPadding*2) - (glowSize*2), panelPadding+(panelHeight/7.5) - glowSize, sliderX + (panelPadding*2), panelPadding+(panelHeight/4.7) + glowSize)
				
				-- Slider
				glTexture(barbg)
				glColor(0, 0, 0, 0.25)
				glRect(sliderX + (panelPadding*2) + (panelWidth/50)+1, panelPadding-1, sliderX + (panelPadding*2) - (panelWidth/50)-1, panelPadding+(panelHeight/3.1)+1)
				glColor(0.88, 0.88, 0.1, 1)
				glTexRect(sliderX + (panelPadding*2)  + (panelWidth/50), panelPadding, sliderX + (panelPadding*2) - (panelWidth/50), panelPadding+(panelHeight/3.1))
				glTexture(false)
				
			gl.PopMatrix()
		end)
	end
end

function widget:DrawScreen()
	gl.CallList(dList)
end

local sec = 0
local updateTime = 1
function widget:Update(dt)
	sec=sec+dt
	if (sec>1/updateTime) then
		sec = 0
		
		local newCurLevel = spGetTeamRulesParam(spGetMyTeamID(), 'mmLevel')
		if newCurLevel ~= curLevel then
			createList()
		end
	end
end

function widget:TweakMousePress(mx, my, mButton)
    if mButton == 2 or mButton == 3 then
        if mx >= xPos and my >= yPos and mx < xPos + panelWidth and my < yPos + panelHeight then
            return true
        end
    end
end
local draggingSlider = false
function widget:MousePress(mx, my, mButton)
	if mButton == 1 and not spGetSpectatingState() then
        local dx, dy = mx - xPos, my - yPos
        
        local hoverRight	= panelWidth-(panelPadding*2)
        local hoverBottom	= 0-customPanelPadding
        local hoverLeft		= panelPadding*2
        local hoverTop		= panelHeight+customPanelPadding
        if dx >= hoverLeft and dy >= hoverBottom and dx < hoverRight and dy < hoverTop then
            local newShare = 100 * (dx - hoverLeft) / (hoverRight - hoverLeft) -- [0, 100)
            if newShare < sliderMinimum then
				newShare = sliderMinimum
			end
            if newShare > sliderMaximum then
				newShare = sliderMaximum
			end
            spSendLuaRulesMsg(format(alterLevelFormat, newShare))
            draggingSlider = true
            createList(true)
            return true
        end
    end
end

function widget:TweakMouseMove(mx, my, dx, dy, mButton)
    -- Dragging widget position
    if mButton == 2 or mButton == 3 then
		if xPos + dx >= panelPadding and xPos + panelWidth + dx + panelPadding<= vsx then 
			xRelPos = xRelPos + dx/vsx
		end
		if yPos + dy >= panelPadding and yPos + panelHeight + dy + panelPadding<= vsy then 
			yRelPos = yRelPos + dy/vsy
		end
		xPos, yPos = xRelPos * vsx,yRelPos * vsy
		
		processGuishader()
		createList(true)
    end
end

function widget:MouseMove(mx, my, dx, dy, mButton)
	if mButton == 1 and draggingSlider then
        local dx, dy = mx - xPos, my - yPos
        local hoverRight	= panelWidth-(panelPadding*2)
        local hoverLeft		= panelPadding*2
		local newShare = 100 * (dx - hoverLeft) / (hoverRight - hoverLeft) -- [0, 100)
		if newShare < sliderMinimum then
			newShare = sliderMinimum
		end
		if newShare > sliderMaximum then
			newShare = sliderMaximum
		end
		if newShare > 100 then newShare = 100 end
		spSendLuaRulesMsg(format(alterLevelFormat, newShare))
		createList(true)
	end
end

function widget:MouseRelease(mx, my, dx, dy, mButton)
	if draggingSlider then
		draggingSlider = false
	end
end

function widget:IsAbove(mx, my)
	local xPos = xPos-panelPadding
	local yPos = yPos-panelPadding
	local x2Pos = xPos+panelWidth+panelPadding
	local y2Pos = yPos+panelHeight+panelPadding
	return mx > xPos and my > yPos and mx < x2Pos and my < y2Pos
end

function widget:GetTooltip(mx, my)
	if widget:IsAbove(mx,my) then
		return string.format("In CTRL+F11 mode: Hold \255\255\255\1middle mouse button\255\255\255\255 to drag this display.\n\n"..
			"This controls when your metalmakers convert energy into metal.\n\nClick on it or drag to set a new value.")
	end
end

function widget:ViewResize(newX,newY)
	vsx, vsy = newX, newY
	xPos, yPos = xRelPos * vsx,yRelPos * vsy
	
	widgetScale		= (0.60 + (vsx*vsy / 5000000)) * customScale
	panelWidth 		= customPanelWidth * widgetScale
	panelHeight		= customPanelHeight * widgetScale
	panelPadding	= customPanelPadding * widgetScale
	fontSize		= customFontSize * widgetScale
	
	processGuishader()
	
	if dList ~= nil then
		gl.DeleteList(dList)
	end
	createList(true)
end

function widget:GetConfigData()
	return {xRelPos = xRelPos, yRelPos = yRelPos}
end

function widget:SetConfigData(data)
	xRelPos = data.xRelPos or xRelPos
	yRelPos = data.yRelPos or yRelPos
	xPos = xRelPos * vsx
	yPos = yRelPos * vsy
end

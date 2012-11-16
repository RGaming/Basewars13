function hud() -- Consider functions like a cyber button, and everything INSIDE the function turns on when this cyber button is pressed.
	local health = LocalPlayer():Health()
	draw.RoundedBox(0, 5, ScrH() - 15 - 20, health, 15, Color(255,0,0,255))
	draw.SimpleText(health, "default", 10, ScrH() - 15 - 40, Color(255,255,255,255))
	draw.SimpleText("Health", "default", 10, ScrH() - 40, Color(255,255,255,255))
end 
hook.Add("HUDPaint", "MyHudName", hud) -- I'll explain hooks and functions in a second
 
function hidehud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideOurHud:D", hidehud)
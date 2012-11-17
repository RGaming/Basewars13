function hud() -- Consider functions like a cyber button, and everything INSIDE the function turns on when this cyber button is pressed.
	local health = LocalPlayer():Health()
	local money = LocalPlayer():GetNWInt("Money", 0)
	draw.RoundedBox(0, 5, ScrH() - 15 - 20, health, 15, Color(255,0,0,255))
	draw.SimpleText(health, "default", 10 + health, ScrH() - 15 - 20, Color(255,255,255,255))
	draw.SimpleText("Health", "default", 10, ScrH() - 15 - 20, Color(255,255,255,255))
	draw.SimpleText("Money ", "default", 10, ScrH() - 50, Color(0,255,0,255))
	draw.SimpleText(money, "default", 50, ScrH() - 50, Color(0,255,0,255))
end 
hook.Add("HUDPaint", "MyHudName", hud) -- I'll explain hooks and functions in a second
 
function hidehud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideOurHud:D", hidehud)
if SERVER then
	resource.AddFile( "resource/fonts/zektonrg.ttf" )
	return
end

surface.CreateFont( "InteractFont", {
	font = "Zekton Rg",
	size = 30,
	weight = 500,
})
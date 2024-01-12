if SERVER then
	resource.AddFile( "resource/fonts/monofonto.ttf" )
	return
end

surface.CreateFont( "FalloutFont", {
	font = "Monofonto",
	size = 30,
	weight = 500,
	shadow = true,
})
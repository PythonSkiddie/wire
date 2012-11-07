WireToolSetup.setCategory( "Detection" )
WireToolSetup.open( "gyroscope", "Gyroscope", "gmod_wire_gyroscope", nil, "Gyroscopes" )

if CLIENT then
	language.Add( "Tool.wire_gyroscope.name", "Gyroscope Tool (Wire)" )
	language.Add( "Tool.wire_gyroscope.desc", "Spawns a gyroscope for use with the wire system." )
	language.Add( "Tool.wire_gyroscope.0", "Primary: Create/Update Gyroscope" )
	language.Add( "Tool.wire_gyroscope.out180", "Output -180 to 180 instead of 0 to 360" )
end
WireToolSetup.BaseLang()
WireToolSetup.SetupMax( 10, TOOL.Mode.."s" , "You've hit the Wire "..TOOL.PluralName.." limit!" )

if SERVER then
	ModelPlug_Register("GPS")
	
	function TOOL:GetConVars() 
		return tobool(self:GetClientNumber("out180"))
	end

	function TOOL:MakeEnt( ply, model, Ang, trace )
		return MakeWireGyroscope( ply, trace.HitPos, Ang, model, self:GetConVars() )
	end
end

TOOL.ClientConVar = {
	model = "models/bull/various/gyroscope.mdl",
	out180 = 0,
}

function TOOL.BuildCPanel(panel)
	panel:Help("#Tool.wire_gyroscope.desc")
	ModelPlug_AddToCPanel(panel, "gyroscope", "wire_gyroscope")
	panel:CheckBox("#Tool.wire_gyroscope.out180","wire_gyroscope_out180")
end
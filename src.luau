local Math = {};

function Math.vec3( value )
	local t = typeof( value );

	if ( t == "function" ) then
		value = value();
		
		if ( value == nil ) then
			error("FUNCTION RETURNED NIL (EXPECTED VECTOR3 LIKE)", 2);
		end
		
		t = typeof( value );
	end

	if ( t == "Vector3" ) then
		return value;
	end

	if ( t == "CFrame" ) then
		return value.Position;
	end

	if ( t == "Instance" ) then
		if ( value:IsA("BasePart") ) then
			return value.Position;
		end

		if ( value:IsA("Model") ) then
			local primary = value.PrimaryPart;

			if ( not primary ) then
				error("UNABLE TO COMPUTE VEC3 FOR MODEL: NO PRIMARY PART", 2);
			end

			return primary.Position;
		end
	end

	error("CANNOT CONVERT TO VEC3 ***" .. t .. "***", 2);
end

function Math.compute_dist( vi, vf )
	local vi_v3 = Math.vec3( vi );
	local vf_v3 = Math.vec3( vf );

	return ( vf_v3 - vi_v3 ).Magnitude;
end

function Math.compute_flat_dist( vi, vf )
	local vi_v3 = Math.vec3( vi );
	local vf_v3 = Math.vec3( vf );

	local dx = vi_v3.X - vf_v3.X;
	local dz = vi_v3.Z - vf_v3.Z;

	return math.sqrt( (dx * dx) + (dz * dz) );
end

function Math.compare_flat( vi, vf, threshold )
	local vi_v3 = Math.vec3( vi );
	local vf_v3 = Math.vec3( vf );

	local dx = vi_v3.X - vf_v3.X;
	local dz = vi_v3.Z - vf_v3.Z;

	local dist_sqr = (dx * dx) + (dz * dz);
	return  dist_sqr <= (threshold * threshold);
end

return Math;

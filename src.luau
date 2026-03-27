local Math = {};
Math.ANY = 0;
Math.ALL = 1;

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

function Math.compute_dist( xi, xf )
        local xi_v3 = Math.vec3( xi );
        local xf_v3 = Math.vec3( xf );

        return ( xf_v3 - xi_v3 ).Magnitude;
end

function Math.compute_flat_dist( xi, xf )
        local xi_v3 = Math.vec3( xi );
        local xf_v3 = Math.vec3( xf );

        local dx = xi_v3.X - xf_v3.X;
        local dz = xi_v3.Z - xf_v3.Z;

        return math.sqrt( (dx * dx) + (dz * dz) );
end

function Math.compare_axis( xi, xf, threshold, mode )
        local xi_v3 = Math.vec3( xi );
        local xf_v3 = Math.vec3( xf );

        local dx = math.abs( xf_v3.X - xi_v3.X );
        local dy = math.abs( xf_v3.Y - xi_v3.Y );
        local dz = math.abs( xf_v3.Z - xi_v3.Z );

        if ( mode == Math.ANY ) then
                return dx > threshold or dy > threshold or dz > threshold;
        end
        if ( mode == Math.ALL or mode == nil ) then
                return dx > threshold and dy > threshold and dz > threshold;
        end

        error("INVALID MODE", 2);
end

function Math.compare_flat( xi, xf, threshold )
        local xi_v3 = Math.vec3( xi );
        local xf_v3 = Math.vec3( xf );

        local dx = xi_v3.X - xf_v3.X;
        local dz = xi_v3.Z - xf_v3.Z;

        local dist_sqr = (dx * dx) + (dz * dz);
        return dist_sqr > (threshold * threshold);
end

return Math;

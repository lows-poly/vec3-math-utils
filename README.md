# vec3-math-utils
A simple helper module for working with distance and position in Roblox

## vec3 <br>
in: `function` | `Vector3` | `CFrame` | `BasePart` | `Model` (PrimaryPart is required) <br>
out: `Vector3`

## compute_dist <br>
in:
1. $x_i$ — initial
2. $x_f$ — final

out:
- `number`

## compute_flat_dist <br>
in:
1. $x_i$ — initial
2. $x_f$ — final

out:
- `number`

## compare_axis <br>
in:
1. $x_i$ — initial
2. $x_f$ — final
3. $x_{th}$ — threshold
4. mode — `ALL` | `ANY`

out:
- `TRUE` if `ALL` | `ANY` points are further apart than a given threshold

## compare_flat <br>
in:
1. $x_i$ — initial
2. $x_f$ — final
3. $x_{th}$ — threshold

out:
- `TRUE` if two points are further apart than a given threshold

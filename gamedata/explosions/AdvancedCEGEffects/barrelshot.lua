local definitions = {

  ["barrelshot-medium"] = {
    fire = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[1 0.85 0.6 0.013   0.6 0.2 0.06 0.01   0.4 0.06 0.015 0.006   0 0 0 0.01]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[shotgunflare]],
        length             = 33,
        sidetexture        = [[shotgunside]],
        size               = 7,
        sizegrowth         = -0.55,
        ttl                = 5.5,
      },
    },
    fire2 = {
      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = 1,
      water              = true,
      properties = {
        colormap           = [[1 0.85 0.6 0.013   0.6 0.2 0.06 0.01   0.4 0.06 0.015 0.006   0 0 0 0.01]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[none]],
        length             = -6,
        sidetexture        = [[shotgunside]],
        size               = 7,
        sizegrowth         = -0.55,
        ttl                = 5.5,
      },
    },
	  fireglow = {
	    air                = true,
	    class              = [[CSimpleParticleSystem]],
	    count              = 1,
	    ground             = true,
	    water              = true,
	    properties = {
	      airdrag            = 0,
	      alwaysvisible      = true,
	      colormap           = [[0.145 0.066 0.013 0.02   0.12 0.03 0.005 0.01   0 0 0 0.01]],
	      directional        = true,
	      emitrot            = 90,
	      emitrotspread      = 0,
	      emitvector         = [[0.0, 1, 0.0]],
	      gravity            = [[0.0, 0.0, 0.0]],
	      numparticles       = 1,
	      particlelife       = 9,
	      particlelifespread = 0,
	      particlesize       = 36,
	      particlesizespread = 6,
	      particlespeed      = 0,
	      particlespeedspread = 0,
	      pos                = [[0.0, 0, 0.0]],
	      sizegrowth         = -0.3,
	      sizemod            = 1,
	      texture            = [[dirt]],
	      useairlos          = true,
	    },
	  },
    smoke = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.84,
        colormap           = [[0.06 0.053 0.053 0.18   0.085 0.078 0.078 0.2   0.034 0.03 0.03 0.1  0 0 0 0]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 10,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 10,
        particlelife       = 55,
        particlelifespread = 15,
        particlesize       = 2,
        particlesizespread = 2,
        particlespeed      = 0,
        particlespeedspread = 2.5,
        pos                = [[0, 1, 3]],
        sizegrowth         = 0.03,
        sizemod            = 1.0,
        texture            = [[smoke]],
      },
    },
    smoke2 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.8,
        colormap           = [[0.06 0.053 0.053 0.18   0.085 0.078 0.078 0.2   0.033 0.03 0.03 0.1  0 0 0 0]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 20,
        emitvector         = [[dir]],
        gravity            = [[0.02 r-0.1, 0.03 r-0.1, 0.02 r-0.1]],
        numparticles       = 8,
        particlelife       = 62,
        particlelifespread = 0,
        particlesize       = 2,
        particlesizespread = 2,
        particlespeed      = -3.5,
        particlespeedspread = -1,
        pos                = [[0, 1, 3]],
        sizegrowth         = 0.03,
        sizemod            = 1.0,
        texture            = [[smoke]],
      },
    },
  },
}


function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local size = 0.66
definitions["barrelshot-small"] = deepcopy(definitions["barrelshot-medium"])
definitions["barrelshot-small"].fire.properties.length								= definitions["barrelshot-small"].fire.properties.length * size
definitions["barrelshot-small"].fire.properties.size									= definitions["barrelshot-small"].fire.properties.size * size
definitions["barrelshot-small"].fire.properties.ttl										= 4.5
definitions["barrelshot-small"].fire2.properties.length								= definitions["barrelshot-small"].fire2.properties.length * size
definitions["barrelshot-small"].fire2.properties.size									= definitions["barrelshot-small"].fire2.properties.size * size
definitions["barrelshot-small"].fire2.properties.ttl									= 4.5
definitions["barrelshot-small"].fireglow.properties.particlesize			= definitions["barrelshot-small"].fireglow.properties.particlesize * size
definitions["barrelshot-small"].fireglow.properties.colormap          = [[0.145 0.066 0.013 0.016   0 0 0 0.01]]
definitions["barrelshot-small"].smoke.properties.particlesize					= definitions["barrelshot-small"].smoke.properties.particlesize * size
definitions["barrelshot-small"].smoke.properties.particlesizespread		= definitions["barrelshot-small"].smoke.properties.particlesizespread * size
definitions["barrelshot-small"].smoke.properties.numparticles					= definitions["barrelshot-small"].smoke.properties.numparticles * size
definitions["barrelshot-small"].smoke.properties.particlespeedspread	= definitions["barrelshot-small"].smoke.properties.particlespeedspread * size
definitions["barrelshot-small"].smoke2.properties.particlesize				= definitions["barrelshot-small"].smoke2.properties.particlesize * size
definitions["barrelshot-small"].smoke2.properties.particlesizespread	= definitions["barrelshot-small"].smoke2.properties.particlesizespread * size

size = 1.5
definitions["barrelshot-large"] = deepcopy(definitions["barrelshot-medium"])
definitions["barrelshot-large"].fire.properties.length 								= definitions["barrelshot-large"].fire.properties.length * size
definitions["barrelshot-large"].fire.properties.size									= definitions["barrelshot-large"].fire.properties.size * size
definitions["barrelshot-large"].fire.properties.ttl										= 6.5
definitions["barrelshot-large"].fire2.properties.length								= definitions["barrelshot-large"].fire2.properties.length * size
definitions["barrelshot-large"].fire2.properties.size									= definitions["barrelshot-large"].fire2.properties.size * size
definitions["barrelshot-large"].fire2.properties.ttl									= 6.5
definitions["barrelshot-large"].fireglow.properties.particlesize			= definitions["barrelshot-large"].fireglow.properties.particlesize * size
definitions["barrelshot-large"].fireglow.properties.colormap          = [[0.145 0.066 0.013 0.024   0 0 0 0.01]]
definitions["barrelshot-large"].smoke.properties.particlesize					= definitions["barrelshot-large"].smoke.properties.particlesize * size
definitions["barrelshot-large"].smoke.properties.particlesizespread		= definitions["barrelshot-large"].smoke.properties.particlesizespread * size
definitions["barrelshot-large"].smoke.properties.numparticles					= definitions["barrelshot-large"].smoke.properties.numparticles * size
definitions["barrelshot-large"].smoke.properties.particlespeedspread	= definitions["barrelshot-large"].smoke.properties.particlespeedspread * size
definitions["barrelshot-large"].smoke2.properties.particlesize				= definitions["barrelshot-large"].smoke2.properties.particlesize * size
definitions["barrelshot-large"].smoke2.properties.particlesizespread	= definitions["barrelshot-large"].smoke2.properties.particlesizespread * size

size = 2.66
definitions["barrelshot-huge"] = deepcopy(definitions["barrelshot-medium"])
definitions["barrelshot-huge"].fire.properties.length 								= definitions["barrelshot-huge"].fire.properties.length * size
definitions["barrelshot-huge"].fire.properties.size										= definitions["barrelshot-huge"].fire.properties.size * size
definitions["barrelshot-huge"].fire.properties.ttl										= 8.5
definitions["barrelshot-huge"].fire2.properties.length								= definitions["barrelshot-huge"].fire2.properties.length * size
definitions["barrelshot-huge"].fire2.properties.size									= definitions["barrelshot-huge"].fire2.properties.size * size
definitions["barrelshot-huge"].fire2.properties.ttl										= 8.5
definitions["barrelshot-huge"].fireglow.properties.particlesize				= definitions["barrelshot-huge"].fireglow.properties.particlesize * size
definitions["barrelshot-huge"].fireglow.properties.colormap        		= [[0.145 0.066 0.013 0.024   0 0 0 0.01]]
definitions["barrelshot-huge"].smoke.properties.particlesize					= definitions["barrelshot-huge"].smoke.properties.particlesize * size
definitions["barrelshot-huge"].smoke.properties.particlesizespread		= definitions["barrelshot-huge"].smoke.properties.particlesizespread * size
definitions["barrelshot-huge"].smoke.properties.numparticles					= definitions["barrelshot-huge"].smoke.properties.numparticles * size
definitions["barrelshot-huge"].smoke.properties.particlespeedspread		= definitions["barrelshot-huge"].smoke.properties.particlespeedspread * size
definitions["barrelshot-huge"].smoke2.properties.particlesize					= definitions["barrelshot-huge"].smoke2.properties.particlesize * size
definitions["barrelshot-huge"].smoke2.properties.particlesizespread		= definitions["barrelshot-huge"].smoke2.properties.particlesizespread * size

return definitions
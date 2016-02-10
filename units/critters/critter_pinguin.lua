unitDef = {
  unitname            = [[critter_pinguin]],
  name                = [[Pinguin]],
  iconType = "blank",
  description         = [[so cool!]],
  acceleration        = 0.15, 
  bmcode              = [[1]],
  brakeRate           = 1, --0.5
  buildCostEnergy     = 20,
  buildCostMetal      = 10,
  builder             = false,
  --buildPic            = "tpdudeblue.png",
  buildTime           = 10,--5
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[MOBILE NOWEAPON NOTAIR NOTSUB]],
--  corpse              = [[DEAD]],
  reclaimable         = true,
  stealth 			  = true,
  sonarStealth		  = true,
	----------	
  defaultmissiontype  = [[Standby]],
  --explodeAs           = [[MEDIUM_UNIT]],
  footprintX          = 1,
  footprintZ          = 1,
  idleAutoHeal        = 0,  
  maneuverleashlength = [[640]],
  mass                = 24,
  maxDamage           = 10,
  maxSlope            = 45,
  maxVelocity         = 0.35,
  maxWaterDepth       = 22,  
  movementClass       = [[HOVER9]],
  --crushStrength 	  = 25,
  moveState           = -1,
  noAutoFire          = false,
  noChaseCategory     = [[MOBILE STATIC]],
  objectName          = [[critter_pinguin.s3o]], --
  seismicSignature    = 4,
  --selfDestructAs      = [[MEDIUM_UNIT]],
  selfDestructCountdown = 1,
  upright=false,
  floater = true,
  waterline = 6,
  side                = [[GAYS]],
  sightDistance       = 350,--250
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  leaveTracks         = true,
  trackOffset         = 0,
  trackStrength       = 3,
  trackStretch        = 1,
  trackType           = [[bigfoot]],
  trackWidth          = 10,
  turninplace         = 1,
  turnRate            = 2000,
  workerTime          = 0,
  script              = [[critter_pinguin.lua]], -- [[tpdude.lua]], 

}

return lowerkeys({ critter_pinguin = unitDef })
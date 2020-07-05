const itemList = [
  "i_FFXIVArtemisBow_Hide",
  "i_FFXIVBravura_Hide",
  "i_FFXIVCurtana_Hide",
  "i_FFXIVGaeBolg_Hide",
  "i_FFXIVHolyShield_Hide",
  "i_FFXIVOmnilex_Hide",
  "i_FFXIVSphairai_Hide",
  "i_FFXIVStardustRod_Hide",
  "i_FFXIVTheVeilofWiyu_Hide",
  "i_FFXIVThyrus_Hide",
  "i_FFXIVYoshimitsu_Hide"
]

static func getItem():
  var id = sys.rndListItem(itemList)
  return sys.newItem(id)
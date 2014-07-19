library(leafletR)
library(scales)

df <- read.csv("content/clinicGPS.csv", fileEncoding="UTF-8")

VGHKS <- subset(df, hos1Name=="高雄榮民總醫院", drop=TRUE)

for(i in 1:length(VGHKS)){
  VGHKS[i] <- droplevels(VGHKS[i])
}

groupPool <- levels(VGHKS$groupName)

map.dat <- toGeoJSON(data=VGHKS, dest=tempdir(), lat.lon=c("lat", "lon"))
map.sty <- styleCat(prop="groupName", val=groupPool, style.val=brewer_pal(palette="Set1")(length(groupPool)))
map <- leaflet(data=map.dat, dest=tempdir(), style=map.sty, base.map="mqosm", popup=c("clinicName", "clinicAddr"))

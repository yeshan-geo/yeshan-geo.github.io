setwd("~/Documents/数据分析和可视化/data/lab4/homework")
library(readr)
library(sf)
library(dplyr)
library(raster)

sichuan <- sf::st_read("sichuan/sichuan.shp")
rivers <- sf::st_read("yangtze/yangtze.shp")
chongqing <- sf::st_read("chongqing/chongqing.shp")
cities <- read_csv("cities.csv")
hospitals <- read_csv("hospitals.csv")
line <- sf::st_read("section/section.shp")

#Q1
sichuan$area <- as.numeric(st_area(sichuan)/1000000)
ggplot()+
  geom_bar(data=sichuan,aes(x=ct_name,y=area),stat="identity")+
  coord_flip()

#Q2
xian <- data.frame(lat = 34.3, lon = 109)
xian_sf <- st_as_sf(xian, coords = c("lon","lat"), crs=4326)
sichuan$to_xian = as.numeric(st_distance(xian_sf, sichuan)/1000)
ggplot()+
  geom_violin(data=sichuan, aes(x="Sichuan Cities",y=to_xian))+
  geom_boxplot(data=sichuan, aes(x="Sichuan Cities",y=to_xian),width=0.1)

#Q3
cities_sf <- st_as_sf(cities, coords = c("lon","lat"), crs=4326)
rivers_in_chongqing <- st_intersection(rivers,chongqing)
rivers_buffer15km <- st_buffer(rivers_in_chongqing, 15000)
cities_class <- st_join(cities_sf, rivers_buffer15km)
cities_selected <- cities_class[which(is.na(cities_class$FID)),]
cities_selected <- st_intersection(cities_selected,chongqing)
rivers_buffer15km <- st_union(rivers_buffer15km)
ggplot() +
  geom_sf(data = chongqing, color="black") +
  geom_sf(data = rivers_buffer15km, fill="royalblue", alpha=0.5)+ 
  geom_sf(data = rivers_in_chongqing, color="royalblue") +
  geom_sf(data=cities_selected,color="red")

#Q4
nanchong = sichuan[which(sichuan$ct_name=="Nanchong"),]
aba = sichuan[which(sichuan$ct_name=="Ngawa"),]

ggplot() +
  geom_sf(data = nanchong, color="black")+
  geom_sf(data = aba, color="black")

terrain <- raster("sichuan_basin.tif")
terrain_df <- as.data.frame(terrain, xy = TRUE)
#mask到南充和阿坝
terrain_nanchong <- mask(terrain, as(nanchong,"Spatial"))
terrain_aba <- mask(terrain, as(aba,"Spatial"))
#转换格式为data frame，并清除空值
terrain_nanchong_df <- as.data.frame(terrain_nanchong, xy = TRUE)
terrain_nanchong_df <- terrain_nanchong_df[which(!is.na(terrain_nanchong_df$sichuan_basin)),]
terrain_aba_df <- as.data.frame(terrain_aba, xy = TRUE)
terrain_aba_df <- terrain_aba_df[which(!is.na(terrain_aba_df$sichuan_basin)),]
ggplot() +
  geom_raster(data = terrain_nanchong_df, aes(x = x, y = y, fill = sichuan_basin))+
  geom_sf(data = nanchong, color="black", alpha=0.5)
ggplot()+
  geom_density(data=terrain_aba_df,aes(x=sichuan_basin, fill="Ngawa (Aba)"),alpha=0.5)+
  geom_density(data=terrain_nanchong_df,aes(x=sichuan_basin, fill="Nanchong"),alpha=0.5)+
  geom_vline(xintercept = mean(terrain_aba_df$sichuan_basin))+
  geom_vline(xintercept = mean(terrain_nanchong_df$sichuan_basin))+
  coord_flip()

#Q5
hospitals_sf <- st_as_sf(hospitals, coords = c("lon","lat"), crs=4326)
sichuan$hospitals <- lengths(st_intersects(sichuan, hospitals_sf))
ggplot() +
  geom_sf(data = sichuan, aes(fill=hospitals)) +
  theme_void()+
  theme(legend.position = "bottom")+
  labs(fill = "Number of hospitals")+
  scale_fill_distiller(palette = "Reds",trans = 'reverse',
                       labels = c("0","5","10","15","20"),
                       breaks = c(0,5,10,15,20))

#Q6
require(zoo)
elev_line <- extract(terrain, line, method = "bilinear")
#创建一个数据框，储存路线沿途各采样点的海拔，以及各点到起点的距离
#采样点即为线要素经过的栅格数据单元
profile <- data.frame(
  distance = seq(from = 0, #出发点
                 to=as.numeric(st_length(line)), #终点到出发点的距离
                 by = as.numeric(st_length(line))/(length(elev_line[[1]])-1)), #分配给采样点-1个区间
  elevation = as.numeric(elev_line[[1]]))
#画图
p <- ggplot()+
  geom_line(data=profile,aes(x=distance/1000,y=rollmean(
    elevation, 20, na.pad = TRUE, align = "center")))+
  theme_bw()+
  labs(x="Distance from the start (km)", y="Elevation (m)")
p

#Q7
temp <- raster("temp.tif")
temp_df <- as.data.frame(temp, xy = TRUE)
temp_df <- temp_df[which(!is.na(temp_df$temp)),]
temp_df <- temp_df %>%
  mutate(reclassify = ifelse(temp >26, "not chosen",
                             ifelse(temp >= 20, "chosen", "not chosen")))

cities_sf$temp <- extract(temp, as(cities_sf,"Spatial"))
cities_sf = cities_sf[which(cities_sf$temp<=26),]
cities_sf = cities_sf[which(cities_sf$temp>=20),]
#生成地图
p <- ggplot() +
  geom_raster(data = temp_df, aes(x = x, y = y, fill = reclassify))+
  scale_fill_manual(values=c("not chosen"="tan", "chosen" = "red"))+
  geom_sf(data=cities_sf)+
  labs(fill="Selected range", x = "Lon", y = "Lat")+
  theme_bw()
#绘制地图
p

#Q8
temp <- raster("temp.tif")
#使用terrain函数计算坡度，获得一个新的栅格数据
slope <- terrain(temp, opt = "slope", unit="degrees")
#将新得到的栅格数据转化为数据框格式
slope_df <- as.data.frame(slope, xy = TRUE)
#创建地图
p <- ggplot() +
  geom_raster(data = slope_df, aes(x = x, y = y, fill = slope))+
  scale_fill_gradientn(colours=c("snow","red"))+
  labs(fill="Slope (degrees)", x = "Lon", y = "Lat")+
  theme_bw()
#绘制地图
p

#Q9
liangshan = sichuan[which(sichuan$ct_name=="Liangshan"),]
terrain_liangshan <- mask(terrain, as(liangshan,"Spatial"))
terrain_liangshan_df <- as.data.frame(terrain_liangshan, xy = TRUE)
terrain_liangshan_df <- terrain_liangshan_df[which(!is.na(terrain_liangshan_df$sichuan_basin)),]
terrain_color_ramp = c("#33592c","#78ad6d","#e3e6a1","#dbcc86",
                       "#bd9c26","#b38b15","#e2d5f2","white")
#使用terrain函数计算朝向，获得一个新的栅格数据
aspect_liangshan <- terrain(terrain_liangshan, opt = "aspect", unit="degrees")
#将新得到的栅格数据转化为数据框格式
aspect_liangshan_df <- as.data.frame(aspect_liangshan, xy = TRUE)
aspect_liangshan_df <- aspect_liangshan_df[which(!is.na(aspect_liangshan_df$aspect)),]
library(ggnewscale)
p <- ggplot() +
  geom_raster(data = terrain_liangshan_df, aes(x = x, y = y, fill = sichuan_basin))+
  scale_fill_gradientn(colours=terrain_color_ramp)+
  labs(fill="Elevation (m)")+
  new_scale_fill() +
  geom_raster(data = aspect_liangshan_df, aes(x = x, y = y, fill = aspect),alpha=0.3)+
  scale_fill_gradientn(colours=c("gray50","white","gray50","black","gray50"),
                       breaks = c(0,90,180,270,360))+
  labs(fill="Aspect (degree from east)", x = "Lon", y = "Lat")+
  theme_void()
#绘制地图
p

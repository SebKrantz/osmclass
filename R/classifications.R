

#' Functional Classification of OSM Points and Polygon Features
#'
#' A nested list proposing a classification of OSM point and polygons into 33 functional categories.
#' @examples
#' collapse::unlist2d(osm_point_polygon_class, idcols = c("category", "tag"))
#' @export
'osm_point_polygon_class'


#### ----------------------------------------------------
# Categorization of OSM Features by Functional Categories
# See: https://wiki.openstreetmap.org/wiki/Map_features
#### ----------------------------------------------------

# amenity_tags <- fread("data/amenity_tags.csv")
# st <- amenity_tags$Key %>% whichv("amenity", invert = TRUE) %>% c(fnrow(amenity_tags)+1L)
# amenity_tags <- lapply(seq_len(length(st)-1L), function(i) ss(amenity_tags, (st[i]+1L):(st[i+1L]-1L), -3L)) %>% setNames(amenity_tags$Key[st[-length(st)]])
# sum(sapply(amenity_tags, fnrow))
# rm(st)
# cat(amenity_tags$Others$Value, sep = ", ")
#
#
# all_tags <- fread("data/all_tags.csv") %>% fsubset(!Key %ilike% "Lua error")
# all_tags %>% fsubset(Key == "building") %>% get_vars(varying(.)) %>% View()
# all_tags %>% fsubset(Key == "building", Value) %>% .subset2(1) %>% cat(sep = ", ")
#


# The same, reshuffled a bit to make more economic sense
osm_point_polygon_class <- list(
  food = list(amenity = .c(bar, cafe, fast_food, food_court, ice_cream, pub, restaurant)),
  shopping = list(amenity = "marketplace", # TODO: distinguish bigger and smaller, formal vs. informal shopping??
                  shop = "",
                  building = .c(retail, kiosk, supermarket, warehouse),
                  landuse = "retail"), # .c(department_store, mall, supermarket, wholesale)
  craft = list(craft = ""),
  education = list(amenity = .c(college, school, university),
                   building = .c(college, school, university),
                   landuse = "education"),
  education_alt = list(amenity = .c(driving_school, kindergarten, language_school, library, training, music_school),
                       office = .c(educational_institution, tutoring),
                       building = "kindergarten"),
  creativity = list(amenity = .c(conference_centre, studio), # Think about this tag. conference centre??
                    leisure = "hackerspace",
                    office = .c(graphic_design, coworking, engineer, it, research)),
  transport = list(amenity = .c(bicycle_parking, bicycle_repair_station, bicycle_rental, boat_rental, boat_sharing, bus_station, train_station, car_rental, car_sharing,
                                car_wash, compressed_air, vehicle_inspection, charging_station, ferry_terminal, fuel, grit_bin, motorcycle_parking, parking,
                                parking_entrance, parking_space, taxi),
                   highway = .c(crossing, mini_roundabout, motorway_junction, traffic_signals, turning_circle, turning_loop, bus_stop, services, speed_camera),
                   railway = "",
                   aerialway = "",
                   waterway = "", # Be more specific? But probably rare tag in Africa anyway...
                   aeroway = "",
                   public_transport = "",
                   bridge = "",
                   junction = "",
                   office = .c(logistics, moving_company),
                   man_made = .c(bridge, goods_conveyor),
                   building = .c(train_station, transportation, bridge)),
  storage = list(man_made = .c(silo, storage_tank),
                 building = .c(hangar, hut, shed, storage_tank, silo),
                 landuse = "depot"),
  communications = list(amenity = .c(internet_cafe, telephone),
                        telecom = "",
                        communication ="", # regrex/startsWith(), e.g. communication:mobile_phone =
                        man_made = .c(antenna, beacon, communication_tower, communications_tower, lighthouse, satellite_dish), # telescope
                        office = "telecommunication", # mast
                        "tower:type" = .c(communication, telecommunication, radar, radio, radio_transmitter)),
  accommodation = list(tourism = .c(apartment, chalet, guest_house, hostel, hotel, motel, wilderness_hut, camp_pitch, camp_site),
                       building = "hotel"),
  tourism = list(tourism = "",
                 office = .c(guide, travel_agent)),
  financial = list(amenity = .c(atm, bank, bureau_de_change),
                   office = .c(accountant, financial, financial_advisor, insurance, tax_advisor)),
  health = list(amenity = .c(baby_hatch, clinic, dentist, doctors, hospital, nursing_home, pharmacy, social_facility, veterinary),
                healthcare = "",
                building = "hospital"),
  industrial = list(landuse = .c(industrial, port, railway), # TODO: Port and railway not transport? But OSM suggests to declare it an industrial area.
                    building = "industrial",
                    man_made = .c(kiln, works)), # kiln might be too small...
  mining = list(landuse = "quarry",
                man_made = .c(adit, mineshaft, petroleum_well, tailings_pond)),
  commerical = list(landuse = "commercial",   # Predominantly commercial businesses and their offices.
                    building = "commercial"), # Could also be shops / malls etc. this is not a very specific tag...
  construction = list(landuse = "construction",
                      # man_made = "crane", # A stationary, permanent crane. So not really for construction...
                      building = "construction"), # TODO: save start_date: The (approximated) date when the building was finished!!!
  residential = list(building = .c(house, apartments, bungalow, detached, semidetached_house, terrace, dormitory, residential),
                     landuse = "residential"),
  farming = list(landuse = .c(farmland, farmyard, orchard, vineyard, aquaculture, salt_pond, greenhouse_horticulture, plant_nursery),
                 building = .c(farm, barn, conservatory, cowshed, farm_auxiliary, greenhouse, slurry_tank, stable, sty),
                 man_made = "beehive"),
  emergency = list(emergency = ""),
  entertainment = list(amenity = .c(arts_centre, exhibition_centre, brothel, casino, cinema, events_venue, gambling, love_hotel, nightclub, planetarium, stripclub, swingerclub, theatre),
                       leisure = .c(adult_gaming_centre, amusement_arcade, bandstand, dance)),
  sports = list(leisure = .c(fitness_centre, fitness_station, pitch, sports_centre, stadium, swimming_pool, track),
                sport = "",
                building = .c(grandstand, pavilion, riding_hall, sports_hall, stadium)),
  recreation = list(amenity = .c(community_centre, fountain, public_bath, public_bookcase, social_centre),
                    leisure = .c(beach_resort, marina, miniature_golf, common, park, dog_park, water_park, nature_reserve, picnic_table, fishing, garden, playground, swimming_area),
                    landuse = "recreation_ground",
                    building = "civic"), # Very general tag, match last...
  historic = list(historic = ""),
  religion = list(amenity = .c(funeral_hall, crematorium, grave_yard, monastery, place_of_mourning, place_of_worship),
                  building = .c(cathedral, chapel, church, kingdom_hall, monastery, mosque, presbytery, shrine, synagogue, temple, religious),
                  office = "religion",
                  landuse = "religious",
                  religion = "",
                  denomination = ""),
  institutional = list(office = .c(government, ngo, association, diplomatic, political_party),
                       building = "government",
                       landuse = "institutional"),
  military = list(landuse = "military",
                  military = "",
                  building = .c(military, barracks, bunker)),
  office_other = list(office = "",
                      building = "office"),
  public_service = list(amenity = .c(courthouse, fire_station, police, post_box, post_depot, post_office, prison, ranger_station, townhall, public_building),
                        building = .c(fire_station,  public)), # public also more general tag, but fits quite well...
  facilities = list(amenity = .c(bbq, bench, dog_toilet, childcare, clock, photo_booth, kitchen, dressing_room, drinking_water, give_box, parcel_locker,
                                 shelter, shower, toilets, water_point, watering_place, refugee_site, vending_machine),
                    building = "toilets"),
  power = list(power = "",
               building = "transformer_tower",
               "tower:type" = "power"),
  waste = list(amenity = .c(sanitary_dump_station, recycling, waste_basket, waste_disposal, waste_transfer_station),
               water = 	"wastewater",
               man_made = "wastewater_plant",
               landuse = "landfill"),
  utilities_other = list(man_made = .c(water_tower, water_well, water_works, gasometer, pipeline, pump, pumping_rig, pumping_station, reservoir_covered, street_cabinet),
                         water = "reservoir",
                         office = "water_utility",
                         building = .c(digester, service, water_tower))
)

# Todo: classify from spefic to general: first amenity, craft, sports, leisure, shop, military etc, later more general tags such as office, man_made, building, landuse etc.
# build iterative algorithm... possibly in python??
# Also: save classifying tag along with category...

# Ordering according to tag priorities... and likelihood of duplicate matches
osm_point_polygon_class = colorder(osm_point_polygon_class,
                                 military, food, craft,
                                 education, education_alt,
                                 health, sports,
                                 farming, mining, industrial,
                                 accommodation, tourism, creativity,
                                 financial, entertainment, institutional, public_service,
                                 storage, communications, transport,
                                 religion, construction,
                                 shopping, residential, historic,
                                 waste, power, utilities_other,
                                 facilities,
                                 recreation,
                                 office_other, commerical, emergency)


# setrelabel(OSM_classification,
#   food = "Sustenance",
#   shopping = "Shopping",
#   education = "Education",
#   education_alt = "Alternative Education",
#   transport = "Transportation",
#   communications = "Communications",
#   financial = "Financial",
#   health = "Healthcare",
#   entertainment = "Entertainment, Arts & Culture",
#   religion = "Religion",
#   public_service = "Public Service",
#   facilities = "Facilities",
#   waste = "Waste Management"
# )



#' Functional Classification of OSM Line Features
#'
#' A nested list proposing a classification of OSM lines into 11 functional categories.
#' @examples
#' collapse::unlist2d(osm_line_class, idcols = c("category", "tag"))
#' @export
'osm_line_class'


osm_line_class <- list(
  aerialway = list(aerialway = ""), # E.g. ziplines
  aeroway = list(aeroway = ""),     # E.g. airfields
  pipeline = list(man_made = "pipeline"),
  road = list(highway = .c(motorway, motorway_link, trunk, trunk_link, primary, primary_link, secondary, secondary_link, tertiary, tertiary_link)),
  # residential, living_street, service, construction)), # road, cycleway, unclassififed
  railway = list(railway = ""),
  waterway = list(waterway = "", natural = "water", water = "", man_made = .c(water_works, reservoir_covered, water_tower)),
  power = list(power = ""),
  telecom = list(telecom = ""),
  storage = list(man_made = .c(silo, storage_tank),
                 building = .c(hangar, hut, shed, storage_tank, silo),
                 landuse = "depot"),
  # public_transport = list(public_transport = ""), # Basically not existent.
  boundary = list(boundary = .c(national_park, protected_area, special_economic_zone)), # See SEZ Database.
  route = list(route = "")
)


#' Further tags of Interest for Line Features
#'
#' Further tags that max be of interested to extract for OSM line features.
#' @examples
#' collapse::unlist2d(osm_line_info_tags, idcols = "category")
#' @export
'osm_line_info_tags'

osm_line_info_tags <- list(
  aerialway = .c(aerialway, occupancy, capacity, duration, detachable, bubble, heating, bicycle, access),
  aeroway = .c(aerialway, surface, lit, navigationaid, iata, icao, amenity, highway),
  pipeline = .c(type, pipeline, depth, inlet, outlet, construction, substance,
                content, resource, diameter, pressure, capacity, flow_direction, count),
  road = .c(highway, abutters, lanes, lit, maxspeed, traffic_calming, oneway, surface, smoothness, tracktype),
  railway = .c(railway, tracks, electrified, embankment, embedded_rails, gauge,
               loading_gauge, metre_load, axle_load, voltage, frequency, highspeed, maxspeed, historic),
  waterway = .c(type, intermittent, inlet, outlet, width, draft, tidal, maxwidth, maxheight, maxlength, maxspeed),
  power = .c(power, capacity, electricity, plant:output, generator:output),
  telecom = .c(telecom, telecom:medium, connection_point, utility),
  storage = .c(content, crop, height, material),
  boundary = .c(related_law, protect_class, protection_title, official_name),
  route = .c(access, duration, opening_hours, reservation, motor_vehicle, foot, maxweight, maxlength, maxwidth, maxheight)
)

osm_line_info_tags = lapply(osm_line_info_tags,
                            function(x) unique(c(.c(type, ref, name, description, operator, usage, service, capacity, man_made), x,
                                                     .c(length, width, location, origin, place:origin, destination, place:destination, start_date, end_date))))

#### -------------------------------------------------------
# Categorization of OSM Features by Functional Categories
# See: https://wiki.openstreetmap.org/wiki/Map_features
# Developed to Minimize Overlap/Missclassification in Africa
#### -------------------------------------------------------


#' A Classification of OSM Features by Economic Function
#'
#' This classification, developed for Krantz (2023), aims to classify OSM features into meaningful and specific economic
#' categories such as 'education', 'health', 'tourism', 'financial', 'shopping', 'transport', 'communications',
#' 'industrial', 'residential', 'road', 'railway', 'pipeline', 'power', 'waterway' etc. Separate classifications
#' are developed for points and polygons (buildings) (33 categories), and lines (11 categories), which should be applied to
#' the respective layers of OSM PBF files, see \link{osmclass-package} for and example. The classification is optimized
#' (in terms of tag choice and order of categories) to assign the most sensible primary category to most features in the Africa OSM.
#'
#' @references
#' Krantz, Sebastian, Mapping Africa’s Infrastructure Potential with Geospatial Big Data, Causal ML, and XAI (August 10, 2023). Available at SSRN: https://www.ssrn.com/abstract=4537867
#'
#' @name classifications
#' @seealso \link{osmclass-package}
#' @examples
#' collapse::unlist2d(osm_point_polygon_class, idcols = c("category", "tag"))
#' collapse::unlist2d(osm_line_class, idcols = c("category", "tag"))
#' # This list contains additional tags with information about lines (e.g. roads and railways)
#' collapse::unlist2d(osm_line_info_tags, idcols = c("category", "tag"))
#' @export
'osm_point_polygon_class'


osm_point_polygon_class_uo <- list(
  food = list(amenity = .c(bar, cafe, fast_food, food_court, ice_cream, pub, restaurant)),
  shopping = list(amenity = .c(marketplace, shop), # TODO: distinguish bigger and smaller, formal vs. informal shopping??
                  shop = c("!no", "!vacant"), # All except generic statements (in those cases the primary feature is something else)
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
                   waterway = c("!waterfall", "!stream", "!stream_end", "!rapids", "!tidal_channel", "!riverbank"), # Getting rid of natural features...
                   aeroway = "",
                   public_transport = "",
                   bridge = "",
                   junction = "",
                   office = .c(logistics, moving_company),
                   man_made = .c(bridge, goods_conveyor),
                   building = .c(train_station, transportation, bridge)),
  storage = list(man_made = .c(silo, storage_tank),
                 building = .c(hangar, storage_tank, silo), # hut, shed, : In Africa: huts and sheds are residential buildings... better exclude...
                 landuse = "depot"),
  communications = list(amenity = .c(internet_cafe, telephone),
                        telecom = "",
                        communication ="", # regrex/startsWith(), e.g. communication:mobile_phone =
                        utility = "telecom",
                        man_made = .c(antenna, beacon, communication_tower, communications_tower, lighthouse, satellite_dish), # telescope
                        office = "telecommunication", # mast
                        "tower:type" = .c(communication, telecommunication, radar, radio, radio_transmitter)),
  accommodation = list(tourism = .c(apartment, chalet, guest_house, hostel, hotel, motel, wilderness_hut), #, camp_pitch, camp_site
                       building = "hotel"),
  tourism = list(tourism = "!no", # All except generic statements (in those cases the primary feature is something else)
                 shop = "travel_agency",
                 office = .c(guide, travel_agent)),
  financial = list(amenity = .c(atm, bank, bureau_de_change, mobile_money, mobile_money_agent, money_transfer),
                   office = .c(accountant, financial, financial_advisor, insurance, tax_advisor)),
  health = list(amenity = .c(baby_hatch, clinic, dentist, doctors, hospital, nursing_home, pharmacy, social_facility, veterinary),
                healthcare = "",
                building = "hospital"),
  industrial = list(industrial = "", # TODO: Check effects...
                    man_made = .c(kiln, works), # kiln might be too small...
                    building = "industrial",
                    landuse = .c(industrial, port, railway)), # TODO: Port and railway not transport? But OSM suggests to declare it an industrial area.),
  mining = list(man_made = .c(adit, mineshaft, petroleum_well, tailings_pond),
                landuse = "quarry"),
  commerical = list(building = "commercial",  # Could also be shops / malls etc. this is not a very specific tag...
                    landuse = "commercial"),  # Predominantly commercial businesses and their offices.
  construction = list(# man_made = "crane", # A stationary, permanent crane. So not really for construction...
                      building = "construction", # TODO: save start_date: The (approximated) date when the building was finished!!!
                      landuse = "construction"),
  residential = list(building = .c(house, apartments, bungalow, detached, semidetached_house, terrace, dormitory, residential),
                     "building:use" = .c(residential, apartments),
                     landuse = "residential"),
  farming = list(place = "farm",
                 man_made = "beehive",
                 building = .c(farm, barn, conservatory, cowshed, farm_auxiliary, greenhouse, slurry_tank, stable, sty),
                 landuse = .c(farmland, farmyard, orchard, vineyard, aquaculture, salt_pond, greenhouse_horticulture, plant_nursery)),
  emergency = list(emergency = "!no"),
  entertainment = list(amenity = .c(arts_centre, exhibition_centre, brothel, casino, cinema, events_venue, gambling, love_hotel, nightclub, planetarium, stripclub, swingerclub, theatre),
                       leisure = .c(adult_gaming_centre, amusement_arcade, bandstand, dance)),
  sports = list(leisure = .c(fitness_centre, fitness_station, pitch, sports_centre, stadium, swimming_pool, track),
                sport = "",
                building = .c(grandstand, pavilion, riding_hall, sports_hall, stadium)),
  recreation = list(amenity = .c(community_centre, fountain, public_bath, public_bookcase, social_centre),
                    leisure = .c(beach_resort, marina, miniature_golf, common, park, dog_park, water_park, nature_reserve, picnic_table, fishing, garden, playground, swimming_area),
                    landuse = "recreation_ground",
                    building = "civic"), # Very general tag, match last...
  historic = list(historic = "!no"),
  religion = list(amenity = .c(funeral_hall, crematorium, grave_yard, monastery, place_of_mourning, place_of_worship),
                  building = .c(cathedral, chapel, church, kingdom_hall, monastery, mosque, presbytery, shrine, synagogue, temple, religious),
                  office = "religion",
                  landuse = "religious",
                  religion = "",
                  denomination = ""),
  institutional = list(office = .c(government, ngo, association, diplomatic, political_party),
                       building = "government",
                       landuse = "institutional"),
  military = list(military = "",
                  building = .c(military, barracks, bunker),
                  landuse = "military"),
  office_other = list(office = "",
                      building = "office"),
  public_service = list(amenity = .c(courthouse, fire_station, police, post_box, post_depot, post_office, prison, ranger_station, townhall, public_building),
                        building = .c(fire_station,  public)), # public also more general tag, but fits quite well...
  facilities = list(amenity = .c(bbq, bench, dog_toilet, childcare, clock, photo_booth, kitchen, dressing_room, drinking_water, give_box, parcel_locker,
                                 shelter, shower, toilets, water_point, watering_place, refugee_site, vending_machine),
                    building = "toilets"),
  power = list(power = "",
               utility = "power",
               building = "transformer_tower",
               "tower:type" = "power"),
  waste = list(amenity = .c(sanitary_dump_station, recycling, waste_basket, waste_disposal, waste_transfer_station),
               water = 	"wastewater",
               man_made = "wastewater_plant",
               landuse = "landfill"),
  utilities_other = list(man_made = .c(water_tower, water_well, water_works, water_tap, water_tank, gasometer,
                                       pipeline, pump, pumping_rig, pumping_station, reservoir_covered, street_cabinet),
                         water = "reservoir",
                         office = "water_utility",
                         building = .c(digester, service, water_tower),
                         landuse = "reservoir")
)


# Ordering according to tag priorities... and likelihood of duplicate matches
osm_point_polygon_class = colorder(osm_point_polygon_class_uo,
                                 military, craft,
                                 education, education_alt,
                                 health,
                                 farming, mining, industrial,
                                 accommodation, food, tourism, creativity, sports,
                                 entertainment, institutional, public_service,
                                 storage, communications, transport,
                                 shopping, # Needs to be after tourism, and before financial, as many shops have mobile money agents...
                                 financial,
                                 religion, construction,
                                 residential, historic, # Todo: historic earlier ? e.g. historic mines etc.. needs to be after tourism though.. and historic mines may also be useful for economic development
                                 waste,
                                 office_other,
                                 commerical,
                                 power, utilities_other, # Power needs to be matched late because some offices are generated by power = generator etc.
                                 recreation,
                                 facilities,
                                 emergency)



#' @rdname classifications
#' @export
'osm_line_class'


osm_line_class <- list(
  aerialway = list(aerialway = ""), # E.g. ziplines
  aeroway = list(aeroway = ""),     # E.g. airfields
  pipeline = list(man_made = "pipeline"),
  road = list(highway = .c(motorway, motorway_link, trunk, trunk_link, primary, primary_link, secondary, secondary_link, tertiary, tertiary_link)),
  # residential, living_street, service, construction)), # road, cycleway, unclassififed
  railway = list(railway = ""),
  waterway = list(waterway = c("!waterfall", "!stream", "!stream_end", "!wadi", "!rapids", "!tidal_channel", "!riverbank", "!yes"), # Getting rid of natural features...
                  water = "!yes", man_made = .c(water_works, reservoir_covered, water_tower)),
  power = list(power = ""),
  telecom = list(telecom = "",
                 communication = ""), # regrex/startsWith(), e.g. communication:mobile_phone =
  storage = list(man_made = .c(silo, storage_tank)),
  # public_transport = list(public_transport = ""), # Basically not existent.
  boundary = list(boundary = .c(national_park, protected_area, special_economic_zone)), # See SEZ Database.
  ferry = list(route = "ferry")
)


#' @rdname classifications
#' @export
'osm_line_info_tags'

osm_line_info_tags_special <- list(
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

osm_line_info_tags = lapply(osm_line_info_tags_special,
                            function(x) unique(c(.c(type, ref, name, description, operator, usage, service, capacity, man_made), x,
                                                 .c(length, width, location, origin, place:origin, destination, place:destination, start_date, end_date))))

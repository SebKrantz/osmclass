#### -------------------------------------------------------
# Categorization of OSM Features by Functional Categories
# See: https://wiki.openstreetmap.org/wiki/Map_features
# Developed to Minimize Overlap/Missclassification in Africa
#### -------------------------------------------------------


#' Classification of OSM Features by Economic Function
#'
#' A classification of OSM features by economic function. A newer detailed version is available for points and polygons.
#'
#' The simple classification, developed for Krantz (2023), aims to classify OSM features into meaningful and specific economic
#' categories such as 'education', 'health', 'tourism', 'financial', 'shopping', 'transport', 'communications',
#' 'industrial', 'residential', 'road', 'railway', 'pipeline', 'power', 'waterway' etc. Separate classifications
#' are developed for points and polygons (buildings) (33 categories), and lines (11 categories), which should be applied to
#' the respective layers of OSM PBF files, see \link{osmclass-package} for and example. The classification is optimized
#' (in terms of tag choice and order of categories) to assign the most sensible primary category to most features in the Africa OSM.
#'
#' In spring 2025, I added a more detailed classification with 55 categories (\code{osm_point_polygon_class_det}) for point and polygon-based features,
#' approximately reflecting an extended database used in the November 2024 update of the article where OSM features are combined with other geospatial data sources.
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
  port = list(landuse = "port"),
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
                   building = .c(train_station, transportation, bridge),
                   landuse = "railway"),
  storage = list(man_made = .c(silo, storage_tank),
                 building = .c(hangar, storage_tank, silo), # hut, shed, : In Africa: huts and sheds are residential buildings... better exclude...
                 landuse = "depot"),
  communications = list(amenity = .c(internet_cafe, telephone),
                        telecom = "",
                        utility = "telecom",
                        man_made = .c(antenna, beacon, communication_tower, communications_tower, lighthouse, satellite_dish), # telescope
                        office = "telecommunication", # mast
                        "tower:type" = .c(communication, telecommunication, radar, radio, radio_transmitter),
                        communication = c("line", "pole", "mobile", "mobile_phone", "mobile_phone=yes") # could just contain phone numbers of businesses etc.  # regrex/startsWith(), e.g. communication:mobile_phone =
  ),
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
                    landuse = "industrial"), # TODO: Port and railway not transport? But OSM suggests to declare it an industrial area.),
  mining = list(man_made = .c(adit, mineshaft, petroleum_well, tailings_pond),
                landuse = "quarry"),
  commercial = list(building = "commercial",  # Could also be shops / malls etc. this is not a very specific tag...
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
                  religion = c("!no", "!none"),
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
                                 port, military, craft,
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
                                 commercial,
                                 power, utilities_other, # Power needs to be matched late because some offices are generated by power = generator etc.
                                 recreation,
                                 facilities,
                                 emergency)


#' @rdname classifications
#' @export
'osm_point_polygon_class_det'

osm_point_polygon_class_det_uo <- list(
  port = list(
    industrial = c("port", "port_yard", "harbour", "container_terminal"), # Before industrial category because port is also landuse = "industrial" combined with industrial = "port".
    office = "harbour_master",
    "seamark:type" = "harbour",
    landuse = "port"
  ),
  drinking = list(amenity = .c(bar, pub)),
  food = list(amenity = .c(fast_food, food_court, cafe, ice_cream, restaurant),
              tourism = "restaurant",
              shop = c("restaurant", "ice_cream")),
  shopping_essential = list(
    craft = "bakery", # No shop, could be wholesale
    amenity = c("marketplace", "shop"),
    shop = c("convenience", "kiosk", "clothes", "supermarket", "bakery", "butcher", "greengrocer", "beverages",
             "department_store", "shopping_centre", "mall", "general", "general_store", "local_shop", "grocery", "yes"), # yes is very general, but mostly grocery shops
    building = c("supermarket", "kiosk")
  ),
  craft = list(craft = ""),
  beauty = list(
    craft = c("wellness", "hairdresser"),
    shop = c("hairdresser", "beauty", "cosmetics")
  ),
  wholesale = list(
    office = c("pharmaceutical_products_wholesaler", "office_supplies"),
    shop = c("wholesale", "warehouse"),
    wholesale = "!no"
  ),
  shopping_other = list( # Match at the end?
    shop = c("!no", "!vacant"),
    building = "retail",
    landuse = "retail" # essential shopping ??
  ),
  education_essential = list(amenity = .c(college, school, university),
                             building = .c(college, school, university)),
  education_other = list(amenity = .c(driving_school, kindergarten, language_school,
                                      library, training, music_school, research_institute),
                         office = .c(educational_institution, tutoring, computer_training_school),
                         building = "kindergarten",
                         landuse = "education"),
  health_essential = list(amenity = .c(clinic, dentist, doctors, hospital, pharmacy),
                          building = "hospital",
                          healthcare = c(
                            "clinic", "centre", "primary", "yes", "hospital", "nurse", "centre_de_sante",
                            "pharmacy", "doctor", "birthing_centre", "health_center", "hospital_doctor",
                            "hospital_pharmacy", "doctor_laboratory_pharmacy", "clinic_doctor_laboratory",
                            "psychiatry", "paediatrics", "dentist_p", "health_care",
                            "centre_de_sante_integre", "birthing_center", "vaccination_centre",
                            "doctor_pharmacy_birthing_center", "center", "pharmacy_doctor", "midwife",
                            "dentist", "hospital_clinic", "public", "general_practitioner",
                            "health_post", "poste_dev_sante", "poste_de_sante", "health_outpost",
                            "community_health_post", "community_health_worker", "community_health_work"
                          ),
                          office = c("physician", "healthcare", "health_care")),
  pets = list(amenity = c("veterinary", "dog_toilet"), leisure = "dog_park"),
  health_other = list(
    amenity = c("nursing_home", "baby_hatch", "social_facility"),
    craft = "dental_technician",
    healthcare = "!no",
    office = c("medical", "therapist", "skin_care_clinic", "skincare")
  ),
  automotive = list(
    craft = c(
      "motorcycle_repair", "motocycle_repair", "garage_moto", "car_repair",
      "vulcanize", "vulcanizer"
    ),
    amenity = c(
      "parking", "fuel", "vehicle_inspection", "parking_space", "car_wash",
      "car_rental", "motorcycle_parking", "car_sharing",
      "charging_station", "compressed_air", "boat_rental",
      "parking_entrance", "boat_sharing"
    ),
    industrial = "car_repair",
    shop = c("car_repair", "car_parts", "car", "tyres", "motorcycle",
             "fuel", "motorcycle_repair", "motorcycle_parts")
  ),
  bicycle = list(
    amenity = c("bicycle_parking", "bicycle_repair_station", "bicycle_rental", "bicycle_wash"),
    shop = "bicycle",
    highway = "cycleway" # cycleway = ""? -> can be used in conjunction with other highway types if cycleway is next to road
  ),
  public_transport = list(
    public_transport = "", # all: could make separate category...
    amenity = "bus_station",
    office = "public_transport"
  ),
  water_transport = list(
    amenity = "ferry_terminal",
    waterway = c("dam", "weir", "lock_gate", "boatyard", "dock", "fuel", "canal", "river")
  ),
  transport_infrastructure = list(
    aerialway = "!no", # all except no
    aeroway = "!no", # all except no
    amenity = "grit_bin", # Other items are "automotive"
    bridge = "!no", # all except no
    building = c("train_station", "bridge"),
    highway = "!no", # all except no
    junction = "!no", # all except no
    man_made = c("bridge", "goods_conveyor"),
    railway = "!no", # all except no
    landuse = "railway",
    industrial = c("intermodal_freight_terminal", "terminal")
  ),
  transport_services = list(
    amenity = "taxi", # Other items are "automotive"
    building = "transportation",
    office = c("logistics", "moving_company", "transport", "airline",
               "transmaritime", "shipping_agent", "logistic", "association_de_transport"),
    industrial = "logistics"
  ),
  storage = list(
    building = c("hangar", "storage_tank", "silo", "warehouse"), # "warehouse" = wholesale? -> Nope, only shop = "warehouse"
    landuse = "depot",
    man_made = c("silo", "storage_tank"),
    industrial = c("depot", "storage", "oil_storage", "warehouse", "fuel_depot", "vehicle_depot",
                   "container_yard", "empty_container_depot", "grain_storage_centre"),
    office = "depot_de_boisson"
  ),
  communications_network = list(
    telecom = "",
    utility = "telecom",
    communication = c("line", "pole", "mobile", "mobile_phone", "mobile_phone=yes"),
    man_made = c("satellite_dish", "beacon", "antenna", "communication_tower", "communications_tower"), # "mast" -> identified by tower:type
    `tower:type` = c("communication", "radar", "radio_transmitter", "telecommunication", "radio"),
    industrial = c("communication", "telecommunication")
  ),
  communications_other = list(
    amenity = c("telephone", "internet_cafe", "studio"),
    # man_made = c("lighthouse", "telescope", "observatory", "surveillance"),
    office = c("telecommunication", "telecom", "radio_station", "newspaper",
               "radio_chretienne", "communication_agency", "telecommunications", "communication")
  ),
  accommodation = list(tourism = c("hotel", "guest_house", "motel", "hostel", "chalet", "apartment", "wilderness_hut",
                                   "alpine_hut", "lodge", "cabin", "house", "apartments", "hunting_lodge", "batiment",
                                   "guest_house_hotel", "apartment_hotel", "hotel_apartment", "luxury_lodge", "holiday_home"), #, camp_pitch, camp_site
                       building = "hotel"),
  museums = list(
    amenity = "planetarium",
    tourism = c("museum", "gallery", "aquarium", "monument", "gallery_museum")
  ),
  parks_and_nature = list(
    leisure = c("nature_reserve", "park", "water_park", "garden", "playground", "marina"),
    tourism = c("nature", "theme_park", "zoo", "bird_watching_and_fishing", "wetland", "bird_sanctuary"),
    landuse = "recreation_ground"
  ),
  beaches_and_resorts = list(
    leisure = "beach_resort",
    tourism = c("resort", "beach", "spa_resort", "holiday_resort")
  ),
  outdoor_activities = list(
    leisure = c("swimming_area", "fishing"),
    sport = c("water_sports", "scuba_diving", "surfing", "climbing", "sailing", "kitesurfing",
              "ultralight_aviation", "free_flying", "canoe", "skiing", "climbing_adventure",
              "canoe_sailing", "sailing_canoe", "sailing_water_ski_windsurfing",
              "sailing_kitesurfing_windsurfing_kayaking", "gliding", "parachuting",
              "free_diving", "windsurfing", "wind_surfing", "kite", "diving", "fishing",
              "flying", "surfing_sailing", "surfing_windsurfing", "surfing_kitesurfing_windsurfing",
              "kitesurfing_windsurfing", "surf", "kitesurfing_surfing", "surf_surfing",
              "water_sports_surf_sailing_fishing"),
    tourism = c("trail_riding_station", "rock_climing", "horsetrails"),
    landuse = "winter_sports"
  ),
  performing_arts = list(
    amenity = c("arts_centre", "theatre", "cinema"),
    leisure = "bandstand"
  ),
  nightlife = list( # casino could be gaming...
    amenity = c("casino", "love_hotel", "nightclub", "gambling", "brothel", "stripclub", "swingerclub"),
    leisure = "dance"
  ),
  gaming = list(
    craft = "amusement_arcade",
    leisure = c("amusement_arcade", "adult_gaming_centre", "miniature_golf"),
    sport = c("10_pin_bowling", "bowls", "bowling", "10pin_9pin", # "shooting_range", "shooting": now sport (rest)
              "archery", "10pin", "gaelic_games", "bullfighting", "miniature_golf", "9pin",
              "billiards", "snooker", "10pin_billiards", "table_soccer_darts_billiards", "billiards_snooker_soccer")
  ),
  sports = list(
    building = c("stadium", "grandstand", "pavilion", "sports_hall", "riding_hall"),
    leisure = c("stadium", "sports_centre", "pitch", "track", "swimming_pool", "fitness_centre", "fitness_station"),
    office = "sports",
    shop = "sports",
    sport = "!no" # rest (all others not used in outdoor_activities and gaming)
  ),
  facilities = list(
    amenity = c(
      "events_venue", "exhibition_centre", "conference_centre", "public_bath", # TODO: commercial??
      "public_bookcase", "social_centre",
      "toilets", "refugee_site", "shelter", "childcare", "dressing_room", "bbq",
      "shower", "kitchen", "drinking_water", "fountain", "vending_machine",
      "watering_place", "bench", "water_point", "parcel_locker", "clock",
      "give_box", "photo_booth"
    ),
    leisure = c("picnic_table", "common"),
    building = c("toilets", "civic"), # Civic building is very general tag, match last..
    office = "event_hall",
    tourism = "picnic_site"
  ),
  tours_and_sightseeing = list(tourism = c("!no", "!picnic_site"), # All except generic statements (in those cases the primary feature is something else)
                               shop = "travel_agency",
                               office = c("travel_agency", "tourism", "travel_agent", "guide")),
  financial = list(amenity = .c(atm, bank, bureau_de_change, mobile_money, mobile_money_agent, money_transfer, payment_terminal, payment_centre),
                   office = c("insurance", "financial", "accountant", "tax_advisor", "financial_advisor",
                              "financial_services", "accounting_firm", "insurance_broker", "health_insurance",
                              "tresor_de_mbacke", "finance", "investment", "bank", "insurance_company")),
  mining = list(man_made = c("tailings_pond", "adit", "petroleum_well", "mineshaft"),
                industrial = c("mine", "salt_ponds", "salt_pond", "hydrocarbon_field"),
                landuse = c("quarry", "salt_pond")),
  industrial = list(industrial = "", # Should be after all other uses of this tag, and before craft to ensure things that remain in craft are not industrial.
                    man_made = .c(kiln, works), # kiln might be too small...
                    building = "industrial",
                    landuse = "industrial"), # TODO: Port and railway not transport? But OSM suggests to declare it an industrial area.),
  commercial = list(office = c("company", "yes", "commercial", "office", "building", "private"), # Also match last, after institutional etc.
                    building = c("commercial", "office"), # Could also be shops / malls etc. this is not a very specific tag...
                    landuse = "commercial"),  # Predominantly commercial businesses and their offices.
  construction = list(# man_made = "crane", # A stationary, permanent crane. So not really for construction...
                      building = "construction", # TODO: save start_date: The (approximated) date when the building was finished!!!
                      highway = "construction",
                      landuse = "construction",
                      construction = "!no"), # Put this at the end to ensure nothing else is matched
  residential = list(building = .c(house, apartments, bungalow, detached, semidetached_house, terrace, dormitory, residential),
                     "building:use" = .c(residential, apartments),
                     landuse = "residential"),
  farming = list(place = "farm",
                 man_made = "beehive",
                 building = .c(farm, barn, cowshed, farm_auxiliary, greenhouse, slurry_tank, stable, sty),
                 landuse = .c(farmland, farmyard, orchard, vineyard, aquaculture, greenhouse_horticulture, plant_nursery)),
  emergency = list(emergency = "!no"),
  historic = list(historic = "!no"),
  religion = list(amenity = .c(funeral_hall, grave_yard, monastery, place_of_mourning, place_of_worship),
                  building = .c(cathedral, chapel, church, kingdom_hall, monastery, mosque, presbytery, shrine, synagogue, temple, religious),
                  office = c("religion", "church", "parish"), # Parish is mostly religion...
                  landuse = "religious",
                  religion = c("!no", "!none"),
                  denomination = ""),
  professional_services = list(
    leisure = "hackerspace",
    craft = c("it_consulting", "graphic_design"),
    office = c("research", "it", "coworking", "graphic_design", "engineer",
               "architect", "lawyer", "law_firm", "geodesist", "land_surveyors",
               "civil_engineer",  "topographer", "web_design",
               "smith_aegis_plc_leading_digital_marketing_advertising_pr_agency",
               "incubator", "consultants", "consulting", "landscape_architects", "designer", "engineering",
               "gis_and_drone_surveying", "notary", "surveyor", "private_investigator")
  ),
  business_services = list(
    office = c("advertising_agency", "employment_agency", "printing",
               "aerial_photographer", "property_management",
               "corporate_cleaning_hygiene_and_pest_control_services",
               "emplyment_agency",  "wedo_business_solutions", "publisher", "courier")
  ),
  home_services = list(
    amenity = "crematorium",
    craft = c("caterer", "gardener", "gardening", "cleaning", "building_maintenance", "signmaker", "pest_control", "sweep"),
    office = c("event_management", "interior_design", "wedding_planner", "estate_agency", "estate_agent", "estate", "security"),
    shop = c("dry_cleaning", "laundry", "funeral_directors")
  ),
  military = list(military = "",
                  building = .c(military, barracks, bunker),
                  landuse = "military"),
  institutional = list(office = c("government", "ngo", "association", "diplomatic", "political_party",
                                  "red_cross", "ministry_of_labour", "administrative", "international_organization", "charity",
                                  "union", "monuments_and_relics_commission", "organisation_de_la_societe_civile",
                                  "association_cooperative", "cooperative", "association_political_party",
                                  "igo", "un", "unhcr_office", "foundation", "labour_union", "municipality", "tax", "taxe",  # public tresor, import taxes etc.
                                  "goverment", "immigration", "development_agency_office", "non_government_association",
                                  "foreign_national_agency", "politique", "student", "student_union", "humanitarian", "party",
                                  "intenational_ngo", "international_ngo", "ingo",  "association_ngo", "ecowas_institution",
                                  "gouvernement", "asociation", "institute", "company_government", "politician", "quango",
                                  "qquango", "forestry", "administration"),
                       building = "government",
                       landuse = "institutional"),
  public_service = list(amenity = .c(community_centre, courthouse, fire_station, police, post_box, post_depot, post_office, prison, ranger_station, townhall, public_building),
                        building = .c(fire_station,  public), # public also more general tag, but fits quite well...
                        office = c("police", "visa", "communal", "sos_childrens_village")),
  office_other = list(office = "!no"), # Any other office
  power_plant_large = list(power = "plant"),
  power_plant_small = list(power = c("generator", "solar", "solar_panels", "wind", "wind_turbine")),
  power_other = list(power = "",
                     utility = "power",
                     building = "transformer_tower",
                     "tower:type" = "power"), # office = c("energy_supplier", "electricite") ?
  waste = list(amenity = .c(sanitary_dump_station, recycling, waste_basket, waste_disposal, waste_transfer_station),
               water = 	"wastewater",
               man_made = "wastewater_plant",
               waterway = c("sanitary_dump_station", "wastewater"),
               landuse = "landfill"),
  utilities_other = list(man_made = .c(water_tower, water_well, water_works, water_tap, water_tank, gasometer,
                                       pipeline, pump, pumping_rig, pumping_station, reservoir_covered, street_cabinet),
                         water = "reservoir", #  shop = c("energy", "gas"), # energy and gas here mostly cooking gas. Could also be shopping_other
                         office = "water_utility",
                         waterway = c("drain", "spillway", "distribution_tower", "drain_building_drain",
                                      "drain_inlet", "drain_pipe_inflow", "drain_outflow", "drain_culvert_entrance",
                                      "drain_bridge", "underground_drain", "drain_junction", "drain_silt_trap"),
                         building = .c(digester, service, water_tower),
                         landuse = "reservoir")
)

# # Check duplicates
# tmp <- osm_point_polygon_class_det_uo |>
#   lapply(function(x) paste(rep(names(x), lengths(x)), unlist(x), sep = " = ")) |>
#   unlist()
# tmp[fduplicated(tmp, all = TRUE)]


# Ordering according to tag priorities... and likelihood of duplicate matches
osm_point_polygon_class_det <- colorder(osm_point_polygon_class_det_uo,
                                 # Big important structures
                                 port, military, power_plant_large,
                                 education_essential,
                                 accommodation,

                                 food, drinking,


                                 health_essential, pets,
                                 education_other, health_other,


                                 mining, farming,

                                 museums, parks_and_nature,
                                 beaches_and_resorts, outdoor_activities, performing_arts, nightlife, gaming,

                                 tours_and_sightseeing, # Needs to be last usage of tourism tag
                                 sports,


                                 institutional, public_service,

                                 professional_services, business_services, home_services,

                                 storage, communications_network, communications_other,
                                 automotive, bicycle, public_transport, water_transport, transport_infrastructure,
                                 transport_services,

                                 industrial, # Last usage of industrial tag

                                 wholesale, shopping_essential, beauty, # Needs to be after tourism, and before financial, as many shops have mobile money agents...

                                 financial,
                                 religion,
                                 construction,

                                 waste,
                                 commercial,
                                 power_plant_small, power_other, utilities_other, # Power needs to be matched late because some offices are generated by power = generator etc.

                                 craft, # Ensure this is the last use of craft key
                                 office_other,
                                 shopping_other,
                                 facilities,
                                 residential, historic, # Todo: historic earlier ? e.g. historic mines etc.. needs to be after tourism though.. and historic mines may also be useful for economic development
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

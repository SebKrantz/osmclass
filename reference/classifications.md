# Classification of OSM Features by Economic Function

A classification of OSM features by economic function. A newer detailed
version is available for points and polygons.

## Usage

``` r
osm_point_polygon_class

osm_point_polygon_class_det

osm_line_class

osm_line_info_tags
```

## Format

An object of class `list` of length 34.

An object of class `list` of length 55.

An object of class `list` of length 11.

An object of class `list` of length 11.

## Details

The simple classification, developed for Krantz (2023), aims to classify
OSM features into meaningful and specific economic categories such as
'education', 'health', 'tourism', 'financial', 'shopping', 'transport',
'communications', 'industrial', 'residential', 'road', 'railway',
'pipeline', 'power', 'waterway' etc. Separate classifications are
developed for points and polygons (buildings) (33 categories), and lines
(11 categories), which should be applied to the respective layers of OSM
PBF files, see
[osmclass-package](https://sebkrantz.github.io/osmclass/reference/osmclass-package.md)
for and example. The classification is optimized (in terms of tag choice
and order of categories) to assign the most sensible primary category to
most features in the Africa OSM.

In spring 2025, I added a more detailed classification with 55
categories (`osm_point_polygon_class_det`) for point and polygon-based
features, approximately reflecting an extended database used in the
November 2024 update of the article where OSM features are combined with
other geospatial data sources.

## References

Krantz, Sebastian, Mapping Africa’s Infrastructure Potential with
Geospatial Big Data, Causal ML, and XAI (August 10, 2023). Available at
SSRN: https://www.ssrn.com/abstract=4537867

## See also

[osmclass-package](https://sebkrantz.github.io/osmclass/reference/osmclass-package.md)

## Examples

``` r
collapse::unlist2d(osm_point_polygon_class, idcols = c("category", "tag"))
#>            category              tag                      V1
#> 1              port          landuse                    port
#> 2          military         military                        
#> 3          military         building                military
#> 4          military          landuse                military
#> 5             craft            craft                        
#> 6             craft             shop               locksmith
#> 7         education          amenity                 college
#> 8         education         building                 college
#> 9         education          landuse               education
#> 10    education_alt          amenity          driving_school
#> 11    education_alt           office educational_institution
#> 12    education_alt         building            kindergarten
#> 13           health          amenity              baby_hatch
#> 14           health       healthcare                        
#> 15           health         building                hospital
#> 16          farming            place                    farm
#> 17          farming         man_made                 beehive
#> 18          farming         building                    farm
#> 19          farming          landuse                farmland
#> 20           mining         man_made                    adit
#> 21           mining          landuse                  quarry
#> 22       industrial       industrial                        
#> 23       industrial         man_made                    kiln
#> 24       industrial         building              industrial
#> 25       industrial          landuse              industrial
#> 26    accommodation          tourism               apartment
#> 27    accommodation         building                   hotel
#> 28             food          amenity                     bar
#> 29          tourism          tourism                     !no
#> 30          tourism             shop           travel_agency
#> 31          tourism           office                   guide
#> 32       creativity          amenity       conference_centre
#> 33       creativity          leisure             hackerspace
#> 34       creativity           office          graphic_design
#> 35           sports          leisure          fitness_centre
#> 36           sports            sport                        
#> 37           sports         building              grandstand
#> 38    entertainment          amenity             arts_centre
#> 39    entertainment          leisure     adult_gaming_centre
#> 40    institutional           office              government
#> 41    institutional         building              government
#> 42    institutional          landuse           institutional
#> 43   public_service          amenity              courthouse
#> 44   public_service         building            fire_station
#> 45          storage         man_made                    silo
#> 46          storage         building                  hangar
#> 47          storage          landuse                   depot
#> 48   communications          amenity           internet_cafe
#> 49   communications          telecom                        
#> 50   communications          utility                 telecom
#> 51   communications         man_made                 antenna
#> 52   communications           office       telecommunication
#> 53   communications       tower:type           communication
#> 54   communications    communication                    line
#> 55        transport          amenity         bicycle_parking
#> 56        transport          highway                crossing
#> 57        transport          railway                        
#> 58        transport        aerialway                        
#> 59        transport         waterway              !waterfall
#> 60        transport          aeroway                        
#> 61        transport public_transport                        
#> 62        transport           bridge                        
#> 63        transport         junction                        
#> 64        transport           office               logistics
#> 65        transport         man_made                  bridge
#> 66        transport         building           train_station
#> 67        transport          landuse                 railway
#> 68         shopping          amenity             marketplace
#> 69         shopping             shop                     !no
#> 70         shopping         building                  retail
#> 71         shopping          landuse                  retail
#> 72        financial          amenity                     atm
#> 73        financial           office              accountant
#> 74         religion          amenity            funeral_hall
#> 75         religion         building               cathedral
#> 76         religion           office                religion
#> 77         religion          landuse               religious
#> 78         religion         religion                     !no
#> 79         religion     denomination                        
#> 80     construction         building            construction
#> 81     construction          landuse            construction
#> 82      residential         building                   house
#> 83      residential     building:use             residential
#> 84      residential          landuse             residential
#> 85         historic         historic                     !no
#> 86            waste          amenity   sanitary_dump_station
#> 87            waste            water              wastewater
#> 88            waste         man_made        wastewater_plant
#> 89            waste          landuse                landfill
#> 90     office_other           office                        
#> 91     office_other         building                  office
#> 92       commercial         building              commercial
#> 93       commercial          landuse              commercial
#> 94            power            power                        
#> 95            power          utility                   power
#> 96            power         building       transformer_tower
#> 97            power       tower:type                   power
#> 98  utilities_other         man_made             water_tower
#> 99  utilities_other            water               reservoir
#> 100 utilities_other           office           water_utility
#> 101 utilities_other         building                digester
#> 102 utilities_other          landuse               reservoir
#> 103      recreation          amenity        community_centre
#> 104      recreation          leisure            beach_resort
#> 105      recreation          landuse       recreation_ground
#> 106      recreation         building                   civic
#> 107      facilities          amenity                     bbq
#> 108      facilities         building                 toilets
#> 109       emergency        emergency                     !no
#>                         V2                  V3                   V4
#> 1                     <NA>                <NA>                 <NA>
#> 2                     <NA>                <NA>                 <NA>
#> 3                 barracks              bunker                 <NA>
#> 4                     <NA>                <NA>                 <NA>
#> 5                     <NA>                <NA>                 <NA>
#> 6                     <NA>                <NA>                 <NA>
#> 7                   school          university                 <NA>
#> 8                   school          university                 <NA>
#> 9                     <NA>                <NA>                 <NA>
#> 10            kindergarten     language_school              library
#> 11                tutoring                <NA>                 <NA>
#> 12                    <NA>                <NA>                 <NA>
#> 13                  clinic             dentist              doctors
#> 14                    <NA>                <NA>                 <NA>
#> 15                    <NA>                <NA>                 <NA>
#> 16                    <NA>                <NA>                 <NA>
#> 17                    <NA>                <NA>                 <NA>
#> 18                    barn        conservatory              cowshed
#> 19                farmyard             orchard             vineyard
#> 20               mineshaft      petroleum_well        tailings_pond
#> 21                    <NA>                <NA>                 <NA>
#> 22                    <NA>                <NA>                 <NA>
#> 23                   works                <NA>                 <NA>
#> 24                    <NA>                <NA>                 <NA>
#> 25                    <NA>                <NA>                 <NA>
#> 26                  chalet         guest_house               hostel
#> 27                    <NA>                <NA>                 <NA>
#> 28                    cafe           fast_food           food_court
#> 29                    <NA>                <NA>                 <NA>
#> 30                    <NA>                <NA>                 <NA>
#> 31            travel_agent                <NA>                 <NA>
#> 32                  studio                <NA>                 <NA>
#> 33                    <NA>                <NA>                 <NA>
#> 34               coworking            engineer                   it
#> 35         fitness_station               pitch        sports_centre
#> 36                    <NA>                <NA>                 <NA>
#> 37                pavilion         riding_hall          sports_hall
#> 38       exhibition_centre             brothel               casino
#> 39        amusement_arcade           bandstand                dance
#> 40                     ngo         association           diplomatic
#> 41                    <NA>                <NA>                 <NA>
#> 42                    <NA>                <NA>                 <NA>
#> 43            fire_station              police             post_box
#> 44                  public                <NA>                 <NA>
#> 45            storage_tank                <NA>                 <NA>
#> 46            storage_tank                silo                 <NA>
#> 47                    <NA>                <NA>                 <NA>
#> 48               telephone                <NA>                 <NA>
#> 49                    <NA>                <NA>                 <NA>
#> 50                    <NA>                <NA>                 <NA>
#> 51                  beacon communication_tower communications_tower
#> 52                    <NA>                <NA>                 <NA>
#> 53       telecommunication               radar                radio
#> 54                    pole              mobile         mobile_phone
#> 55  bicycle_repair_station      bicycle_rental          boat_rental
#> 56         mini_roundabout   motorway_junction      traffic_signals
#> 57                    <NA>                <NA>                 <NA>
#> 58                    <NA>                <NA>                 <NA>
#> 59                 !stream         !stream_end              !rapids
#> 60                    <NA>                <NA>                 <NA>
#> 61                    <NA>                <NA>                 <NA>
#> 62                    <NA>                <NA>                 <NA>
#> 63                    <NA>                <NA>                 <NA>
#> 64          moving_company                <NA>                 <NA>
#> 65          goods_conveyor                <NA>                 <NA>
#> 66          transportation              bridge                 <NA>
#> 67                    <NA>                <NA>                 <NA>
#> 68                    shop                <NA>                 <NA>
#> 69                 !vacant                <NA>                 <NA>
#> 70                   kiosk         supermarket            warehouse
#> 71                    <NA>                <NA>                 <NA>
#> 72                    bank    bureau_de_change         mobile_money
#> 73               financial   financial_advisor            insurance
#> 74             crematorium          grave_yard            monastery
#> 75                  chapel              church         kingdom_hall
#> 76                    <NA>                <NA>                 <NA>
#> 77                    <NA>                <NA>                 <NA>
#> 78                   !none                <NA>                 <NA>
#> 79                    <NA>                <NA>                 <NA>
#> 80                    <NA>                <NA>                 <NA>
#> 81                    <NA>                <NA>                 <NA>
#> 82              apartments            bungalow             detached
#> 83              apartments                <NA>                 <NA>
#> 84                    <NA>                <NA>                 <NA>
#> 85                    <NA>                <NA>                 <NA>
#> 86               recycling        waste_basket       waste_disposal
#> 87                    <NA>                <NA>                 <NA>
#> 88                    <NA>                <NA>                 <NA>
#> 89                    <NA>                <NA>                 <NA>
#> 90                    <NA>                <NA>                 <NA>
#> 91                    <NA>                <NA>                 <NA>
#> 92                    <NA>                <NA>                 <NA>
#> 93                    <NA>                <NA>                 <NA>
#> 94                    <NA>                <NA>                 <NA>
#> 95                    <NA>                <NA>                 <NA>
#> 96                    <NA>                <NA>                 <NA>
#> 97                    <NA>                <NA>                 <NA>
#> 98              water_well         water_works            water_tap
#> 99                    <NA>                <NA>                 <NA>
#> 100                   <NA>                <NA>                 <NA>
#> 101                service         water_tower                 <NA>
#> 102                   <NA>                <NA>                 <NA>
#> 103               fountain         public_bath      public_bookcase
#> 104                 marina      miniature_golf               common
#> 105                   <NA>                <NA>                 <NA>
#> 106                   <NA>                <NA>                 <NA>
#> 107                  bench          dog_toilet            childcare
#> 108                   <NA>                <NA>                 <NA>
#> 109                   <NA>                <NA>                 <NA>
#>                         V5               V6                      V7
#> 1                     <NA>             <NA>                    <NA>
#> 2                     <NA>             <NA>                    <NA>
#> 3                     <NA>             <NA>                    <NA>
#> 4                     <NA>             <NA>                    <NA>
#> 5                     <NA>             <NA>                    <NA>
#> 6                     <NA>             <NA>                    <NA>
#> 7                     <NA>             <NA>                    <NA>
#> 8                     <NA>             <NA>                    <NA>
#> 9                     <NA>             <NA>                    <NA>
#> 10                training     music_school                    <NA>
#> 11                    <NA>             <NA>                    <NA>
#> 12                    <NA>             <NA>                    <NA>
#> 13                hospital     nursing_home                pharmacy
#> 14                    <NA>             <NA>                    <NA>
#> 15                    <NA>             <NA>                    <NA>
#> 16                    <NA>             <NA>                    <NA>
#> 17                    <NA>             <NA>                    <NA>
#> 18          farm_auxiliary       greenhouse             slurry_tank
#> 19             aquaculture        salt_pond greenhouse_horticulture
#> 20                    <NA>             <NA>                    <NA>
#> 21                    <NA>             <NA>                    <NA>
#> 22                    <NA>             <NA>                    <NA>
#> 23                    <NA>             <NA>                    <NA>
#> 24                    <NA>             <NA>                    <NA>
#> 25                    <NA>             <NA>                    <NA>
#> 26                   hotel            motel          wilderness_hut
#> 27                    <NA>             <NA>                    <NA>
#> 28               ice_cream              pub              restaurant
#> 29                    <NA>             <NA>                    <NA>
#> 30                    <NA>             <NA>                    <NA>
#> 31                    <NA>             <NA>                    <NA>
#> 32                    <NA>             <NA>                    <NA>
#> 33                    <NA>             <NA>                    <NA>
#> 34                research             <NA>                    <NA>
#> 35                 stadium    swimming_pool                   track
#> 36                    <NA>             <NA>                    <NA>
#> 37                 stadium             <NA>                    <NA>
#> 38                  cinema     events_venue                gambling
#> 39                    <NA>             <NA>                    <NA>
#> 40         political_party             <NA>                    <NA>
#> 41                    <NA>             <NA>                    <NA>
#> 42                    <NA>             <NA>                    <NA>
#> 43              post_depot      post_office                  prison
#> 44                    <NA>             <NA>                    <NA>
#> 45                    <NA>             <NA>                    <NA>
#> 46                    <NA>             <NA>                    <NA>
#> 47                    <NA>             <NA>                    <NA>
#> 48                    <NA>             <NA>                    <NA>
#> 49                    <NA>             <NA>                    <NA>
#> 50                    <NA>             <NA>                    <NA>
#> 51              lighthouse   satellite_dish                    <NA>
#> 52                    <NA>             <NA>                    <NA>
#> 53       radio_transmitter             <NA>                    <NA>
#> 54        mobile_phone=yes             <NA>                    <NA>
#> 55            boat_sharing      bus_station           train_station
#> 56          turning_circle     turning_loop                bus_stop
#> 57                    <NA>             <NA>                    <NA>
#> 58                    <NA>             <NA>                    <NA>
#> 59          !tidal_channel       !riverbank                    <NA>
#> 60                    <NA>             <NA>                    <NA>
#> 61                    <NA>             <NA>                    <NA>
#> 62                    <NA>             <NA>                    <NA>
#> 63                    <NA>             <NA>                    <NA>
#> 64                    <NA>             <NA>                    <NA>
#> 65                    <NA>             <NA>                    <NA>
#> 66                    <NA>             <NA>                    <NA>
#> 67                    <NA>             <NA>                    <NA>
#> 68                    <NA>             <NA>                    <NA>
#> 69                    <NA>             <NA>                    <NA>
#> 70                    <NA>             <NA>                    <NA>
#> 71                    <NA>             <NA>                    <NA>
#> 72      mobile_money_agent   money_transfer                    <NA>
#> 73             tax_advisor             <NA>                    <NA>
#> 74       place_of_mourning place_of_worship                    <NA>
#> 75               monastery           mosque              presbytery
#> 76                    <NA>             <NA>                    <NA>
#> 77                    <NA>             <NA>                    <NA>
#> 78                    <NA>             <NA>                    <NA>
#> 79                    <NA>             <NA>                    <NA>
#> 80                    <NA>             <NA>                    <NA>
#> 81                    <NA>             <NA>                    <NA>
#> 82      semidetached_house          terrace               dormitory
#> 83                    <NA>             <NA>                    <NA>
#> 84                    <NA>             <NA>                    <NA>
#> 85                    <NA>             <NA>                    <NA>
#> 86  waste_transfer_station             <NA>                    <NA>
#> 87                    <NA>             <NA>                    <NA>
#> 88                    <NA>             <NA>                    <NA>
#> 89                    <NA>             <NA>                    <NA>
#> 90                    <NA>             <NA>                    <NA>
#> 91                    <NA>             <NA>                    <NA>
#> 92                    <NA>             <NA>                    <NA>
#> 93                    <NA>             <NA>                    <NA>
#> 94                    <NA>             <NA>                    <NA>
#> 95                    <NA>             <NA>                    <NA>
#> 96                    <NA>             <NA>                    <NA>
#> 97                    <NA>             <NA>                    <NA>
#> 98              water_tank        gasometer                pipeline
#> 99                    <NA>             <NA>                    <NA>
#> 100                   <NA>             <NA>                    <NA>
#> 101                   <NA>             <NA>                    <NA>
#> 102                   <NA>             <NA>                    <NA>
#> 103          social_centre             <NA>                    <NA>
#> 104                   park         dog_park              water_park
#> 105                   <NA>             <NA>                    <NA>
#> 106                   <NA>             <NA>                    <NA>
#> 107                  clock      photo_booth                 kitchen
#> 108                   <NA>             <NA>                    <NA>
#> 109                   <NA>             <NA>                    <NA>
#>                  V8             V9             V10               V11
#> 1              <NA>           <NA>            <NA>              <NA>
#> 2              <NA>           <NA>            <NA>              <NA>
#> 3              <NA>           <NA>            <NA>              <NA>
#> 4              <NA>           <NA>            <NA>              <NA>
#> 5              <NA>           <NA>            <NA>              <NA>
#> 6              <NA>           <NA>            <NA>              <NA>
#> 7              <NA>           <NA>            <NA>              <NA>
#> 8              <NA>           <NA>            <NA>              <NA>
#> 9              <NA>           <NA>            <NA>              <NA>
#> 10             <NA>           <NA>            <NA>              <NA>
#> 11             <NA>           <NA>            <NA>              <NA>
#> 12             <NA>           <NA>            <NA>              <NA>
#> 13  social_facility     veterinary            <NA>              <NA>
#> 14             <NA>           <NA>            <NA>              <NA>
#> 15             <NA>           <NA>            <NA>              <NA>
#> 16             <NA>           <NA>            <NA>              <NA>
#> 17             <NA>           <NA>            <NA>              <NA>
#> 18           stable            sty            <NA>              <NA>
#> 19    plant_nursery           <NA>            <NA>              <NA>
#> 20             <NA>           <NA>            <NA>              <NA>
#> 21             <NA>           <NA>            <NA>              <NA>
#> 22             <NA>           <NA>            <NA>              <NA>
#> 23             <NA>           <NA>            <NA>              <NA>
#> 24             <NA>           <NA>            <NA>              <NA>
#> 25             <NA>           <NA>            <NA>              <NA>
#> 26             <NA>           <NA>            <NA>              <NA>
#> 27             <NA>           <NA>            <NA>              <NA>
#> 28             <NA>           <NA>            <NA>              <NA>
#> 29             <NA>           <NA>            <NA>              <NA>
#> 30             <NA>           <NA>            <NA>              <NA>
#> 31             <NA>           <NA>            <NA>              <NA>
#> 32             <NA>           <NA>            <NA>              <NA>
#> 33             <NA>           <NA>            <NA>              <NA>
#> 34             <NA>           <NA>            <NA>              <NA>
#> 35             <NA>           <NA>            <NA>              <NA>
#> 36             <NA>           <NA>            <NA>              <NA>
#> 37             <NA>           <NA>            <NA>              <NA>
#> 38       love_hotel      nightclub     planetarium         stripclub
#> 39             <NA>           <NA>            <NA>              <NA>
#> 40             <NA>           <NA>            <NA>              <NA>
#> 41             <NA>           <NA>            <NA>              <NA>
#> 42             <NA>           <NA>            <NA>              <NA>
#> 43   ranger_station       townhall public_building              <NA>
#> 44             <NA>           <NA>            <NA>              <NA>
#> 45             <NA>           <NA>            <NA>              <NA>
#> 46             <NA>           <NA>            <NA>              <NA>
#> 47             <NA>           <NA>            <NA>              <NA>
#> 48             <NA>           <NA>            <NA>              <NA>
#> 49             <NA>           <NA>            <NA>              <NA>
#> 50             <NA>           <NA>            <NA>              <NA>
#> 51             <NA>           <NA>            <NA>              <NA>
#> 52             <NA>           <NA>            <NA>              <NA>
#> 53             <NA>           <NA>            <NA>              <NA>
#> 54             <NA>           <NA>            <NA>              <NA>
#> 55       car_rental    car_sharing        car_wash    compressed_air
#> 56         services   speed_camera            <NA>              <NA>
#> 57             <NA>           <NA>            <NA>              <NA>
#> 58             <NA>           <NA>            <NA>              <NA>
#> 59             <NA>           <NA>            <NA>              <NA>
#> 60             <NA>           <NA>            <NA>              <NA>
#> 61             <NA>           <NA>            <NA>              <NA>
#> 62             <NA>           <NA>            <NA>              <NA>
#> 63             <NA>           <NA>            <NA>              <NA>
#> 64             <NA>           <NA>            <NA>              <NA>
#> 65             <NA>           <NA>            <NA>              <NA>
#> 66             <NA>           <NA>            <NA>              <NA>
#> 67             <NA>           <NA>            <NA>              <NA>
#> 68             <NA>           <NA>            <NA>              <NA>
#> 69             <NA>           <NA>            <NA>              <NA>
#> 70             <NA>           <NA>            <NA>              <NA>
#> 71             <NA>           <NA>            <NA>              <NA>
#> 72             <NA>           <NA>            <NA>              <NA>
#> 73             <NA>           <NA>            <NA>              <NA>
#> 74             <NA>           <NA>            <NA>              <NA>
#> 75           shrine      synagogue          temple         religious
#> 76             <NA>           <NA>            <NA>              <NA>
#> 77             <NA>           <NA>            <NA>              <NA>
#> 78             <NA>           <NA>            <NA>              <NA>
#> 79             <NA>           <NA>            <NA>              <NA>
#> 80             <NA>           <NA>            <NA>              <NA>
#> 81             <NA>           <NA>            <NA>              <NA>
#> 82      residential           <NA>            <NA>              <NA>
#> 83             <NA>           <NA>            <NA>              <NA>
#> 84             <NA>           <NA>            <NA>              <NA>
#> 85             <NA>           <NA>            <NA>              <NA>
#> 86             <NA>           <NA>            <NA>              <NA>
#> 87             <NA>           <NA>            <NA>              <NA>
#> 88             <NA>           <NA>            <NA>              <NA>
#> 89             <NA>           <NA>            <NA>              <NA>
#> 90             <NA>           <NA>            <NA>              <NA>
#> 91             <NA>           <NA>            <NA>              <NA>
#> 92             <NA>           <NA>            <NA>              <NA>
#> 93             <NA>           <NA>            <NA>              <NA>
#> 94             <NA>           <NA>            <NA>              <NA>
#> 95             <NA>           <NA>            <NA>              <NA>
#> 96             <NA>           <NA>            <NA>              <NA>
#> 97             <NA>           <NA>            <NA>              <NA>
#> 98             pump    pumping_rig pumping_station reservoir_covered
#> 99             <NA>           <NA>            <NA>              <NA>
#> 100            <NA>           <NA>            <NA>              <NA>
#> 101            <NA>           <NA>            <NA>              <NA>
#> 102            <NA>           <NA>            <NA>              <NA>
#> 103            <NA>           <NA>            <NA>              <NA>
#> 104  nature_reserve   picnic_table         fishing            garden
#> 105            <NA>           <NA>            <NA>              <NA>
#> 106            <NA>           <NA>            <NA>              <NA>
#> 107   dressing_room drinking_water        give_box     parcel_locker
#> 108            <NA>           <NA>            <NA>              <NA>
#> 109            <NA>           <NA>            <NA>              <NA>
#>                    V12              V13            V14         V15
#> 1                 <NA>             <NA>           <NA>        <NA>
#> 2                 <NA>             <NA>           <NA>        <NA>
#> 3                 <NA>             <NA>           <NA>        <NA>
#> 4                 <NA>             <NA>           <NA>        <NA>
#> 5                 <NA>             <NA>           <NA>        <NA>
#> 6                 <NA>             <NA>           <NA>        <NA>
#> 7                 <NA>             <NA>           <NA>        <NA>
#> 8                 <NA>             <NA>           <NA>        <NA>
#> 9                 <NA>             <NA>           <NA>        <NA>
#> 10                <NA>             <NA>           <NA>        <NA>
#> 11                <NA>             <NA>           <NA>        <NA>
#> 12                <NA>             <NA>           <NA>        <NA>
#> 13                <NA>             <NA>           <NA>        <NA>
#> 14                <NA>             <NA>           <NA>        <NA>
#> 15                <NA>             <NA>           <NA>        <NA>
#> 16                <NA>             <NA>           <NA>        <NA>
#> 17                <NA>             <NA>           <NA>        <NA>
#> 18                <NA>             <NA>           <NA>        <NA>
#> 19                <NA>             <NA>           <NA>        <NA>
#> 20                <NA>             <NA>           <NA>        <NA>
#> 21                <NA>             <NA>           <NA>        <NA>
#> 22                <NA>             <NA>           <NA>        <NA>
#> 23                <NA>             <NA>           <NA>        <NA>
#> 24                <NA>             <NA>           <NA>        <NA>
#> 25                <NA>             <NA>           <NA>        <NA>
#> 26                <NA>             <NA>           <NA>        <NA>
#> 27                <NA>             <NA>           <NA>        <NA>
#> 28                <NA>             <NA>           <NA>        <NA>
#> 29                <NA>             <NA>           <NA>        <NA>
#> 30                <NA>             <NA>           <NA>        <NA>
#> 31                <NA>             <NA>           <NA>        <NA>
#> 32                <NA>             <NA>           <NA>        <NA>
#> 33                <NA>             <NA>           <NA>        <NA>
#> 34                <NA>             <NA>           <NA>        <NA>
#> 35                <NA>             <NA>           <NA>        <NA>
#> 36                <NA>             <NA>           <NA>        <NA>
#> 37                <NA>             <NA>           <NA>        <NA>
#> 38         swingerclub          theatre           <NA>        <NA>
#> 39                <NA>             <NA>           <NA>        <NA>
#> 40                <NA>             <NA>           <NA>        <NA>
#> 41                <NA>             <NA>           <NA>        <NA>
#> 42                <NA>             <NA>           <NA>        <NA>
#> 43                <NA>             <NA>           <NA>        <NA>
#> 44                <NA>             <NA>           <NA>        <NA>
#> 45                <NA>             <NA>           <NA>        <NA>
#> 46                <NA>             <NA>           <NA>        <NA>
#> 47                <NA>             <NA>           <NA>        <NA>
#> 48                <NA>             <NA>           <NA>        <NA>
#> 49                <NA>             <NA>           <NA>        <NA>
#> 50                <NA>             <NA>           <NA>        <NA>
#> 51                <NA>             <NA>           <NA>        <NA>
#> 52                <NA>             <NA>           <NA>        <NA>
#> 53                <NA>             <NA>           <NA>        <NA>
#> 54                <NA>             <NA>           <NA>        <NA>
#> 55  vehicle_inspection charging_station ferry_terminal        fuel
#> 56                <NA>             <NA>           <NA>        <NA>
#> 57                <NA>             <NA>           <NA>        <NA>
#> 58                <NA>             <NA>           <NA>        <NA>
#> 59                <NA>             <NA>           <NA>        <NA>
#> 60                <NA>             <NA>           <NA>        <NA>
#> 61                <NA>             <NA>           <NA>        <NA>
#> 62                <NA>             <NA>           <NA>        <NA>
#> 63                <NA>             <NA>           <NA>        <NA>
#> 64                <NA>             <NA>           <NA>        <NA>
#> 65                <NA>             <NA>           <NA>        <NA>
#> 66                <NA>             <NA>           <NA>        <NA>
#> 67                <NA>             <NA>           <NA>        <NA>
#> 68                <NA>             <NA>           <NA>        <NA>
#> 69                <NA>             <NA>           <NA>        <NA>
#> 70                <NA>             <NA>           <NA>        <NA>
#> 71                <NA>             <NA>           <NA>        <NA>
#> 72                <NA>             <NA>           <NA>        <NA>
#> 73                <NA>             <NA>           <NA>        <NA>
#> 74                <NA>             <NA>           <NA>        <NA>
#> 75                <NA>             <NA>           <NA>        <NA>
#> 76                <NA>             <NA>           <NA>        <NA>
#> 77                <NA>             <NA>           <NA>        <NA>
#> 78                <NA>             <NA>           <NA>        <NA>
#> 79                <NA>             <NA>           <NA>        <NA>
#> 80                <NA>             <NA>           <NA>        <NA>
#> 81                <NA>             <NA>           <NA>        <NA>
#> 82                <NA>             <NA>           <NA>        <NA>
#> 83                <NA>             <NA>           <NA>        <NA>
#> 84                <NA>             <NA>           <NA>        <NA>
#> 85                <NA>             <NA>           <NA>        <NA>
#> 86                <NA>             <NA>           <NA>        <NA>
#> 87                <NA>             <NA>           <NA>        <NA>
#> 88                <NA>             <NA>           <NA>        <NA>
#> 89                <NA>             <NA>           <NA>        <NA>
#> 90                <NA>             <NA>           <NA>        <NA>
#> 91                <NA>             <NA>           <NA>        <NA>
#> 92                <NA>             <NA>           <NA>        <NA>
#> 93                <NA>             <NA>           <NA>        <NA>
#> 94                <NA>             <NA>           <NA>        <NA>
#> 95                <NA>             <NA>           <NA>        <NA>
#> 96                <NA>             <NA>           <NA>        <NA>
#> 97                <NA>             <NA>           <NA>        <NA>
#> 98      street_cabinet             <NA>           <NA>        <NA>
#> 99                <NA>             <NA>           <NA>        <NA>
#> 100               <NA>             <NA>           <NA>        <NA>
#> 101               <NA>             <NA>           <NA>        <NA>
#> 102               <NA>             <NA>           <NA>        <NA>
#> 103               <NA>             <NA>           <NA>        <NA>
#> 104         playground    swimming_area           <NA>        <NA>
#> 105               <NA>             <NA>           <NA>        <NA>
#> 106               <NA>             <NA>           <NA>        <NA>
#> 107            shelter           shower        toilets water_point
#> 108               <NA>             <NA>           <NA>        <NA>
#> 109               <NA>             <NA>           <NA>        <NA>
#>                V16                V17             V18              V19
#> 1             <NA>               <NA>            <NA>             <NA>
#> 2             <NA>               <NA>            <NA>             <NA>
#> 3             <NA>               <NA>            <NA>             <NA>
#> 4             <NA>               <NA>            <NA>             <NA>
#> 5             <NA>               <NA>            <NA>             <NA>
#> 6             <NA>               <NA>            <NA>             <NA>
#> 7             <NA>               <NA>            <NA>             <NA>
#> 8             <NA>               <NA>            <NA>             <NA>
#> 9             <NA>               <NA>            <NA>             <NA>
#> 10            <NA>               <NA>            <NA>             <NA>
#> 11            <NA>               <NA>            <NA>             <NA>
#> 12            <NA>               <NA>            <NA>             <NA>
#> 13            <NA>               <NA>            <NA>             <NA>
#> 14            <NA>               <NA>            <NA>             <NA>
#> 15            <NA>               <NA>            <NA>             <NA>
#> 16            <NA>               <NA>            <NA>             <NA>
#> 17            <NA>               <NA>            <NA>             <NA>
#> 18            <NA>               <NA>            <NA>             <NA>
#> 19            <NA>               <NA>            <NA>             <NA>
#> 20            <NA>               <NA>            <NA>             <NA>
#> 21            <NA>               <NA>            <NA>             <NA>
#> 22            <NA>               <NA>            <NA>             <NA>
#> 23            <NA>               <NA>            <NA>             <NA>
#> 24            <NA>               <NA>            <NA>             <NA>
#> 25            <NA>               <NA>            <NA>             <NA>
#> 26            <NA>               <NA>            <NA>             <NA>
#> 27            <NA>               <NA>            <NA>             <NA>
#> 28            <NA>               <NA>            <NA>             <NA>
#> 29            <NA>               <NA>            <NA>             <NA>
#> 30            <NA>               <NA>            <NA>             <NA>
#> 31            <NA>               <NA>            <NA>             <NA>
#> 32            <NA>               <NA>            <NA>             <NA>
#> 33            <NA>               <NA>            <NA>             <NA>
#> 34            <NA>               <NA>            <NA>             <NA>
#> 35            <NA>               <NA>            <NA>             <NA>
#> 36            <NA>               <NA>            <NA>             <NA>
#> 37            <NA>               <NA>            <NA>             <NA>
#> 38            <NA>               <NA>            <NA>             <NA>
#> 39            <NA>               <NA>            <NA>             <NA>
#> 40            <NA>               <NA>            <NA>             <NA>
#> 41            <NA>               <NA>            <NA>             <NA>
#> 42            <NA>               <NA>            <NA>             <NA>
#> 43            <NA>               <NA>            <NA>             <NA>
#> 44            <NA>               <NA>            <NA>             <NA>
#> 45            <NA>               <NA>            <NA>             <NA>
#> 46            <NA>               <NA>            <NA>             <NA>
#> 47            <NA>               <NA>            <NA>             <NA>
#> 48            <NA>               <NA>            <NA>             <NA>
#> 49            <NA>               <NA>            <NA>             <NA>
#> 50            <NA>               <NA>            <NA>             <NA>
#> 51            <NA>               <NA>            <NA>             <NA>
#> 52            <NA>               <NA>            <NA>             <NA>
#> 53            <NA>               <NA>            <NA>             <NA>
#> 54            <NA>               <NA>            <NA>             <NA>
#> 55        grit_bin motorcycle_parking         parking parking_entrance
#> 56            <NA>               <NA>            <NA>             <NA>
#> 57            <NA>               <NA>            <NA>             <NA>
#> 58            <NA>               <NA>            <NA>             <NA>
#> 59            <NA>               <NA>            <NA>             <NA>
#> 60            <NA>               <NA>            <NA>             <NA>
#> 61            <NA>               <NA>            <NA>             <NA>
#> 62            <NA>               <NA>            <NA>             <NA>
#> 63            <NA>               <NA>            <NA>             <NA>
#> 64            <NA>               <NA>            <NA>             <NA>
#> 65            <NA>               <NA>            <NA>             <NA>
#> 66            <NA>               <NA>            <NA>             <NA>
#> 67            <NA>               <NA>            <NA>             <NA>
#> 68            <NA>               <NA>            <NA>             <NA>
#> 69            <NA>               <NA>            <NA>             <NA>
#> 70            <NA>               <NA>            <NA>             <NA>
#> 71            <NA>               <NA>            <NA>             <NA>
#> 72            <NA>               <NA>            <NA>             <NA>
#> 73            <NA>               <NA>            <NA>             <NA>
#> 74            <NA>               <NA>            <NA>             <NA>
#> 75            <NA>               <NA>            <NA>             <NA>
#> 76            <NA>               <NA>            <NA>             <NA>
#> 77            <NA>               <NA>            <NA>             <NA>
#> 78            <NA>               <NA>            <NA>             <NA>
#> 79            <NA>               <NA>            <NA>             <NA>
#> 80            <NA>               <NA>            <NA>             <NA>
#> 81            <NA>               <NA>            <NA>             <NA>
#> 82            <NA>               <NA>            <NA>             <NA>
#> 83            <NA>               <NA>            <NA>             <NA>
#> 84            <NA>               <NA>            <NA>             <NA>
#> 85            <NA>               <NA>            <NA>             <NA>
#> 86            <NA>               <NA>            <NA>             <NA>
#> 87            <NA>               <NA>            <NA>             <NA>
#> 88            <NA>               <NA>            <NA>             <NA>
#> 89            <NA>               <NA>            <NA>             <NA>
#> 90            <NA>               <NA>            <NA>             <NA>
#> 91            <NA>               <NA>            <NA>             <NA>
#> 92            <NA>               <NA>            <NA>             <NA>
#> 93            <NA>               <NA>            <NA>             <NA>
#> 94            <NA>               <NA>            <NA>             <NA>
#> 95            <NA>               <NA>            <NA>             <NA>
#> 96            <NA>               <NA>            <NA>             <NA>
#> 97            <NA>               <NA>            <NA>             <NA>
#> 98            <NA>               <NA>            <NA>             <NA>
#> 99            <NA>               <NA>            <NA>             <NA>
#> 100           <NA>               <NA>            <NA>             <NA>
#> 101           <NA>               <NA>            <NA>             <NA>
#> 102           <NA>               <NA>            <NA>             <NA>
#> 103           <NA>               <NA>            <NA>             <NA>
#> 104           <NA>               <NA>            <NA>             <NA>
#> 105           <NA>               <NA>            <NA>             <NA>
#> 106           <NA>               <NA>            <NA>             <NA>
#> 107 watering_place       refugee_site vending_machine             <NA>
#> 108           <NA>               <NA>            <NA>             <NA>
#> 109           <NA>               <NA>            <NA>             <NA>
#>               V20  V21
#> 1            <NA> <NA>
#> 2            <NA> <NA>
#> 3            <NA> <NA>
#> 4            <NA> <NA>
#> 5            <NA> <NA>
#> 6            <NA> <NA>
#> 7            <NA> <NA>
#> 8            <NA> <NA>
#> 9            <NA> <NA>
#> 10           <NA> <NA>
#> 11           <NA> <NA>
#> 12           <NA> <NA>
#> 13           <NA> <NA>
#> 14           <NA> <NA>
#> 15           <NA> <NA>
#> 16           <NA> <NA>
#> 17           <NA> <NA>
#> 18           <NA> <NA>
#> 19           <NA> <NA>
#> 20           <NA> <NA>
#> 21           <NA> <NA>
#> 22           <NA> <NA>
#> 23           <NA> <NA>
#> 24           <NA> <NA>
#> 25           <NA> <NA>
#> 26           <NA> <NA>
#> 27           <NA> <NA>
#> 28           <NA> <NA>
#> 29           <NA> <NA>
#> 30           <NA> <NA>
#> 31           <NA> <NA>
#> 32           <NA> <NA>
#> 33           <NA> <NA>
#> 34           <NA> <NA>
#> 35           <NA> <NA>
#> 36           <NA> <NA>
#> 37           <NA> <NA>
#> 38           <NA> <NA>
#> 39           <NA> <NA>
#> 40           <NA> <NA>
#> 41           <NA> <NA>
#> 42           <NA> <NA>
#> 43           <NA> <NA>
#> 44           <NA> <NA>
#> 45           <NA> <NA>
#> 46           <NA> <NA>
#> 47           <NA> <NA>
#> 48           <NA> <NA>
#> 49           <NA> <NA>
#> 50           <NA> <NA>
#> 51           <NA> <NA>
#> 52           <NA> <NA>
#> 53           <NA> <NA>
#> 54           <NA> <NA>
#> 55  parking_space taxi
#> 56           <NA> <NA>
#> 57           <NA> <NA>
#> 58           <NA> <NA>
#> 59           <NA> <NA>
#> 60           <NA> <NA>
#> 61           <NA> <NA>
#> 62           <NA> <NA>
#> 63           <NA> <NA>
#> 64           <NA> <NA>
#> 65           <NA> <NA>
#> 66           <NA> <NA>
#> 67           <NA> <NA>
#> 68           <NA> <NA>
#> 69           <NA> <NA>
#> 70           <NA> <NA>
#> 71           <NA> <NA>
#> 72           <NA> <NA>
#> 73           <NA> <NA>
#> 74           <NA> <NA>
#> 75           <NA> <NA>
#> 76           <NA> <NA>
#> 77           <NA> <NA>
#> 78           <NA> <NA>
#> 79           <NA> <NA>
#> 80           <NA> <NA>
#> 81           <NA> <NA>
#> 82           <NA> <NA>
#> 83           <NA> <NA>
#> 84           <NA> <NA>
#> 85           <NA> <NA>
#> 86           <NA> <NA>
#> 87           <NA> <NA>
#> 88           <NA> <NA>
#> 89           <NA> <NA>
#> 90           <NA> <NA>
#> 91           <NA> <NA>
#> 92           <NA> <NA>
#> 93           <NA> <NA>
#> 94           <NA> <NA>
#> 95           <NA> <NA>
#> 96           <NA> <NA>
#> 97           <NA> <NA>
#> 98           <NA> <NA>
#> 99           <NA> <NA>
#> 100          <NA> <NA>
#> 101          <NA> <NA>
#> 102          <NA> <NA>
#> 103          <NA> <NA>
#> 104          <NA> <NA>
#> 105          <NA> <NA>
#> 106          <NA> <NA>
#> 107          <NA> <NA>
#> 108          <NA> <NA>
#> 109          <NA> <NA>
collapse::unlist2d(osm_line_class, idcols = c("category", "tag"))
#>     category           tag            V1                V2
#> 1  aerialway     aerialway                            <NA>
#> 2    aeroway       aeroway                            <NA>
#> 3   pipeline      man_made      pipeline              <NA>
#> 4       road       highway      motorway     motorway_link
#> 5    railway       railway                            <NA>
#> 6   waterway      waterway    !waterfall           !stream
#> 7   waterway         water          !yes              <NA>
#> 8   waterway      man_made   water_works reservoir_covered
#> 9      power         power                            <NA>
#> 10   telecom       telecom                            <NA>
#> 11   telecom communication                            <NA>
#> 12   storage      man_made          silo      storage_tank
#> 13  boundary      boundary national_park    protected_area
#> 14     ferry         route         ferry              <NA>
#>                       V3         V4      V5             V6         V7
#> 1                   <NA>       <NA>    <NA>           <NA>       <NA>
#> 2                   <NA>       <NA>    <NA>           <NA>       <NA>
#> 3                   <NA>       <NA>    <NA>           <NA>       <NA>
#> 4                  trunk trunk_link primary   primary_link  secondary
#> 5                   <NA>       <NA>    <NA>           <NA>       <NA>
#> 6            !stream_end      !wadi !rapids !tidal_channel !riverbank
#> 7                   <NA>       <NA>    <NA>           <NA>       <NA>
#> 8            water_tower       <NA>    <NA>           <NA>       <NA>
#> 9                   <NA>       <NA>    <NA>           <NA>       <NA>
#> 10                  <NA>       <NA>    <NA>           <NA>       <NA>
#> 11                  <NA>       <NA>    <NA>           <NA>       <NA>
#> 12                  <NA>       <NA>    <NA>           <NA>       <NA>
#> 13 special_economic_zone       <NA>    <NA>           <NA>       <NA>
#> 14                  <NA>       <NA>    <NA>           <NA>       <NA>
#>                V8       V9           V10
#> 1            <NA>     <NA>          <NA>
#> 2            <NA>     <NA>          <NA>
#> 3            <NA>     <NA>          <NA>
#> 4  secondary_link tertiary tertiary_link
#> 5            <NA>     <NA>          <NA>
#> 6            !yes     <NA>          <NA>
#> 7            <NA>     <NA>          <NA>
#> 8            <NA>     <NA>          <NA>
#> 9            <NA>     <NA>          <NA>
#> 10           <NA>     <NA>          <NA>
#> 11           <NA>     <NA>          <NA>
#> 12           <NA>     <NA>          <NA>
#> 13           <NA>     <NA>          <NA>
#> 14           <NA>     <NA>          <NA>
# This list contains additional tags with information about lines (e.g. roads and railways)
collapse::unlist2d(osm_line_info_tags, idcols = c("category", "tag"))
#>     category   V1  V2   V3          V4       V5    V6      V7       V8       V9
#> 1  aerialway type ref name description operator usage service capacity man_made
#> 2    aeroway type ref name description operator usage service capacity man_made
#> 3   pipeline type ref name description operator usage service capacity man_made
#> 4       road type ref name description operator usage service capacity man_made
#> 5    railway type ref name description operator usage service capacity man_made
#> 6   waterway type ref name description operator usage service capacity man_made
#> 7      power type ref name description operator usage service capacity man_made
#> 8    telecom type ref name description operator usage service capacity man_made
#> 9    storage type ref name description operator usage service capacity man_made
#> 10  boundary type ref name description operator usage service capacity man_made
#> 11     route type ref name description operator usage service capacity man_made
#>             V10            V11              V12              V13            V14
#> 1     aerialway      occupancy         duration       detachable         bubble
#> 2     aerialway        surface              lit    navigationaid           iata
#> 3      pipeline          depth            inlet           outlet   construction
#> 4       highway       abutters            lanes              lit       maxspeed
#> 5       railway         tracks      electrified       embankment embedded_rails
#> 6  intermittent          inlet           outlet            width          draft
#> 7         power    electricity     plant:output generator:output         length
#> 8       telecom telecom:medium connection_point          utility         length
#> 9       content           crop           height         material         length
#> 10  related_law  protect_class protection_title    official_name         length
#> 11       access       duration    opening_hours      reservation  motor_vehicle
#>                V15           V16        V17          V18         V19
#> 1          heating       bicycle     access       length       width
#> 2             icao       amenity    highway       length       width
#> 3        substance       content   resource     diameter    pressure
#> 4  traffic_calming        oneway    surface   smoothness   tracktype
#> 5            gauge loading_gauge metre_load    axle_load     voltage
#> 6            tidal      maxwidth  maxheight    maxlength    maxspeed
#> 7            width      location     origin place:origin destination
#> 8            width      location     origin place:origin destination
#> 9            width      location     origin place:origin destination
#> 10           width      location     origin place:origin destination
#> 11            foot     maxweight  maxlength     maxwidth   maxheight
#>                  V20        V21          V22          V23               V24
#> 1           location     origin place:origin  destination place:destination
#> 2           location     origin place:origin  destination place:destination
#> 3     flow_direction      count       length        width          location
#> 4             length      width     location       origin      place:origin
#> 5          frequency  highspeed     maxspeed     historic            length
#> 6             length   location       origin place:origin       destination
#> 7  place:destination start_date     end_date         <NA>              <NA>
#> 8  place:destination start_date     end_date         <NA>              <NA>
#> 9  place:destination start_date     end_date         <NA>              <NA>
#> 10 place:destination start_date     end_date         <NA>              <NA>
#> 11            length      width     location       origin      place:origin
#>                  V25               V26         V27               V28
#> 1         start_date          end_date        <NA>              <NA>
#> 2         start_date          end_date        <NA>              <NA>
#> 3             origin      place:origin destination place:destination
#> 4        destination place:destination  start_date          end_date
#> 5              width          location      origin      place:origin
#> 6  place:destination        start_date    end_date              <NA>
#> 7               <NA>              <NA>        <NA>              <NA>
#> 8               <NA>              <NA>        <NA>              <NA>
#> 9               <NA>              <NA>        <NA>              <NA>
#> 10              <NA>              <NA>        <NA>              <NA>
#> 11       destination place:destination  start_date          end_date
#>            V29               V30        V31      V32
#> 1         <NA>              <NA>       <NA>     <NA>
#> 2         <NA>              <NA>       <NA>     <NA>
#> 3   start_date          end_date       <NA>     <NA>
#> 4         <NA>              <NA>       <NA>     <NA>
#> 5  destination place:destination start_date end_date
#> 6         <NA>              <NA>       <NA>     <NA>
#> 7         <NA>              <NA>       <NA>     <NA>
#> 8         <NA>              <NA>       <NA>     <NA>
#> 9         <NA>              <NA>       <NA>     <NA>
#> 10        <NA>              <NA>       <NA>     <NA>
#> 11        <NA>              <NA>       <NA>     <NA>
```

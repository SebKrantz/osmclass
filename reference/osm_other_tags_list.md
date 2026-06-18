# Generate a List from the 'other_tags' Column in OSM PBF Data

Generate a List from the 'other_tags' Column in OSM PBF Data

## Usage

``` r
osm_other_tags_list(x, values = FALSE, split = "\",\"|\"=>\"", ...)
```

## Arguments

- x:

  character. The 'other_tags' column of an imported osm.pbf file.

- values:

  logical. `TRUE` also includes the values of tags.

- split:

  character. Pattern passed to
  [`strsplit`](https://rdrr.io/r/base/strsplit.html) to split up `x`.

- ...:

  further arguments to
  [`strsplit`](https://rdrr.io/r/base/strsplit.html).

## Value

a list of tags as character vectors, or a nested list of tags and values
if `values = TRUE`.

## See also

[osmclass-package](https://sebkrantz.github.io/osmclass/reference/osmclass-package.md)

## Examples

``` r
# See Examples at ?osmclass for full examples

# Extract 'other_tags' as list
other_tags <- osm_other_tags_list(djibouti_points$other_tags)
other_tags[1:10]
#> [[1]]
#>   [1] "GNS:dsg_code"      "GNS:dsg_name"      "GNS:id"           
#>   [4] "GNS:modify_date"   "admin_level"       "alt_name:ar"      
#>   [7] "capital"           "capital_ISO3166-1" "is_capital"       
#>  [10] "name:ace"          "name:af"           "name:am"          
#>  [13] "name:an"           "name:ar"           "name:arz"         
#>  [16] "name:ast"          "name:az"           "name:azb"         
#>  [19] "name:ba"           "name:bat-smg"      "name:bcl"         
#>  [22] "name:be"           "name:bg"           "name:bjn"         
#>  [25] "name:bn"           "name:bo"           "name:bpy"         
#>  [28] "name:br"           "name:bs"           "name:bxr"         
#>  [31] "name:ca"           "name:ce"           "name:ceb"         
#>  [34] "name:ckb"          "name:crh"          "name:cs"          
#>  [37] "name:cv"           "name:cy"           "name:da"          
#>  [40] "name:de"           "name:diq"          "name:dv"          
#>  [43] "name:ee"           "name:el"           "name:en"          
#>  [46] "name:eo"           "name:es"           "name:et"          
#>  [49] "name:eu"           "name:ext"          "name:fa"          
#>  [52] "name:fi"           "name:fr"           "name:frp"         
#>  [55] "name:fy"           "name:ga"           "name:gag"         
#>  [58] "name:gd"           "name:gl"           "name:gv"          
#>  [61] "name:he"           "name:hi"           "name:hif"         
#>  [64] "name:hr"           "name:hsb"          "name:ht"          
#>  [67] "name:hu"           "name:hy"           "name:ia"          
#>  [70] "name:id"           "name:ie"           "name:ilo"         
#>  [73] "name:io"           "name:is"           "name:it"          
#>  [76] "name:ja"           "name:jv"           "name:ka"          
#>  [79] "name:kab"          "name:kab-Arab"     "name:kg"          
#>  [82] "name:ki"           "name:kk"           "name:kk-Arab"     
#>  [85] "name:kmr"          "name:kn"           "name:ko"          
#>  [88] "name:ks"           "name:ku"           "name:ku-Arab"     
#>  [91] "name:kw"           "name:ky"           "name:la"          
#>  [94] "name:lb"           "name:li"           "name:lij"         
#>  [97] "name:lmo"          "name:ln"           "name:lrc"         
#> [100] "name:lt"           "name:lv"           "name:lzh"         
#> [103] "name:mg"           "name:min"          "name:mk"          
#> [106] "name:ml"           "name:mr"           "name:mrj"         
#> [109] "name:ms"           "name:mt"           "name:my"          
#> [112] "name:mzn"          "name:na"           "name:nah"         
#> [115] "name:nan"          "name:nds"          "name:ne"          
#> [118] "name:nl"           "name:nn"           "name:no"          
#> [121] "name:nov"          "name:nso"          "name:nv"          
#> [124] "name:oc"           "name:om"           "name:or"          
#> [127] "name:os"           "name:pa"           "name:pam"         
#> [130] "name:pdc"          "name:pih"          "name:pl"          
#> [133] "name:pms"          "name:pnb"          "name:ps"          
#> [136] "name:pt"           "name:qu"           "name:ro"          
#> [139] "name:ru"           "name:rue"          "name:rw"          
#> [142] "name:sa"           "name:sah"          "name:sc"          
#> [145] "name:scn"          "name:sco"          "name:sd"          
#> [148] "name:se"           "name:sg"           "name:sh"          
#> [151] "name:simple"       "name:sk"           "name:sl"          
#> [154] "name:sn"           "name:so"           "name:sq"          
#> [157] "name:sr"           "name:ss"           "name:stq"         
#> [160] "name:su"           "name:sv"           "name:sw"          
#> [163] "name:ta"           "name:te"           "name:tg"          
#> [166] "name:th"           "name:ti"           "name:tk"          
#> [169] "name:tl"           "name:tr"           "name:ts"          
#> [172] "name:tt"           "name:udm"          "name:ug"          
#> [175] "name:uk"           "name:ur"           "name:uz"          
#> [178] "name:vec"          "name:vi"           "name:vo"          
#> [181] "name:vro"          "name:war"          "name:wo"          
#> [184] "name:xal"          "name:yi"           "name:yo"          
#> [187] "name:yue"          "name:zh"           "name:zu"          
#> [190] "population"        "wikidata"          "wikipedia"        
#> [193] "wikipedia:ar"     
#> 
#> [[2]]
#> [1] "traffic_signals"
#> 
#> [[3]]
#> NULL
#> 
#> [[4]]
#> NULL
#> 
#> [[5]]
#> NULL
#> 
#> [[6]]
#> [1] "noexit"
#> 
#> [[7]]
#>  [1] "GNS:dsg_code"    "GNS:dsg_name"    "GNS:id"          "GNS:modify_date"
#>  [5] "alt_name"        "alt_name:ar"     "name:ar"         "name:en"        
#>  [9] "name:fr"         "wikidata"       
#> 
#> [[8]]
#> [1] "traffic_signals"
#> 
#> [[9]]
#> [1] "railway"
#> 
#> [[10]]
#> [1] "name:ar" "name:en" "name:fr" "name:hu" "sport"  
#> 

# Count frequency (showing top 10)
sort(table(unlist(other_tags)), decreasing = TRUE)[1:10]
#> 
#>         name:en          GNS:id    GNS:dsg_code    GNS:dsg_name GNS:modify_date 
#>            4317            4137            4136            4118            4115 
#>        alt_name         natural        wikidata         name:ar        waterway 
#>            3190            2678            2474            2020            1695 

# Also include values
other_tags_values <- osm_other_tags_list(djibouti_points$other_tags, values = TRUE)
other_tags_values[1:10]
#> [[1]]
#> [[1]]$`GNS:dsg_code`
#> [1] "PPLC"
#> 
#> [[1]]$`GNS:dsg_name`
#> [1] "populated place"
#> 
#> [[1]]$`GNS:id`
#> [1] "-2034412"
#> 
#> [[1]]$`GNS:modify_date`
#> [1] "2018-04-11"
#> 
#> [[1]]$admin_level
#> [1] "2"
#> 
#> [[1]]$`alt_name:ar`
#> [1] "دجبت;غإبت;جبت;جبوت;جيبوتي;جيبوتى;دجيبوتي;مدينة جيبوتي"
#> 
#> [[1]]$capital
#> [1] "yes"
#> 
#> [[1]]$`capital_ISO3166-1`
#> [1] "yes"
#> 
#> [[1]]$is_capital
#> [1] "country"
#> 
#> [[1]]$`name:ace`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:af`
#> [1] "Djiboeti"
#> 
#> [[1]]$`name:am`
#> [1] "ጅቡቲ"
#> 
#> [[1]]$`name:an`
#> [1] "Chibuti"
#> 
#> [[1]]$`name:ar`
#> [1] "جيبوتي"
#> 
#> [[1]]$`name:arz`
#> [1] "جيبوتي"
#> 
#> [[1]]$`name:ast`
#> [1] "Xibuti"
#> 
#> [[1]]$`name:az`
#> [1] "Cibuti"
#> 
#> [[1]]$`name:azb`
#> [1] "جیبوتی"
#> 
#> [[1]]$`name:ba`
#> [1] "Джибути"
#> 
#> [[1]]$`name:bat-smg`
#> [1] "Džėbotis"
#> 
#> [[1]]$`name:bcl`
#> [1] "Dibouti"
#> 
#> [[1]]$`name:be`
#> [1] "Джыбуці"
#> 
#> [[1]]$`name:bg`
#> [1] "Джибути"
#> 
#> [[1]]$`name:bjn`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:bn`
#> [1] "জিবুতি"
#> 
#> [[1]]$`name:bo`
#> [1] "ཇི་བའོ་ཊི།"
#> 
#> [[1]]$`name:bpy`
#> [1] "ডিজিবোটি"
#> 
#> [[1]]$`name:br`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:bs`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:bxr`
#> [1] "Джибути"
#> 
#> [[1]]$`name:ca`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:ce`
#> [1] "Джибути"
#> 
#> [[1]]$`name:ceb`
#> [1] "Yibuti"
#> 
#> [[1]]$`name:ckb`
#> [1] "جیبووتی"
#> 
#> [[1]]$`name:crh`
#> [1] "Cibuti"
#> 
#> [[1]]$`name:cs`
#> [1] "Džíbutí"
#> 
#> [[1]]$`name:cv`
#> [1] "Джибути"
#> 
#> [[1]]$`name:cy`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:da`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:de`
#> [1] "Dschibuti"
#> 
#> [[1]]$`name:diq`
#> [1] "Cibuti"
#> 
#> [[1]]$`name:dv`
#> [1] "ޖިބުތީ"
#> 
#> [[1]]$`name:ee`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:el`
#> [1] "Τζιμπουτί"
#> 
#> [[1]]$`name:en`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:eo`
#> [1] "Ĝibutio"
#> 
#> [[1]]$`name:es`
#> [1] "Yibuti"
#> 
#> [[1]]$`name:et`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:eu`
#> [1] "Djibuti"
#> 
#> [[1]]$`name:ext`
#> [1] "Yibuti"
#> 
#> [[1]]$`name:fa`
#> [1] "جیبوتی"
#> 
#> [[1]]$`name:fi`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:fr`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:frp`
#> [1] "Dj·iboti"
#> 
#> [[1]]$`name:fy`
#> [1] "Dzjibûty"
#> 
#> [[1]]$`name:ga`
#> [1] "Diobúití"
#> 
#> [[1]]$`name:gag`
#> [1] "Cibuti"
#> 
#> [[1]]$`name:gd`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:gl`
#> [1] "Xibutí"
#> 
#> [[1]]$`name:gv`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:he`
#> [1] "ג'יבוטי"
#> 
#> [[1]]$`name:hi`
#> [1] "जीबूती"
#> 
#> [[1]]$`name:hif`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:hr`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:hsb`
#> [1] "Dźibuti"
#> 
#> [[1]]$`name:ht`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:hu`
#> [1] "Dzsibuti"
#> 
#> [[1]]$`name:hy`
#> [1] "Ջիբութի"
#> 
#> [[1]]$`name:ia`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:id`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:ie`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:ilo`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:io`
#> [1] "Djibuti"
#> 
#> [[1]]$`name:is`
#> [1] "Djíbútí"
#> 
#> [[1]]$`name:it`
#> [1] "Gibuti"
#> 
#> [[1]]$`name:ja`
#> [1] "ジブチ市"
#> 
#> [[1]]$`name:jv`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:ka`
#> [1] "ჯიბუტი"
#> 
#> [[1]]$`name:kab`
#> [1] "Jibuti"
#> 
#> [[1]]$`name:kab-Arab`
#> [1] "جيبوتي"
#> 
#> [[1]]$`name:kg`
#> [1] "Djibuti"
#> 
#> [[1]]$`name:ki`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:kk`
#> [1] "Джибути"
#> 
#> [[1]]$`name:kk-Arab`
#> [1] "دجىيبۋتىي"
#> 
#> [[1]]$`name:kmr`
#> [1] "جیبووتی"
#> 
#> [[1]]$`name:kn`
#> [1] "ಜಿಬೂತೀ"
#> 
#> [[1]]$`name:ko`
#> [1] "지부티"
#> 
#> [[1]]$`name:ks`
#> [1] "جیبوتی"
#> 
#> [[1]]$`name:ku`
#> [1] "Cîbûtî"
#> 
#> [[1]]$`name:ku-Arab`
#> [1] "جیبووتی"
#> 
#> [[1]]$`name:kw`
#> [1] "Sita Jibouti"
#> 
#> [[1]]$`name:ky`
#> [1] "Жибути шаары"
#> 
#> [[1]]$`name:la`
#> [1] "Urbs Dzibutum"
#> 
#> [[1]]$`name:lb`
#> [1] "Dschibuti"
#> 
#> [[1]]$`name:li`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:lij`
#> [1] "Gibuti"
#> 
#> [[1]]$`name:lmo`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:ln`
#> [1] "Djibuti"
#> 
#> [[1]]$`name:lrc`
#> [1] "جیبۊتی"
#> 
#> [[1]]$`name:lt`
#> [1] "Džibutis"
#> 
#> [[1]]$`name:lv`
#> [1] "Džibuti"
#> 
#> [[1]]$`name:lzh`
#> [1] "吉布地"
#> 
#> [[1]]$`name:mg`
#> [1] "Jibotia"
#> 
#> [[1]]$`name:min`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:mk`
#> [1] "Џибути"
#> 
#> [[1]]$`name:ml`
#> [1] "ജിബൂട്ടി"
#> 
#> [[1]]$`name:mr`
#> [1] "जिबूती"
#> 
#> [[1]]$`name:mrj`
#> [1] "Джибути"
#> 
#> [[1]]$`name:ms`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:mt`
#> [1] "Ġibuti"
#> 
#> [[1]]$`name:my`
#> [1] "ဂျီဘူတီနိုင်ငံ"
#> 
#> [[1]]$`name:mzn`
#> [1] "جیبوتی"
#> 
#> [[1]]$`name:na`
#> [1] "Djibuti"
#> 
#> [[1]]$`name:nah`
#> [1] "Yibuti"
#> 
#> [[1]]$`name:nan`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:nds`
#> [1] "Dschibuti"
#> 
#> [[1]]$`name:ne`
#> [1] "जिबुटी"
#> 
#> [[1]]$`name:nl`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:nn`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:no`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:nov`
#> [1] "Djibuti"
#> 
#> [[1]]$`name:nso`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:nv`
#> [1] "Jibótii"
#> 
#> [[1]]$`name:oc`
#> [1] "Jiboti"
#> 
#> [[1]]$`name:om`
#> [1] "Jibuutii"
#> 
#> [[1]]$`name:or`
#> [1] "ଡିଜିବୋଇଟି"
#> 
#> [[1]]$`name:os`
#> [1] "Джибути"
#> 
#> [[1]]$`name:pa`
#> [1] "ਜਿਬੂਤੀ"
#> 
#> [[1]]$`name:pam`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:pdc`
#> [1] "Tschibuti"
#> 
#> [[1]]$`name:pih`
#> [1] "Jibuuti"
#> 
#> [[1]]$`name:pl`
#> [1] "Dżibuti"
#> 
#> [[1]]$`name:pms`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:pnb`
#> [1] "جبوتی"
#> 
#> [[1]]$`name:ps`
#> [1] "جېبوتي"
#> 
#> [[1]]$`name:pt`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:qu`
#> [1] "Yiwuti"
#> 
#> [[1]]$`name:ro`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:ru`
#> [1] "Джибути"
#> 
#> [[1]]$`name:rue`
#> [1] "Джібутьско"
#> 
#> [[1]]$`name:rw`
#> [1] "Jibuti"
#> 
#> [[1]]$`name:sa`
#> [1] "जिबूटी"
#> 
#> [[1]]$`name:sah`
#> [1] "Дьибути"
#> 
#> [[1]]$`name:sc`
#> [1] "Gibuti"
#> 
#> [[1]]$`name:scn`
#> [1] "Gibbuti"
#> 
#> [[1]]$`name:sco`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:sd`
#> [1] "جبوتي"
#> 
#> [[1]]$`name:se`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:sg`
#> [1] "Dibutùii"
#> 
#> [[1]]$`name:sh`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:simple`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:sk`
#> [1] "Džibuti"
#> 
#> [[1]]$`name:sl`
#> [1] "Džibuti"
#> 
#> [[1]]$`name:sn`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:so`
#> [1] "Jabuuti"
#> 
#> [[1]]$`name:sq`
#> [1] "Xhibuti"
#> 
#> [[1]]$`name:sr`
#> [1] "Џибути"
#> 
#> [[1]]$`name:ss`
#> [1] "IJibhuthi"
#> 
#> [[1]]$`name:stq`
#> [1] "Dschibuti"
#> 
#> [[1]]$`name:su`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:sv`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:sw`
#> [1] "Jibuti"
#> 
#> [[1]]$`name:ta`
#> [1] "சீபூத்தீ"
#> 
#> [[1]]$`name:te`
#> [1] "జిబౌటి"
#> 
#> [[1]]$`name:tg`
#> [1] "Ҷибути"
#> 
#> [[1]]$`name:th`
#> [1] "จิบูตี"
#> 
#> [[1]]$`name:ti`
#> [1] "ጂቡቲ"
#> 
#> [[1]]$`name:tk`
#> [1] "Jibuti"
#> 
#> [[1]]$`name:tl`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:tr`
#> [1] "Cibuti"
#> 
#> [[1]]$`name:ts`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:tt`
#> [1] "Җибути"
#> 
#> [[1]]$`name:udm`
#> [1] "Джибути"
#> 
#> [[1]]$`name:ug`
#> [1] "جىبۇتى"
#> 
#> [[1]]$`name:uk`
#> [1] "Джибуті"
#> 
#> [[1]]$`name:ur`
#> [1] "جبوتی"
#> 
#> [[1]]$`name:uz`
#> [1] "Jibuti"
#> 
#> [[1]]$`name:vec`
#> [1] "Gibuti"
#> 
#> [[1]]$`name:vi`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:vo`
#> [1] "Cibutän"
#> 
#> [[1]]$`name:vro`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:war`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:wo`
#> [1] "Jibuti"
#> 
#> [[1]]$`name:xal`
#> [1] "Җибудин"
#> 
#> [[1]]$`name:yi`
#> [1] "דזשיבוטי"
#> 
#> [[1]]$`name:yo`
#> [1] "Djibouti"
#> 
#> [[1]]$`name:yue`
#> [1] "吉布提"
#> 
#> [[1]]$`name:zh`
#> [1] "吉布地市"
#> 
#> [[1]]$`name:zu`
#> [1] "IJibuthi"
#> 
#> [[1]]$population
#> [1] "475332"
#> 
#> [[1]]$wikidata
#> [1] "Q3604"
#> 
#> [[1]]$wikipedia
#> [1] "ar:جيبوتي (مدينة)"
#> 
#> [[1]]$`wikipedia:ar`
#> [1] "جيبوتي (مدينة)\""
#> 
#> 
#> [[2]]
#> [[2]]$traffic_signals
#> [1] "signal"
#> 
#> 
#> [[3]]
#> NULL
#> 
#> [[4]]
#> NULL
#> 
#> [[5]]
#> NULL
#> 
#> [[6]]
#> [[6]]$noexit
#> [1] "yes"
#> 
#> 
#> [[7]]
#> [[7]]$`GNS:dsg_code`
#> [1] "PPL"
#> 
#> [[7]]$`GNS:dsg_name`
#> [1] "populated place"
#> 
#> [[7]]$`GNS:id`
#> [1] "231295"
#> 
#> [[7]]$`GNS:modify_date`
#> [1] "2000-11-15"
#> 
#> [[7]]$alt_name
#> [1] "Goubetto;Goubatto;Goubétto"
#> 
#> [[7]]$`alt_name:ar`
#> [1] "غوبتّو"
#> 
#> [[7]]$`name:ar`
#> [1] "غوبتو"
#> 
#> [[7]]$`name:en`
#> [1] "Goubetto"
#> 
#> [[7]]$`name:fr`
#> [1] "Goubetto"
#> 
#> [[7]]$wikidata
#> [1] "Q5588130\""
#> 
#> 
#> [[8]]
#> [[8]]$traffic_signals
#> [1] "signal"
#> 
#> 
#> [[9]]
#> [[9]]$railway
#> [1] "level_crossing"
#> 
#> 
#> [[10]]
#> [[10]]$`name:ar`
#> [1] "الجزر موشا"
#> 
#> [[10]]$`name:en`
#> [1] "Moucha Islands"
#> 
#> [[10]]$`name:fr`
#> [1] "Îles Moucha"
#> 
#> [[10]]$`name:hu`
#> [1] "Moucha-szigetek"
#> 
#> [[10]]$sport
#> [1] "scuba_diving\""
#> 
#> 
```

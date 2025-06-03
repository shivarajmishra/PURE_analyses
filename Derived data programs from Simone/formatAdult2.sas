/*Modified by Shofique 17 April 2018...see formatAdult2_Back9Apr2018.sas for backup version, if needed */
proc format;
  value centerf 1="Bangalore IND"
               2="Chennai IND"
               3="Jaipur IND"
               5="Trivandrum IND"
               6="Chandigarh IND"
               8="Yunnan CHN"
               9="Qinghai CHN"
               10="Tibet CHN"
               11="Beijing CHN"
               12="Jiangsu CHN"
               13="Shandong CHN"
               14="Shanxi CHN"
               15="Shaanxi CHN"
               16="Liaoning CHN"
               17="Jiangxi CHN"
               18="Inner Mongolia CHN"
               19="Xinjiang CHN"
               20="Sichuan CHN"
               21="Potchefstroom SAfrica"
               22="Cape Town SAfrica"
               23="Tanzania"
               24="Tanzania"
               25="Ecuador"
               26="Colombia"
               27="Bishkek - Kyrgyzstan"
               28="Chyui Province - Kyrgyzstan"
               29="Jalal-Abad Province - Kyrgyzstan"
               30="Osh Province - Kyrgyzstan"
               31="UAE Mamzar"
               32="UAE Hataa"
               33="UAE Al Lusaily"
               34="Northern Sudan"
               35="Khartoum"
               36="West Darfur"
               37="Elgazira"
               38="Red Sea"
               40="Harare Zimbabwe"
               45="Brazil Sao Paulo"
               46="Brazil Angatuba"
               47="Brazil Favela"
               48="Brazil Campina do Monte Alegre City"
               49="Brazil North Region"
               50="Brazil West Region"
               51="Brazil Municipalities from Sao Paulo"
               52="Brazil Angatuba city"
               53="Brazil Guarei"
               54="Russia - Kemerovo Region"
               55="Russia - Novgorod Region"
               56="Russia - Rostov-na-Donu Region"
               57="Sweden"
               58="Russia - TBD"
               59="Russia - TBD"
               60="Russia - TBD"
               61="Kazakhstan - Almaty Region"
               62="Kazakhstan - Zhambyl Region"
               63="Temuco Chile"
               64="Peru"
               66="Palestine"
               67="CRC Iran"
               68="Saudi Arabia"
               70="Hamilton"
               71="Vancouver"
               72="Quebec"
               73="Ottawa"
               76="Rosario Argentina"
               77="CESCAS Argentina"
               78="CESCAS Chile"
               79="CESCAS Uruguay"
               80="Poland"
               81="Poland(PONS)"
               82="Turkmenistan - Region 1"
               83="Turkmenistan - Region 2"
               85="UITM Malaysia"
               86="UKM Malaysia"
               87="Philippines"
               88="Test"
               90="Bangladesh"
               93="Turkey"
               95="Pakistan"
               99="Scott MCHAT study";

  value centidf 1="Bangalore IND"
               2="Chennai IND"
               3="Jaipur IND"
               5="Trivandrum IND"
               6="Chandigarh IND"
               8="Yunnan CHN"
               9="Qinghai CHN"
               10="Tibet CHN"
               11="Beijing CHN"
               12="Jiangsu CHN"
               13="Shandong CHN"
               14="Shanxi CHN"
               15="Shaanxi CHN"
               16="Liaoning CHN"
               17="Jiangxi CHN"
               18="Inner Mongolia CHN"
               19="Xinjiang CHN"
               20="Sichuan CHN"
               21="Potchefstroom SAfrica"
               22="Cape Town SAfrica"
               23="Tanzania"
               24="Tanzania"
               25="Ecuador"
               26="Colombia"
               27="Bishkek - Kyrgyzstan"
               28="Chyui Province - Kyrgyzstan"
               29="Jalal-Abad Province - Kyrgyzstan"
               30="Osh Province - Kyrgyzstan"
               31="UAE Mamzar"
               32="UAE Hataa"
               33="UAE Al Lusaily"
               34="Northern Sudan"
               35="Khartoum"
               36="West Darfur"
               37="Elgazira"
               38="Red Sea"
               40="Harare Zimbabwe"
               45="Brazil Sao Paulo"
               46="Brazil Angatuba"
               47="Brazil Favela"
               48="Brazil Campina do Monte Alegre City"
               49="Brazil North Region"
               50="Brazil West Region"
               51="Brazil Municipalities from Sao Paulo"
               52="Brazil Angatuba city"
               53="Brazil Guarei"
               54="Russia - Kemerovo Region"
               55="Russia - Novgorod Region"
               56="Russia - Rostov-na-Donu Region"
               57="Sweden"
               58="Russia - TBD"
               59="Russia - TBD"
               60="Russia - TBD"
               61="Kazakhstan - Almaty Region"
               62="Kazakhstan - Zhambyl Region"
               63="Temuco Chile"
               64="Peru"
               66="Palestine"
               67="CRC Iran"
               68="Saudi Arabia"
               70="Hamilton"
               71="Vancouver"
               72="Quebec"
               73="Ottawa"
               76="Rosario Argentina"
               77="CESCAS Argentina"
               78="CESCAS Chile"
               79="CESCAS Uruguay"
               80="Poland"
               81="Poland(PONS)"
               82="Turkmenistan - Region 1"
               83="Turkmenistan - Region 2"
               85="UITM Malaysia"
               86="UKM Malaysia"
               87="Philippines"
               88="Test"
               90="Bangladesh"
               93="Turkey"
               95="Pakistan"
               99="Scott MCHAT study";

  value new_centidf 1="Bangalore IND"
               2="Chennai IND"
               3="Jaipur IND"
               5="Trivandrum IND"
               6="Chandigarh IND"
               8="Yunnan CHN"
               9="Qinghai CHN"
               10="Tibet CHN"
               11="Beijing CHN"
               12="Jiangsu CHN"
               13="Shandong CHN"
               14="Shanxi CHN"
               15="Shaanxi CHN"
               16="Liaoning CHN"
               17="Jiangxi CHN"
               18="Inner Mongolia CHN"
               19="Xinjiang CHN"
               20="Sichuan CHN"
               21="Potchefstroom SAfrica"
               22="Cape Town SAfrica"
               23="Tanzania"
               24="Tanzania"
               25="Ecuador"
               26="Colombia"
               27="Bishkek - Kyrgyzstan"
               28="Chyui Province - Kyrgyzstan"
               29="Jalal-Abad Province - Kyrgyzstan"
               30="Osh Province - Kyrgyzstan"
               31="UAE Mamzar"
               32="UAE Hataa"
               33="UAE Al Lusaily"
               34="Northern Sudan"
               35="Khartoum"
               36="West Darfur"
               37="Elgazira"
               38="Red Sea"
               40="Harare Zimbabwe"
               45="Brazil"
               54="Russia - Kemerovo Region"
               55="Russia - Novgorod Region"
               56="Russia - Rostov-na-Donu Region"
               57="Sweden"
               58="Russia - TBD"
               59="Russia - TBD"
               60="Russia - TBD"
               61="Kazakhstan - Almaty Region"
               62="Kazakhstan - Zhambyl Region"
               63="Temuco Chile"
               64="Peru"
               66="Palestine"
               67="CRC Iran"
               68="Saudi Arabia"
               70="Hamilton"
               71="Vancouver"
               72="Quebec"
               73="Ottawa"
               76="Rosario Argentina"
               77="CESCAS Argentina"
               78="CESCAS Chile"
               79="CESCAS Uruguay"
               80="Poland"
               81="Poland(PONS)"
               82="Turkmenistan - Region 1"
               83="Turkmenistan - Region 2"
               85="UITM Malaysia"
               86="UKM Malaysia"
               87="Philippines"
               88="Test"
               90="Bangladesh"
               93="Turkey"
               95="Pakistan"
               99="Scott MCHAT study";

  value locationf 1="Urban" 2="Rural";

  value locatf 1="Urban" 2="Rural";

  value countryf 1="India"
                2="China"
                3="South Africa"
                4="Colombia"
                5="UAE"
                6="Zimbabwe"
                7="Brazil"
                8="Sweden"
                9="Chile"
               10="Iran"
               11="Canada"
               12="Argentina"
               13="Poland"
               14="Malaysia"
               15="Bangladesh"
               16="Turkey"
               17="Pakistan"
               18="Tanzania"
               19="Palestine"
               20="Saudi Arabia"
               21="Philippines"
               22="Uruguay"
               23="Peru"
               24="Russia"
               25="Kazakhstan"
               26="Kyrgyzstan"
               27="Sudan"
               28="Ecuador";
/*
               28="Turkmenistan"
               29="Africa";
*/
  value new_countryf 1="Bangladesh"
                     2="India"
                     3="China"
                     4="Malaysia"
                     5="Tanzania"
                     6="South Africa"
                     7="Zimbabwe"
                     8="Pakistan"
                     9="Poland"
                    10="Sweden"
                    11="Turkey"
                    12="Argentina"
                    13="Brazil"
                    14="Colombia"
                    15="Chile"
                    16="Canada"
                    17="UAE"
                    18="Iran"
                    19="Palestine"
                    20="Saudi Arabia"
                    21="Philippines"
                    22="Peru"
                    23="Russia"
                    24="Kazakhstan"
                    25="Kyrgyzstan"
                    26="Sudan"
                    27="Uruguay"
                    28="Ecuador";
/*
                    27="Turkmenistan"
                    28="Africa"
*/

/*
   value gdpCtryf  1 = "Zimbabwe  "
                   2 = "Bangladesh"
                   3 = "Pakistan  "
                   4 = "India     "
                   5 = "China     "
                   6 = "Colombia  "
                   7 = "S Africa  "
                   8 = "Brazil    "
                   9 = "Iran      "
                  10 = "Turkey    "
                  11 = "Malaysia  "
                  12 = "Chile     "
                  12.5="Peru      "
                  13 = "Argentina "
                  14 = "Poland    "
                  15 = "Sweden    "
                  16 = "Canada    "
                  17 = "UAE       ";
*/
/*Chinthanie  add this GDP country format on Sept 19,2017 - GDP country oder based on 2010 world bank data*/
/*Please see modified verson by Shofique Next*/
/*
value gdpCtryf  1 =   "Tanzania "
                2 =   "Zimbabwe "
                3 =   "Bangladesh "
                4 =   "Kyrgyzstan "
                5 =   "Pakistan "
                6 =   "India "
                7 =   "Philippines "
                8 =   "Palestine "
                9 =   "China "
                10 =   "Peru "
                11 =   "Colombia "
                12 =   "Iran "
                13 =   "South Africa "
                14 =   "Kazakhstan "
                15 =   "Malaysia "
                16 =   "Argentina "
                17 =   "Turkey "
                18 =   "Russia "
                19 =   "Brazil "
                20 =   "Uruguay "
                21 =   "Poland "
                22 =   "Chile "
                23 =   "Saudi Arabia "
                24 =   "UAE "
                25 =   "Canada "
                26 =   "Sweden "
                 99 =  "Total";
*/
/*Modified by Shofique 19 April 2018 to add new countries*/

value gdpCtryf  1 =   "Tanzania "
                2 =   "Zimbabwe "
                3 =   "Bangladesh "
                4 =   "Kyrgyzstan "
                5 =   "Pakistan "
                6 =   "India "
                7 =   "Sudan "
                8 =   "Philippines "
                9 =   "Palestine "
                10 =  "China "
                11 =  "Ecuador "
                12 =   "Peru "
                13 =   "Colombia "
                14 =   "Iran "
                15 =   "SouthAfrica "
                16 =   "Kazakhstan "
                17 =   "Malaysia "
                18 =   "Argentina "
                19 =   "Turkey "
                20 =   "Russia "
                21 =   "Brazil "
                22 =   "Uruguay "
                23 =   "Poland "
                24 =   "Chile "
                25 =   "SaudiArabia "
                26 =   "UAE "
                27 =   "Canada "
                28 =   "Sweden "
                99 =  "Total";

value gdpCtryRf 28 =  "Tanzania "
                27 =  "Zimbabwe "
                26 =  "Bangladesh "
                25 =  "Kyrgyzstan "
                24 =  "Pakistan "
                23 =  "India "
                22 =  "Sudan "
                21 =  "Philippines "
                20 =  "Palestine "
                19 =  "China "
                18 =  "Ecuador "
                17 =  "Peru "
                16 =  "Colombia "
                15 =  "Iran "
                14 =  "South Africa "
                13 =  "Kazakhstan "
                12 =  "Malaysia "
                11 =  "Argentina "
                10 =  "Turkey "
                9 =  "Russia "
                8 =  "Brazil "
                7 =  "Uruguay "
                6 =  "Poland "
                5 =  "Chile "
                4 =  "Saudi Arabia "
                3 =  "UAE "
                2 =  "Canada "
                1 =  "Sweden "
                99 =  "Total";

  value ctryf 1 = "Bangladesh"
              2 = "India"
              3 = "Pakistan"
              4 = "China"
              5 = "Malaysia"
              6 = "Philippines"
              7 = "SouthAfrica"
              8 = "Tanzania"
              9 = "Zimbabwe"
             10 = "Canada"
             11 = "Sweden"
             12 = "Poland"
             13 = "Turkey"
             14 = "Iran"
             15 = "UAE"
             16 = "Palestine"
             17 = "SaudiArabia"
             18 = "Argentina"
             19 = "Brazil"
             20 = "Colombia"
             21 = "Chile"
             22 = "Peru"
             23 = "Russia"
             24 = "Kazakhstan"
             25 = "Kyrgyzstan"
             26 = "Sudan"
             27 = "Ecuador"
             28 = "Uruguay";
/*
             27="Turkmenistan"
             28="Africa"
*/
  value regionNf 1 = "SouthAsia"
                 2 = "SEAsia/China"
                 3 = "RussiaRelatedRepublics"
                 4 = "Africa"
                 5 = "NAmerica/EU"
                 6 = "MiddleEast"
                 7 = "SAmerica";

  value region2f 1 = "South Asia"
                 2 = "China"
                 3 = "SE Asia"
                 4 = "RussiaRelatedRepublics"
                 5 = "Africa"
                 6 = "NAmerica/EU"
                 7 = "MiddleEast"
                 8 = "SAmerica";

  value ctrypf 1 = "Canada"
              2 = "Sweden"
              3 = "UAE"
              4 = "Saudi Arabia"
              5 = "Argentina"
              6 = "Brazil"
              7 = "Chile"
              8 = "Ecuador"
              9 = "Malaysia"
             10 = "Poland"
             11 = "South Africa"
             12 = "Turkey"
             13 = "China"
             14 = "Philippines"
             15 = "Colombia"
             16 = "Iran"
             17 = "Palestine"
             18 = "Bangladesh"
             19 = "India"
             20 = "Pakistan"
             21 = "Zimbabwe"
             22 = "Tanzania"
             23 = "Peru"
             24 = "Russia"
             25 = "Kazakhstan"
             26 = "Kyrgyzstan"
             27 = "Sudan"
             28 = "Uruguay";
/*
             28="Turkmenistan"
             29="Africa"
*/

  value ncountryf 1="India"
                  2="China"
                  3="Other";

  value incCtryf   1 = "1.HIC"  2 = "2.UMIC"  3 = "3.LMIC" 4 = "4.LIC";
  value incCtryNf  1 = "HIC"   2 = "MIC"      3 = "LIC"    99 = "Total";
  value incCtryNNf 1 = "HIC"   2 = "MIC"      3 = "China"  4 = "LIC" 99 = "Total";

  value ctryRegNf  1 = "Canada/Sweden"
                   2 = "Poland/Turkey"
                   3 = "UAE/Iran/Palestine/Saudi Arabia"
                   4 = "SouthAsian"
                   5 = "Malaysia/Phillipines"
                   6 = "China"
                   7 = "SouthAmerican"
                   8 = "Africa"
                   99 ="Total";

  value ctryRegNNf  1 = "Canada/Sweden"
                    2 = "Poland/Turkey"
                    3 = "SouthAmerican"
                    4 = "UAE/Iran/Palestine/Saudi Arabia"
                    5 = "SouthAsian"
                    6 = "Malaysia/Phillipines"
                    7 = "China"
                    8 = "Africa"
                    99="Total";

  value AMOCUPGf 1 = "Legisiators,senior officials and managers"
                 2 = "Professionals"
                 3 = "Technicians and associate professionals"
                 4 = "Clerks"
                 5 = "Service,shop and market sales workers"
                 6 = "Skilled agricultural and fishery workers"
                 7 = "Craft and related trade workers"
                 8 = "Plant and machine operators and assemblers"
                 9 = "Elementary occupations"
                10 = "Armed forces"
                11 = "Homemaker";

  value highsbpf 0 = "SBP<140"
                 1 ="SBP>=140";

  value highdbpf 0 = "DBP<90"
                 1 = "DBP>=90";

  value highbpf  0 = "DBP<90 and SBP<140"
                 1 = "DBP>=90 or SBP>=140";

  value highsbp2f 0 = "SBP<160"
                  1 ="SBP>=160";

  value highdbp2f 0 = "DBP<100"
                  1 = "DBP>=100";

  value highbp2f  0 = "DBP<100 and SBP<160"
                 1 = "DBP>=100 or SBP>=160";

value sbpcf 1 = "SBP < 120"
            2 = "120<=SBP<130"
            3 = "130<=SBP<140"
            4 = "140<=SBP<160"
            5 = "160<=SBP<180"
            6 = "SBP>=180";

value dbpcf 1 = "DBP < 80"
            2 = "80<=DBP<85"
            3 = "85<=DBP<90"
            4 = "90<=DBP<100"
            5 = "100<=DBP<110"
            6 = "DBP>=110";

  value agegrpf  1 = "<50"
                 2 = "50-60"
                 3 = ">=60";

  value bmigrpf 1 = "0<bmi<20"
                2 = "20<= bmi<23"
                3 = "23<= bmi<25"
                4 = "25<= bmi<30"
                5 = "bmi>=30";

  value newbmigrpf 1 = "0<bmi<20"
                   2 = "20<=bmi<23"
                   3 = "23<=bmi<25"
                   4 = "25<=bmi<27"
                   5 = "27<=bmi<30"
                   6 = "bmi>=30";

  value overwtf 0 = "bmi<25"
                1 = "bmi>=25";

  value bmiquartf 1 = "BMI Quartile 1"
                  2 = "BMI Quartile 2"
                  3 = "BMI Quartile 3"
                  4 = "BMI Quartile 4";

  value bmiquintf 1 = "BMI Quintile 1"
                  2 = "BMI Quintile 2"
                  3 = "BMI Quintile 3"
                  4 = "BMI Quintile 4"
                  5 = "BMI Quintile 5";

  value whrquartf 1 = "WHR Quartile 1"
                  2 = "WHR Quartile 2"
                  3 = "WHR Quartile 3"
                  4 = "WHR Quartile 4";

  value whrquintf 1 = "WHR Quintile 1"
                  2 = "WHR Quintile 2"
                  3 = "WHR Quintile 3"
                  4 = "WHR Quintile 4"
                  5 = "WHR Quintile 5";

  value waistquintf 1 = "Waist Quintile 1"
                  2 = "Waist Quintile 2"
                  3 = "Waist Quintile 3"
                  4 = "Waist Quintile 4"
                  5 = "Waist Quintile 5";

  value swaistcf 0 = "Waist<=102 for men or <=88 for women"
                 1 = "Waist>102 for men or >88 for women";

  value swhrcf 0 = "Whr<=0.9 for men or <=0.85 for women"
               1 = "Whr>0.9 for men or >0.85 for women";

  value smokerf 0 = "Non-smoker"
                1 = "Current/former smoker";

  value alcbf   0 = "Not drink alcohol"
                1 = "Drink alcohol";

  value ffrf 0 = "FEV1/FVC>=75%"
             1 = "FEV1/FVC<75%";

  value hypf 0 = "No"
             1 = "Yes";

  value khypf 0 = "No"
              1 = "Yes";

  value khypallf 0 = "No"
              1 = "Yes";

  value thypf 0 = "No"
              1 = "Yes";

  value thypallf 0 = "No"
              1 = "Yes";

  value chypf 0 = "No"
              1 = "Yes";

  value chypallf 0 = "No"
                 1 = "Yes";

  value chtrf 0 = "No"
              1 = "Yes";

  value cthypf 0 = "No"
               1 = "Yes";

  value cthyp2f 0 = "No"
                1 = "Yes";

  value educf 1 = "None, Primary, or Unknown"
              2 = "Secondary/High/Higher secondary"
              3 = "Trade or College/University";

  value AMEMBERf 1 = "No"
                 2 = "Yes";

  value ophonestf 0 = "Disagree"
                  1 = "Agree";

  value optreatf 0 ="Disagree"
                 1 = "Agree";

  value opeoilf  0 ="Disagree"
                 1 = "Agree";

  value copebredf  0 ="Disagree"
                   1 = "Agree";

  value copecrlf  0 ="Disagree"
                  1 = "Agree";

  value opflourf 0 ="Disagree"
                 1 = "Agree";

  value opricef  0 ="Disagree"
                 1 = "Agree";

  value opsdrinkf 0 ="Disagree"
                  1 = "Agree";

  value opsnackf 0 ="Disagree"
                 1 = "Agree";

  value opcigarf 0 ="Disagree"
                 1 = "Agree";

  value opalcohf 0 ="Disagree"
                 1 = "Agree";

  value opmainfdf 0 = "Agree none of three"
                  1 = "Agree one of three"
                  2 = "Agree two of three"
                  3 = "Agree all of three";

  value opfdothf 0 = "Agree none of four"
                 1 = "Agree one of four"
                 2 = "Agree two of four"
                 3 = "Agree three of four"
                 4 = "Agree all of four";

  value elossf 1 = "No"
               2 = "Yes";

  value eviolencf 1 = "No"
                  2 = "Yes";

  value edeathf 1 = "No"
                2 = "Yes";

  value efamsepf 1 = "No"
                 2 = "Yes";

  value enewfamf 1 = "No"
                 2 = "Yes";

  value strworkf 1 = "No"
                 2 = "Yes";

  value strhomef 1 = "No"
                 2 = "Yes";

  value stressf 1 = "No"
                 2 = "Yes";

  value strfinacf 1 = "No"
                  2 = "Yes";

  value delosintf 0 = "No"
                  1 = "Yes";

  value defeltirf 0 = "No"
                  1 = "Yes";

  value degaiwtf 0 = "No"
                 1 = "Yes";

  value detrbslef 0 = "No"
                  1 = "Yes";

  value detrbconf 0 = "No"
                  1 = "Yes";

  value detdeatf 0 = "No"
                 1 = "Yes";

  value defeldowf 0 = "No"
                  1 = "Yes";

  value bregshopf 0 = "Disagree"
                  1 = "Agree";

  value bwalkdiff 0 = "Disagree"
                  1 = "Agree";

  value bfreepolf 0 = "Disagree"
                  1 = "Agree";

  value bstrwellf 0 = "Disagree"
                  1 = "Agree";

  value bseewalkf 0 = "Disagree"
                  1 = "Agree";

  value bspkwalkf 0 = "Disagree"
                  1 = "Agree";

  value bhighcrmf 0 = "Disagree"
                  1 = "Agree";

  value bprobdogf 0 = "Disagree"
                  1 = "Agree";

  value Qwavef 0 = "No" 1 = "Yes";
  value Qwave2f 0 = "No" 1 = "Yes";

  value chdf 0 = "No" 1 = "Yes";

  value chd2f 0 = "No" 1 = "Yes";

  value chd3f 0 = "No" 1 = "Yes";

  value cvdf  0 = "No" 1 = "Yes";

  value cvd2f 0 = "No" 1 = "Yes";

  value cvd3f 0 = "No" 1 = "Yes";

  value cookfuf 1 = "Wood"
                2 = "Kerosene"
                3 = "LPG Gas"
                4 = "Other";

  value cookfu2f 1 = "Kerosene"
                 2 = "Gas/Electricity"
                 3 = "Solid fuel";

  value cookfu3f 1 = "Solid Fuel"
                 2 = "Other";

  value cookfu4f 1 = "Solid Fuel"
                 2 = "Kerosene"
                 3 = "LPG Gas"
                 4 = "Other";

  value cookfu5f 1 = "Kerosene, gas, electricity"
                 2 = "Solid fuel";

  value wcookfuf 1 = "Wood"
                 2 = "Other";

  value facility2f 0 = "score<4"
                   1 = "score>=4";

  value neighb_s2f 0 = "score<4"
                   1 = "score>=4";

  value access2f 0 = "score<2"
                 1 = "score>=2";

  value street2f 0 = "score<2"
                 1 = "score>=2";

  value walkplc2f 0 = "score<2"
                  1 = "score>=2";

  value surround2f 0 = "score<2"
                   1 = "score>=2";

  value trafsafe2f 0 = "score<2"
                   1 = "score>=2";

  value crimsafe2f 0 = "score<2"
                   1 = "score>=2";

  value agree 0 = "Disagree"
              1 = "Agree";

  value  agreeable  0= "agreeable"
                 1= "disagreeable";

  value NAWSHOPf 0 = "Disagree"
              1 = "Agree";
  value NAWSTOREf 0 = "Disagree"
              1 = "Agree";
  value NAWPLACEf 0 = "Disagree"
              1 = "Agree";
  value NAWTRANSITf 0 = "Disagree"
              1 = "Agree";
  value NAWINTSECf 0 = "Disagree"
              1 = "Agree";
  value NAW4WAYINTf 0 = "Disagree"
              1 = "Agree";
  value NAWALTROUTf 0 = "Disagree"
              1 = "Agree";
  value NAWSIDEWKf 0 = "Disagree"
              1 = "Agree";
  value NAWGDSIDEWKf 0 = "Disagree"
              1 = "Agree";
  value NAWGRASSf 0 = "Disagree"
              1 = "Agree";
  value NAWTREESf 0 = "Disagree"
              1 = "Agree";
  value NAWGDVIEWf 0 = "Disagree"
              1 = "Agree";
  value NAWCLEANf 0 = "Disagree"
              1 = "Agree";
  value NAWCRSWKf 0 = "Disagree"
              1 = "Agree";
  value NAWLIGHTf 0 = "Disagree"
              1 = "Agree";

  value disagree 1 = "Disagree"
                 0 = "Agree";

  value NAWTRAFSTf 1 = "Disagree"
                 0 = "Agree";
  value NAWTRAFNBf 1 = "Disagree"
                 0 = "Agree";
  value NAWCRIMEDYf 1 = "Disagree"
                 0 = "Agree";
  value NAWCRIMENTf 1 = "Disagree"
                 0 = "Agree";

  value satisfied 0 = "Dissatisfied"
                  1 = "Satisfied";

  value NAWTRANSPf 0 = "Dissatisfied"
                  1 = "Satisfied";
  value NAWTIMESWf 0 = "Dissatisfied"
                  1 = "Satisfied";
  value NAWBSHOPf 0 = "Dissatisfied"
                  1 = "Satisfied";
  value NAWNUMKNOWf 0 = "Dissatisfied"
                  1 = "Satisfied";
  value NAWEASYWKf 0 = "Dissatisfied"
                  1 = "Satisfied";
  value NAWAMUSEf 0 = "Dissatisfied"
                  1 = "Satisfied";
  value NAWSAFETYf 0 = "Dissatisfied"
                  1 = "Satisfied";
  value NAWTRAFFICf 0 = "Dissatisfied"
                  1 = "Satisfied";
  value NAWGDKIDSf 0 = "Dissatisfied"
                  1 = "Satisfied";
  value NAWGDLIVEf 0 = "Dissatisfied"
                  1 = "Satisfied";
  value distance 0 = "> 20 mins"
                 1 = "<= 20 mins";
  value NAWGROCEf 0 = "> 20 mins"
                 1 = "<= 20 mins";
  value NAWCLOTHf 0 = "> 20 mins"
                 1 = "<= 20 mins";
  value NAWFRUVEGf 0 = "> 20 mins"
                 1 = "<= 20 mins";
  value NAWRESTAUf 0 = "> 20 mins"
                 1 = "<= 20 mins";
  value NAWBANKf 0 = "> 20 mins"
                 1 = "<= 20 mins";
  value NAWVIDEOf 0 = "> 20 mins"
                 1 = "<= 20 mins";
  value NAWMEDICIf 0 = "> 20 mins"
                 1 = "<= 20 mins";
  value NAWWKSCHf 0 = "> 20 mins"
                 1 = "<= 20 mins";
  value NAWBUSf 0 = "> 20 mins"
                 1 = "<= 20 mins";
  value NAWPARKf 0 = "> 20 mins"
                 1 = "<= 20 mins";

  value maritalf 1 ="Never married "
                 2 ="Currently married "
                 3 ="Common law/living with partner "
                 4 ="Widowed "
                 5 ="Separated and divorced";

  value bmigrp2f 1 = "0<bmi<25"
                 2 = "25<=bmi<30"
                 3 = "bmi>=30";

  value bmigrp3f 1 = "0<bmi<20"
                 2 = "20<=bmi<30"
                 3 = "bmi>=30";

  value depress2f 1 = "depress score >=3"
                  0 = "depress score <3";

  value hhwaterf 1 = "Piped water"
                2 = "Bottle/ tanker water"
                3 = "Other";

  value paybillf 1 = "All the time/ofter"
                2 = "Sometime"
                3 = "Rarely/never";

  value fourwhelf 1 = "Checked"
                  0 = "Blank";

  value asmleatf  0 = "False"
                  1 = "True";

  value actrlwtf  0 = "False"
                  1 = "True";

  value aanxseatf 0 = "False"
                  1 = "True";

  value ahdspeatf 0 = "False"
                  1 = "True";

  value aoeathungf 0 = "False"
                   1 = "True";

  value ablueatf  0 = "False"
                  1 = "True";

  value adelieatf 0 = "False"
                  1 = "True";

  value ahungryf  0 = "False"
                  1 = "True";

  value aalwshungf 0 = "False"
                   1 = "True";

  value aloneatf  0 = "False"
                  1 = "True";

  value anogainwtf 0 = "False"
                   1 = "True";

  value anoeatfatf 0 = "False"
                   1 = "True";

  value aeatanytmf 0 = "False"
                   1 = "True";

  value aexercisef 0 = "Disagree"
                   1 = "Agree";

  value afrutvegf  0 = "Disagree"
                   1 = "Agree";

  value afishf    0 = "Disagree"
                  1 = "Agree";

  value ameatf    0 = "Disagree"
                  1 = "Agree";

  value achipsf   0 = "Disagree"
                  1 = "Agree";

  value asodaf    0 = "Disagree"
                  1 = "Agree";

  value acookief  0 = "Disagree"
                  1 = "Agree";

  value obesityf  1 = "bmi>=30"
                  0 = "bmi<30";

  value occupgrpf 1 = "Professional/managers"
                  2 = "Skilled workers"
                  3 = "Unskilled workers"
                  4 = "Homemaker";

  value agegrpNf  1 = "35 - 44"
                  2 = "45 - 54"
                  3 = "55 - 70";

  value trchhypf  0 = "No"
                  1 = "Yes";

  value ukhypf    0 = "No"
                  1 = "Yes";

  value uphipf    1 = "4th quartile"
                  0 = "1,2,3 quartiles";

  value uptricepf 1 = "4th quartile"
                  0 = "1,2,3 quartiles";

  value tricepquartf 1 = "Quartile 1"
                     2 = "Quartile 2"
                     3 = "Quartile 3"
                     4 = "Quartile 4" ;

  value hipquartf  1 = "Quartile 1"
                   2 = "Quartile 2"
                   3 = "Quartile 3"
                   4 = "Quartile 4" ;

  value sbpquartf  1 = "Quartile 1"
                   2 = "Quartile 2"
                   3 = "Quartile 3"
                   4 = "Quartile 4" ;

  value asiaovwtf  1 = "bmi>=23"
                   0 = "bmi<23";

  value asiaobsef  1 = "bmi>=27.5"
                   0 = "bmi<27.5";

  value swaistaf   0 = "not abdominal obes"
                   1 = "abdominal obesity";

  value smokef     0 = "No"
                   1 = "Yes";

  value smokelessf 0 = "No"
                   1 = "Yes";

  value LDStatusf 1="Living member" 2="Dead member";


  value regionf  1 = "Asia"
                 2 = "Africa"
                 3 = "Europe"
                 4 = "South America"
                 5 = "North America"
                 6 = "Middle East"
                 7 = "Russia and Related Republics";


/* Format that Purnima created for her variables */
value noyesf
0="No"
1="Yes"
;

value underwtf
0="No"
1="Yes"
;

value freqdrinkerf
0="No"
1="Yes"
;
/* Remoded by Shofique due to conflict with original format source */
/*
value chhincoranf
1="<20K"
2="20K-30K"
3="30001-45K"
4="45001-65K"
5="65001-90K"
6=">90001"
;
*/

value hdllowf
0="HDL High"
1="HDL low";

value gstressf 1 = "Never"
               2 = "Some periods stress"
               3 = "Several periods stress"
               4 = "Permanent stress";

  value strclassf 1 = "0 event"
                 2 = "1 event"
                 3 = "2+ events";

  value efinstrsf 1 = "Little/none"
                 2 = "Moderate"
                 3 = "High/severe";

value regionmixf
1="Canada"
2="Sweden"
3="UAE"
4="South America"
5="Poland"
6="Turkey"
7="Iran"
8="China"
9="Malaysia"
10="South Asia"
11="South Africa"
12="Zimbabwe"
;

value smoke1yrf
1="Former Smoker"
2="Current Smoker (including those quited less than 1 yr)"
3="Never Smoker"
;

value smokecuruserf
1="Cigarettes"
2="Other Smoked"
3="Non-Smoked"
;

value smokeformuserf
1="Cigarettes"
2="Other Smoked"
3="Non-Smoked"
;

value smokecuruser2f
1="Cigarettes"
2="Beedies"
3="Cigars"
4="Pipes"
5="Sheesha/waterpipe"
6="Chewing Tobacco"
7="Snuff"
8="Opium"
9="Rolled Tobacco leaves"
10="Other"
;

value cigspdayf
1="Cigs<10/day"
2="Cigs10-19/day"
3="Cigs>=20/day"
;

value cigspastpdayf
1="Cigs<10/day"
2="Cigs10-19/day"
3="Cigs>=20/day"
;

value tobacombf
1="Current Cigs"
2="Current(Other Smoked)"
3="Current(Non Smoked)"
4="Former Cigs"
5="Former(Other Smoked)"
6="Former(Non Smoked)"
7="Never"
;

VALUE tobacombnof
1="Cur Cigs<10/day"
2="Curr Cigs10-19/day"
3="Cur Cigs>=20/day"
4="Cur Other Smoked"
5="Cur NonSmoked"
6="Past Cigs<10/day"
7="Past Cigs10-19/day"
8="Past Cigs>=20/day"
9="Past Other Smoked"
10="Past Non Smoked"
11="Never"
;

value diabselfmedsf
1="No to Self Reported"
2="Yes to self or meds"
3="Yes to self and meds"
;


value hyperdef1f
0="No"
1="Yes(SBP>140,DBP>90,DiagHTN,MedsHTN)"
;

value hyperdef2f
0="No"
1="Yes(SBP>=140,DBP>=100,DiagHTN,MedsHTN)"
;

value hyperstg2f
0="No"
1="Yes(SBP>=160,DBP>100,DiagHTN,MedsHTN)"
;

value bmiwhocatsf
1="1.BMI<18.5"
2="2.BMI 18.5-24.99"
3="3.BMI 25-29.99"
4="4.BMI 30-34.99"
5="5.BMI 35-39.99"
6="6.BMI>=40"
;

value bmiwhocats2f
1="BMI<16"
2="BMI 16-16.99"
3="BMI 17-18.49"
4="BMI 18.5-22.99"
5="BMI 23-24.99"
6="BMI 25-29.99"
7="BMI 30-34.99"
8="BMI 35-39.99"
9="BMI>=40"
;

VALUE stressfinf
1="Little/None"
2="Moderate"
3="High/Severe"
;

value global_stressf 1="None"
                       2="Some_periods"
                       3="Several_periods"
                       4="Permanent_stress";

value strwork2f
1="Never exp stress"
2="Some periods stress"
3="Several periods stress"
4="Permanent stress"
;

value strhome2f
1="Never exp stress"
2="Some periods stress"
3="Several periods stress"
4="Permanent stress"
;

value bingedrinker2f
1="Never Drinks"
2="<5 drinks/day"
3=">=5 drinks/day"
;

value freqdrinker2f
1="Never Drinks"
2="<1 drinks/day"
3=">=1 drinks/day"
;

  value efinstrs 1 = "Little/none"
                 2 = "Moderate"
                 3 = "High/severe";


value metall525f 1="METs<525"
                 2="METS>=525";

value leisphysactf 1="Sedentary"
                   2="Non-Sedentary";

value physactivallf 1="Low PA"
                    2="Moderate PA"
                    3="High PA";
/* Not associated with Baseline***
value causeDthf   1 = "Heart Attack/MI"
                  2 = "Stroke"
                  3 = "Cancer"
                  4 = "Accident"
                  5 = "Respiratory"
                  6 = "Infections"
                  7 = "Psychiatric illness"
                  8 = "Organ failure"
                  9 = "Suicide"
                 10 = "Injuries: Gun shots"
                 11 = "Neurological"
                 12 = "Diabetes"
                 13 = "Unknown";
*/

value fcdeath_newf
  1= "Heart attack- MI or disease of the heart"
  2= "Stroke - Cerebro vascular disease"
  3= "Cancer"
  4= "Not intentional accident - motor/fall/bites(bee, scorpio, etc/ poisoned/ disabled"
  5= "Intentional accident - suicide/gunshot/assault/homicide/poison"
  6= "Diabetes"
  7= "Mental/neurological disorder - alzeihmer/senelity/depression/dementia"
  8= "Kidney disease - nephritis, any kidney related"
  9= "Respiratory disease- COPD, , emphysema, chronic bronchitis, asthma"
  10= "Liver disease - cirrhosis, any liver related"
  11="Infectious diseases - septicemia, pneumonia, influenza, chaga's, malaria, etc"
  12= "Perinatal - inborn conditions or pregnancy related"
  13= "Autoimmune diseases - HIV, AIDS"
  14= "Hypertension/embolism/thrombosis/high cholesterol"
  15= "Surgical/atrophy"
  16= "Inflammatory"
  17= "Internal bleeding"
  18= "Organ failure"
  19= "Other"
  20= "Unknown";

  value physactf 1="Low PA -- Met score < 600"
               2="Moderate PA -- Met score in 600-3000"
               3="High PA -- Met score >= 3000";

value physact_WHOf 1="Low PA --Total activity minutes per week <= 150"
               2="Moderate PA -- 150 < Total activity minutes per week <=300"
               3="High PA -- Total activity minutes per week >= 300";



  value provIDf 1 ="India: Karnataka"
        2 ="India: Tamil Nadu"
        3 ="India: Rajasthan"
        5 ="India: Kerala"
        6 ="India: Haryana"
        8 ="China: Yunnan"
        9 ="China: Qinghai"
        11="China: Beijing"
        12="China: Jiangsu"
        13="China: Shandong"
        14="China: Shanxi"
        15="China: Shaanxi"
        16="China: Liaoning"
        17="China: Jiangxi"
        18="China: Inner Mongolia"
        19="China: Xinjiang"
        20="China: Sichuan"
        21="S Africa: North West Cape"
        22="S Africa: Southern Cape"
        23="Tanzania"
        24="Sudan"
        25="Africa-IndepthNetwork"
        26="Colombia: Andean"
        27="Colombia: Caribbean"
        28="Colombia: Central"
        29="Colombia: Eastern"
        31="UAE"
        40="Zimb: Mashonaland"
        45="Brazil: Sao Paulo"
        57="Sweden: Vastra"
        58="Scotland"
        59="Russia"
        63="Chile: Cautin"
        64="Peru"
        66="Palestine"
        67="Iran: Isfahan"
        68="Saudi Arabia"
        70="Canada: Ontario"
        71="Canada: British Columbia"
        72="Canada: Quebec"
        76="Argentina: SantaFe"
        77="CESCAS Argentina"
        78="CESCAS Chile"
        79="CESCAS Uruguay"
        80="Poland: Lower Silesian Voivodship"
        81="Malaysia: Selangor/Negeri Sembilan/Kuala Lumper"
        82="Malaysia: Kelantan"
        83="Malaysia: Pahang/Sabah"
        87="Philippines"
        90="Bangladesh: Dhaka"
        91="Turkey: Istanbul"
        92="Turkey: Eastern Anatolia"
        93="Turkey: Central Anatolia"
        94="Turkey: Aegean"
        95="Turkey: Blacksea"
        96="Turkey: Marmara"
        97="Turkey: Mediterranean"
        98="Turkey: Southeastern Anatolia"
        99="Pakistan: Sindh";

  value frvgf 1 = "Neither daily"
              2 = "Either fruits or vegetables daily"
              3 = "Both fruits and vegetables daily";
  value fruitcatf 1 = "Yes" 0 = "No";
  value vegetcatf 1 = "Yes" 0 = "No";

  value glustype
  .='missing'
  0='glukozanonfastingsample'
  1='glukozafastingsample';

  value withdrewf 1 = "No" 2 = "Yes";


/*format for baseline diabetes dataset*/
  value diabf 1 = "Yes" 0 = "No";
  value adiabf 1 = "Yes" 0 = "No";
  value glustat1f 1 = "Yes" 0 = "No";


/*format for baseline dateaq-related variables*/
  value dateaq_sourcef
                     0="Baseline Adult Questionnaire"
                     1="Participant Registration Form"
                     2="PAQ(baseline)"
                     3="ECG(baseline)"
                     4="Household Questionnaire"
                     5="Family Census"
                     6="Household Registration Form"
                     7="Household Contact Form(FU)";

value dateaqunkf 1="No"  2="Yes";
value aethf 1 ="South Asian (India, Sri Lanka, Pakistan, Bangladesh) "
    2 ="Chinese (China, Hong Kong, Taiwan) "
    3 ="Japanese "
    4 ="Malays "
    5 ="Other Asian (Korea, Malaysia, Papua New Guinea, Thailand, Philippines, Indonesia, Nepal, Viet
nam, C "
    6 ="Persian "
    7 ="Arab "
    8 ="Black African "
    9 ="Coloured African (Subsaharan African only) "
    10 ="European "
    11 ="Native North/South American or Australian Aborigine "
    12 ="Latin American (Latino) "
    13 ="Bantu/ Semi Bantu "
    14 ="Hemitic/ Semi Hemitic "
    15 ="Nilotic/ Hausa "
    16 ="Pygmie "
    17 ="Swahili "
    18 ="Other (any other ethnoracial group not listed above) "
    19 ="Han "
    20 ="Wei "
    21 ="Meng "
    22 ="Chaoxian "
    23 ="Zang "
    24 ="Man "
    25 ="Hui "
    26 ="Xibo "
    27 ="HaNi "
    28 ="Dai "
    29 ="Yi ";

 value dcodef 0 = "No"
              1 = "Yes";

 value castecodef  1 = "Scheduled Caste"
                   2 = "Scheduled Tribe"
                   3 = "Other Backward Class"
                   4 = "Others";

value ADMEDCCdf 1 = "ACE inhibitor"
2 = "Beta blocker"
3 = "Calcium antagonist"
4 = "Diuretic"
5 = "Statin"
6 = "Aspirin"
7 = "Clopidogrel"
8 = "Warfarin"
9 = "Oral hypoglycemic"
10 = "Insulin injections"
11 = "Pain killers"
12 = "Vitamin supplements"
13 = "Other"
14 = "Nitrates"
15 = "Other BP lowering"
16 = "Other cholesterol lowering"
17 = "BP lowering non-specified"
18 = "Alpha antagonists"
19 = "ARB"
20 = "Anti-TB medications"
21 = "Digoxin"
22 = "Other Antiarrhythmics"
23 = "Ezetimibe"
24 = "Other Antiplatelets"
30 = "Respiratory tract medications"
31 = "Sweeteners"
32 = "Minerals"
33 = "Anti-inflammatories"
34 = "Antidepressants"
35 = "Antibiotics"
 /*added by Weihong 2018-10-25*/
50 = "Acid Peptic Disease Medications"
51 = "Anti Malarial Medication"
52 = "Antipsychotic Medication"
53 = "Anxiolytic medication + Sedatives"
54 = "Anticonvulsant"
55 = "Thyroid Medications"
56 = "Cancer Medications"
57 = "Osteoporosis Medications"
58 = "Antihistamine Medications"
60 = "Anti Gout Medications"
61 = "Prostate Medications"
62 = "Immunosuppresants"
63 = "Anti vertigo Medications"
64 = "Antiparkinsonism Medications"
65 = "Anti Angina Medications"
67 = "Hormonal Medications"
68 = "Ayurvedic Medications"
69 = "Homeopathic Medications"
        
88 = "Traditional Chinese Anti-Hypertensive Medications"
99 = "Not able to Code Inadequate Info";

 value YesNof 1 = "Yes"
              2 = "No";

value pct33wealthnf 1 = "Windex Tertile 1"
                    2 = "Windex Tertile 2"
                    3 = "Windex Tertile 3";

value pct33wealthcf 1 = "Windex Tertile 1"
                    2 = "Windex Tertile 2"
                    3 = "Windex Tertile 3";

value pct20wealthnf 1 = "Windex Quintile 1"
                    2 = "Windex Quintile 2"
                    3 = "Windex Quintile 3"
                    4 = "Windex Quintile 4"
                    5 = "Windex Quintile 5";

value pct10wealthnf 1 = "Windex Decile 1"
                    2 = "Windex Decile 2"
                    3 = "Windex Decile 3"
                    4 = "Windex Decile 4"
                    5 = "Windex Decile 5"
                    6 = "Windex Decile 6"
                    7 = "Windex Decile 7"
                    8 = "Windex Decile 8"
                    9 = "Windex Decile 9"
                    10 = "Windex Decile 10";

value pct5wealthnf 1 = "Windex Fifth 1"
                    2 = "Windex Fifth 2"
                    3 = "Windex Fifth 3"
                    4 = "Windex Fifth 4"
                    5 = "Windex Fifth 5"
                    6 = "Windex Fifth 6"
                    7 = "Windex Fifth 7"
                    8 = "Windex Fifth 8"
                    9 = "Windex Fifth 9"
                    10 = "Windex Fifth 10"
                    11 = "Windex Fifth 11"
                    12 = "Windex Fifth 12"
                    13 = "Windex Fifth 13"
                    14 = "Windex Fifth 14"
                    15 = "Windex Fifth 15"
                    16 = "Windex Fifth 16"
                    17 = "Windex Fifth 17"
                    18 = "Windex Fifth 18"
                    19 = "Windex Fifth 19"
                    20 = "Windex Fifth 20";

value phasef  1 = "Phase 1"
              2 = "Phase 2"
              3 = "Phase 3"
              4 = "Data integration sites"; /*Weihong added 4, on 2018-01-18, as per discussion at DB meeting with study team */


value adspirdnf  1 ="No " 
                 2 ="Yes ";

value spfmt  1="Old spirometer"           
             2="Both old and new spirometer" 
             3="New spirometer"
             4="Unknown";  /*for data integration site*/

value commSESf  1="Low"
                2="Middle"
                3="High";   /*Weihong added 2018/12/14 */


value avail      0 = "blank"  1 = "No"  2 = "Yes";
     value noyes      1 = "No" 2 = "Yes"  .="Missing";
     value yesno      0 = "No" 1 = "Yes" .="Missing";
     value rural      1 = "Urban" 2 = "Rural";
          value dcode      0 = "No anti-diab medication" 1 = "Oral hypoglycemic only"  2 = "Insulin only"  3="Oral hypoglycemic and Insulin";
     value pct20wealthcf 1 = "Windex Quintile 1"
                    2 = "Windex Quintile 2"
                    3 = "Windex Quintile 3"
                    4 = "Windex Quintile 4"
                    5 = "Windex Quintile 5";

run;

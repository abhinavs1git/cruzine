import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:cruzine/widgets/flipcard.dart';
import 'package:flutter/material.dart';
import 'package:countries_world_map/countries_world_map.dart';

import '../api_manager/api_manager.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? selectedCountry;
  List<List<String>> dishes = [];

  final Map<String, String> cuisines = {
  "af": "Afghan",
  "al": "Albanian",
  "dz": "Algerian",
  "as": "Samoan",
  "ad": "Catalan",
  "ao": "Angolan",
  "ai": "Caribbean",
  "aq": "N/A",
  "ag": "Caribbean",
  "ar": "Argentine",
  "am": "Armenian",
  "aw": "Caribbean",
  "au": "Australian",
  "at": "Austrian",
  "az": "Azerbaijani",
  "bs": "Bahamian",
  "bh": "Bahraini",
  "bd": "Bangladeshi",
  "bb": "Bajan",
  "by": "Belarusian",
  "be": "Belgian",
  "bz": "Belizean",
  "bj": "Beninese",
  "bm": "Bermudian",
  "bt": "Bhutanese",
  "bo": "Bolivian",
  "bq": "Caribbean",
  "ba": "Bosnian",
  "bw": "Botswanan",
  "bv": "N/A",
  "br": "Brazilian",
  "io": "N/A",
  "bn": "Bruneian",
  "bg": "Bulgarian",
  "bf": "Burkinabe",
  "bi": "Burundian",
  "cv": "Cape Verdean",
  "kh": "Cambodian",
  "cm": "Cameroonian",
  "ca": "Canadian",
  "ky": "Caribbean",
  "cf": "Central African",
  "td": "Chadian",
  "cl": "Chilean",
  "cn": "Chinese",
  "cx": "N/A",
  "cc": "N/A",
  "co": "Colombian",
  "km": "Comorian",
  "cd": "Congolese",
  "cg": "Congolese",
  "ck": "Polynesian",
  "cr": "Costa Rican",
  "hr": "Croatian",
  "cu": "Cuban",
  "cw": "Caribbean",
  "cy": "Cypriot",
  "cz": "Czech",
  "ci": "Ivorian",
  "dk": "Danish",
  "dj": "Djiboutian",
  "dm": "Caribbean",
  "do": "Dominican",
  "ec": "Ecuadorian",
  "eg": "Egyptian",
  "sv": "Salvadoran",
  "gq": "Equatorial Guinean",
  "er": "Eritrean",
  "ee": "Estonian",
  "sz": "Eswatini",
  "et": "Ethiopian",
  "fk": "Falkland Islander",
  "fo": "Faroese",
  "fj": "Fijian",
  "fi": "Finnish",
  "fr": "French",
  "gf": "French Guianese",
  "pf": "French Polynesian",
  "tf": "N/A",
  "ga": "Gabonese",
  "gm": "Gambian",
  "ge": "Georgian",
  "de": "German",
  "gh": "Ghanaian",
  "gi": "Gibraltarian",
  "gr": "Greek",
  "gl": "Greenlandic",
  "gd": "Grenadian",
  "gp": "Guadeloupean",
  "gu": "Chamorro",
  "gt": "Guatemalan",
  "gg": "Guernsey",
  "gn": "Guinean",
  "gw": "Bissau-Guinean",
  "gy": "Guyanese",
  "ht": "Haitian",
  "hm": "N/A",
  "va": "Vatican",
  "hn": "Honduran",
  "hk": "Hong Kongese",
  "hu": "Hungarian",
  "is": "Icelandic",
  "in": "Indian",
  "id": "Indonesian",
  "ir": "Iranian",
  "iq": "Iraqi",
  "ie": "Irish",
  "im": "Manx",
  "il": "Israeli",
  "it": "Italian",
  "jm": "Jamaican",
  "jp": "Japanese",
  "je": "Jersey",
  "jo": "Jordanian",
  "kz": "Kazakh",
  "ke": "Kenyan",
  "ki": "I-Kiribati",
  "kp": "North Korean",
  "kr": "South Korean",
  "xk": "Kosovar",
  "kw": "Kuwaiti",
  "kg": "Kyrgyz",
  "la": "Lao",
  "lv": "Latvian",
  "lb": "Lebanese",
  "ls": "Basotho",
  "lr": "Liberian",
  "ly": "Libyan",
  "li": "Liechtenstein",
  "lt": "Lithuanian",
  "lu": "Luxembourgish",
  "mo": "Macanese",
  "mg": "Malagasy",
  "mw": "Malawian",
  "my": "Malaysian",
  "mv": "Maldivian",
  "ml": "Malian",
  "mt": "Maltese",
  "mh": "Marshallese",
  "mq": "Martinican",
  "mr": "Mauritanian",
  "mu": "Mauritian",
  "yt": "Mahoran",
  "mx": "Mexican",
  "fm": "Micronesian",
  "md": "Moldovan",
  "mc": "Monégasque",
  "mn": "Mongolian",
  "me": "Montenegrin",
  "ms": "Montserratian",
  "ma": "Moroccan",
  "mz": "Mozambican",
  "mm": "Burmese",
  "na": "Namibian",
  "nr": "Nauruan",
  "np": "Nepalese",
  "nl": "Dutch",
  "nc": "New Caledonian",
  "nz": "New Zealander",
  "ni": "Nicaraguan",
  "ne": "Nigerien",
  "ng": "Nigerian",
  "nu": "Niuean",
  "nf": "Norfolk Islander",
  "mp": "Chamorro",
  "no": "Norwegian",
  "om": "Omani",
  "pk": "Pakistani",
  "pw": "Palauan",
  "ps": "Palestinian",
  "pa": "Panamanian",
  "pg": "Papua New Guinean",
  "py": "Paraguayan",
  "pe": "Peruvian",
  "ph": "Filipino",
  "pn": "Pitcairn Islander",
  "pl": "Polish",
  "pt": "Portuguese",
  "pr": "Puerto Rican",
  "qa": "Qatari",
  "mk": "Macedonian",
  "ro": "Romanian",
  "ru": "Russian",
  "rw": "Rwandan",
  "re": "Réunionese",
  "bl": "Saint Barthélemy",
  "sh": "Saint Helenian",
  "kn": "Kittitian",
  "lc": "Saint Lucian",
  "mf": "Saint Martin",
  "pm": "Saint-Pierrais",
  "vc": "Vincentian",
  "ws": "Samoan",
  "sm": "Sammarinese",
  "st": "São Toméan",
  "sa": "Saudi Arabian",
  "sn": "Senegalese",
  "rs": "Serbian",
  "sc": "Seychellois",
  "sl": "Sierra Leonean",
  "sg": "Singaporean",
  "sx": "Sint Maarten",
  "sk": "Slovak",
  "si": "Slovene",
  "sb": "Solomon Islander",
  "so": "Somali",
  "za": "South African",
  "gs": "South Georgian",
  "ss": "South Sudanese",
  "es": "Spanish",
  "lk": "Sri Lankan",
  "sd": "Sudanese",
  "sr": "Surinamese",
  "sj": "Svalbardian",
  "se": "Swedish",
  "ch": "Swiss",
  "sy": "Syrian",
  "tw": "Taiwanese",
  "tj": "Tajik",
  "tz": "Tanzanian",
  "th": "Thai",
  "tl": "Timorese",
  "tg": "Togolese",
  "tk": "Tokelauan",
  "to": "Tongan",
  "tt": "Trinidadian",
  "tn": "Tunisian",
  "tr": "Turkish",
  "tm": "Turkmen",
  "tc": "Turks Islander",
  "tv": "Tuvaluan",
  "rs": "serbian",
  "sc": "seychellois",
  "sl": "sierra leonean",
  "sg": "singaporean",
  "sx": "sint maarten (dutch part)",
  "sk": "slovak",
  "si": "slovenian",
  "sb": "solomon islands",
  "so": "somali",
  "za": "south african",
  "gs": "south georgian and south sandwich islands",
  "ss": "south sudanese",
  "es": "spanish",
  "lk": "sri lankan",
  "sd": "sudanese",
  "sr": "surinamese",
  "sj": "svalbard and jan mayen",
  "se": "swedish",
  "ch": "swiss",
  "sy": "syrian",
  "tw": "taiwanese",
  "tj": "tajik",
  "tz": "tanzanian",
  "th": "thai",
  "tl": "timorese",
  "tg": "togolese",
  "tk": "tokelauan",
  "to": "tongan",
  "tt": "trinidadian and tobagonian",
  "tn": "tunisian",
  "tr": "turkish",
  "tm": "turkmen",
  "tc": "turks and caicos islands",
  "tv": "tuvaluan",
  "ug": "ugandan",
  "ua": "ukrainian",
  "ae": "emirati",
  "gb": "british",
  "um": "united states minor outlying islands",
  "us": "american",
  "uy": "uruguayan",
  "uz": "uzbek",
  "vu": "vanuatuan",
  "ve": "venezuelan",
  "vn": "vietnamese",
  "vg": "british virgin islands",
  "vi": "u.s. virgin islands",
  "wf": "wallisian",
  "eh": "western saharan",
  "ye": "yemeni",
  "zm": "zambian",
  "zw": "zimbabwean",
  "ax": "åland islands"
};

 

 Future<void> fetchDishes(String id) async {
  setState(() {
    selectedCountry = id;
  });

  var cuisine = cuisines[selectedCountry] ?? "";  // Get the cuisine name

  try {
    List<dynamic> rawDishes = await getCuisine(cuisine);  // Fetch the raw data

    // Convert rawDishes to List<List<String>>
    List<List<String>> fetchedDishes = rawDishes.map((item) {
      return (item as List<dynamic>).map((subItem) => subItem.toString()).toList();
    }).toList();

    setState(() {
      dishes = fetchedDishes;  // Update the state with the correctly typed data
    });
  } catch (error) {
    print("Error fetching dishes: $error");
    // Handle the error, e.g., show a message to the user
  }
}

  void _showFlippableCard(BuildContext context, String dishID) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: FlippableCard(
            dishID: dishID,
          ),
        );
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    Container(
                      color: const Color(0xFF3A7BD5),
                      height: 800,
                      width: 320,
                      child: const Center(
                          child: Text("Swipe left to View Culinary Compass",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))),
                    ),
                    const SizedBox(width: 60),
                    InteractiveViewer(
                      child: SimpleMap(
                        countryBorder:
                            const CountryBorder(color: Color(0xFF14213D)),
                        instructions: SMapWorld.instructions,
                        defaultColor: Colors.blue.shade100,
                        callback: (id, name, tapDetails) {
                          fetchDishes(id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (selectedCountry != null)
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF14213D),
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Dishes from $selectedCountry',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(18),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: dishes.length.clamp(0, 6),
                      itemBuilder: (context, index) {
                        final dish = dishes[index];
                        return GestureDetector(
                          onTap: () => _showFlippableCard(context,dish[0]),
                          child: Card(
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    dish[2]!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dish[1]!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

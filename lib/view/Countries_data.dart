import 'package:covid_19_app/ApiModels/Api_Responce.dart';
import 'package:covid_19_app/view/SpecificCountryData.dart';
import 'package:flutter/material.dart';

class Covid_Countries_Data extends StatefulWidget {
  const Covid_Countries_Data({super.key});

  @override
  State<Covid_Countries_Data> createState() => _Covid_Countries_DataState();
}

class _Covid_Countries_DataState extends State<Covid_Countries_Data> {
  ApiResponce api_call = ApiResponce();
  final _searchcontroller = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Search For Your Country")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search_outlined),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  color: Colors.grey[800],
                  // height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FutureBuilder(
                    future: api_call.fetchCovidCountryData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text("Failed to load data"));
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      var data = snapshot.data;
                      return ListView.builder(
                        itemCount: data?.length,
                        itemBuilder: (context, index) {
                          final country = data?[index];
                          String? SearchCountry = country?.country;
                          if (_searchcontroller.text.isEmpty) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        specificCountry_Status(
                                          countryName:
                                              country?.country ?? "Unknown",
                                          image: country!.countryInfo!.flag!,
                                          totalcases: country.cases ?? 0,
                                          totalDeath: country.deaths ?? 0,
                                          totalRecovery: country.recovered ?? 0,
                                          todaysCases: country.todayCases ?? 0,
                                        ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(country?.country ?? "Unknown"),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    country?.countryInfo?.flag ?? '',
                                  ),
                                  backgroundColor: Colors.grey[200],
                                ),
                              ),
                            );
                          } else if (SearchCountry!.toLowerCase().contains(
                            _searchcontroller.text.toLowerCase(),
                          )) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        specificCountry_Status(
                                          countryName:
                                              country?.country ?? "Unknown",
                                          image: country!.countryInfo!.flag!,
                                          totalcases: country.cases ?? 0,
                                          totalDeath: country.deaths ?? 0,
                                          totalRecovery: country.recovered ?? 0,
                                          todaysCases: country.todayCases ?? 0,
                                        ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(country?.country ?? "Unknown"),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    country?.countryInfo?.flag ?? '',
                                  ),
                                  backgroundColor: Colors.grey[200],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

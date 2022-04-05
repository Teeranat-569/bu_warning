import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
//import http package manually

class MyDropDown extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyDropDown();
  }
}

class _MyDropDown extends State<MyDropDown>{

  String countryname, message;
  bool error;
  var data;

  List<String> countries = ["Nepal", "India", "USA"];
  //we make list of strings with the name of countries

  String dataurl = "http://192.168.0.112/test/city_list.php";
  // do not use http://localhost/ for your local machine, Android emulation do not recognize localhost
  // insted use your local ip address or your live URL, 
  // hit "ipconfig" on Windows or "ip a" on Linux to get IP Address

  @override
  void initState() {
    error = false;
    message = "";
    countryname = "Nepal"; //default country
    super.initState();
  }

  Future<void> getCity() async {
        var res = await http.post(dataurl + "?country=" + Uri.encodeComponent(countryname));
        //attache countryname on parameter country in url
        if (res.statusCode == 200) {
            setState(() {
                 data = json.decode(res.body);
                 if(data["error"]){
                     //check fi there is any error from server.
                     error = true;
                     message = data["errmsg"];
                 }
            });
        }else{
           //there is error
           setState(() {
               error = true;
               message = "Error during fetching data";
           });
        }
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
             appBar: AppBar(title:Text("City List"), backgroundColor: Colors.redAccent,),
             body:Container( 
                 padding:EdgeInsets.all(30),
                 child: Column(
                    children:<Widget>[
    
                     Container( //wrapper for Country list
                            child:DropdownButton(
                                isExpanded: true,
                                value: countryname,
                                hint: Text("Select Country"),
                                items: countries.map((countryone){
                                  return DropdownMenuItem(
                                    child: Text(countryone), //label of item
                                    value: countryone, //value of item
                                  );
                                 }).toList(), 
                                 onChanged: (value){
                                     countryname = value; //change the country name
                                     getCity(); //get city list.
                                 },
                            ),
                          
                     ),

                     Container( //wrapper for City list
                         margin: EdgeInsets.only(top:30),
                         child:error?Text(message):
                               data == null?
                               Text("Choose Country"):
                               cityList(),
                               //if there is error then show error message,
                               //else check if data is null,
                               //if not then show city list,
                               
                     )
                ]
             ),
         )
    );
  }

  Widget cityList(){ //widget function for city list
      List<CityOne> citylist = List<CityOne>.from(
         data["data"].map((i){
                         return CityOne.fromJSON(i);
         })
      ); //searilize citylist json data to object model.

      return DropdownButton(
                hint: Text("Select City"),
                isExpanded: true,
                items: citylist.map((cityOne){
                   return DropdownMenuItem(
                        child: Text(cityOne.cityname),
                        value: cityOne.cityname,
                     );
                }).toList(),
                onChanged: (value){ 
                  print("Selected city is $value");
                }
            );
  }
}

//model class to searilize country list JSON data.
class CityOne{
  String id, countryname, cityname;
  CityOne({this.id, this.countryname, this.cityname});

  factory CityOne.fromJSON(Map<String, dynamic> json){
     return CityOne(
       id:json["city_id"],
       countryname: json["country_name"],
       cityname: json["city_name"]
     );
  }
}
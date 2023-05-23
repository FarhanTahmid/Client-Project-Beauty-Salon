import 'dart:io';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:beauty_salon/backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum HairCutEnum { LairCut, BobCut, FrenchCut }

enum HairTreatmentEnum { MoistureTreatment, HotOilTreatment, ReluxTreatment }

enum FacialEnum { ClassicFacial, AntiAgingFacial, BrighteningHacial }

enum SkinTreatmentEnum { Belfeloplasty, ChemicalPeels, DarmaFillers }

enum ExtensionsEnum { NailExtension, LashExtension, HairExtension }

enum Pakage1Enum { Haircut, BodyMassage, Facial }

enum Pakage2Enum { HairSpa, BodySpa, MakeUp }

enum ServiceEnum { HomeService, InPersonService }

enum GenderEnum { Male, Female }

class BookingPage extends StatefulWidget {
  final String parlorPrimaryKey;
  final String parlorName;
  final String username;
  const BookingPage(
      {super.key,
      required this.parlorPrimaryKey,
      required this.username,
      required this.parlorName});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  HairCutEnum? _hairCutEnum;
  HairTreatmentEnum? _hairTreatmentEnum;
  FacialEnum? _facialEnum;
  SkinTreatmentEnum? _skinTreatmentEnum;
  ExtensionsEnum? _extensionsEnum;
  Pakage1Enum? _pakage1Enum;
  Pakage2Enum? _pakage2Enum;
  ServiceEnum? _serviceEnum;
  GenderEnum? _genderEnum;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var contactNoController = TextEditingController();
  var adressController = TextEditingController();

  void getBookingDetails() async {
    // Getting values extracted from the enums

    String hairCutValue = _hairCutEnum.toString();
    String hairCut = hairCutValue.split('.').last;

    String hairTreatmentValue = _hairTreatmentEnum.toString();
    String hairTreatment = hairTreatmentValue.split('.').last;

    String facialValue = _facialEnum.toString();
    String facial = facialValue.split('.').last;

    String skinTreatmentValue = _skinTreatmentEnum.toString();
    String skinTreatment = skinTreatmentValue.split('.').last;

    String extensionsValue = _extensionsEnum.toString();
    String extension = extensionsValue.split('.').last;

    String package1Value = _pakage1Enum.toString();
    String package1 = package1Value.split('.').last;

    String package2Value = _pakage2Enum.toString();
    String package2 = package2Value.split('.').last;

    String serviceValue = _serviceEnum.toString();
    String service = serviceValue.split('.').last;

    String genderValue = _genderEnum.toString();
    String gender = genderValue.split('.').last;

    // getting controller values
    String bookieName = nameController.text.toString();
    String bookieEmail = emailController.text.toString();
    String bookieContactNo = contactNoController.text.toString();
    String bookieAdress = adressController.text.toString();

    // Creating request
    Backend backend = Backend();
    String backendMeta = backend.backendServerMeta;
    final String bookingUrl = "$backendMeta/api/book_parlor";
    try {
      var response = await http.post(Uri.parse(bookingUrl), body: {
        // username
        'username': widget.username,
        'parlorID': widget.parlorPrimaryKey,
        'bookieName': bookieName,
        'bookieEmail': bookieEmail,
        'bookieContactNo': bookieContactNo,
        'bokieAdress': bookieAdress,
        'gender': gender,

        //parlor details
        'parlorName':widget.parlorName,
        'hairCut': hairCut,
        'hairTreatment': hairTreatment,
        'facial': facial,
        'skinTreatment': skinTreatment,
        'extension': extension,
        'package1': package1,
        'package2': package2,
        'service': service
      });
      var jsonResponse = jsonDecode(response.body);
      if (Platform.isAndroid) {
        Fluttertoast.showToast(
          msg: jsonResponse['success'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (Platform.isWindows) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonResponse['success']),
        ));
      }
    } catch (e) {
      if (Platform.isAndroid) {
        Fluttertoast.showToast(
          msg: "Please check your network connection and Try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (Platform.isWindows) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please check your network connection and Try again!"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.parlorName+" Parlor"),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.question_answer),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              "Hair Cuts",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            RadioListTile<HairCutEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: HairCutEnum.FrenchCut,
                groupValue: _hairCutEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(HairCutEnum.FrenchCut.name),
                onChanged: (val) {
                  setState(() {
                    _hairCutEnum = val;
                  });
                }),
            SizedBox(
              width: 10.0,
            ),
            RadioListTile<HairCutEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: HairCutEnum.BobCut,
                groupValue: _hairCutEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(HairCutEnum.BobCut.name),
                onChanged: (val) {
                  setState(() {
                    _hairCutEnum = val;
                  });
                }),
            SizedBox(
              width: 10.0,
            ),
            RadioListTile<HairCutEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: HairCutEnum.LairCut,
                groupValue: _hairCutEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(HairCutEnum.LairCut.name),
                onChanged: (val) {
                  setState(() {
                    _hairCutEnum = val;
                  });
                }),

            /////hair traetment
            ///
            Padding(padding: EdgeInsets.all(10.0)),
            const Text(
              "Hair Treatments",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10.0,
            ),
            RadioListTile<HairTreatmentEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: HairTreatmentEnum.HotOilTreatment,
                groupValue: _hairTreatmentEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(HairTreatmentEnum.HotOilTreatment.name),
                onChanged: (val) {
                  setState(() {
                    _hairTreatmentEnum = val;
                  });
                }),
            SizedBox(
              width: 10.0,
            ),
            RadioListTile<HairTreatmentEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: HairTreatmentEnum.ReluxTreatment,
                groupValue: _hairTreatmentEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(HairTreatmentEnum.ReluxTreatment.name),
                onChanged: (val) {
                  setState(() {
                    _hairTreatmentEnum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<HairTreatmentEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: HairTreatmentEnum.MoistureTreatment,
                groupValue: _hairTreatmentEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(HairTreatmentEnum.MoistureTreatment.name),
                onChanged: (val) {
                  setState(() {
                    _hairTreatmentEnum = val;
                  });
                }),

            ////facials
            ///
            Padding(padding: EdgeInsets.all(10.0)),
            const Text(
              "Facials",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<FacialEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: FacialEnum.AntiAgingFacial,
                groupValue: _facialEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(FacialEnum.AntiAgingFacial.name),
                onChanged: (val) {
                  setState(() {
                    _facialEnum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<FacialEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: FacialEnum.ClassicFacial,
                groupValue: _facialEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(FacialEnum.ClassicFacial.name),
                onChanged: (val) {
                  setState(() {
                    _facialEnum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<FacialEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: FacialEnum.BrighteningHacial,
                groupValue: _facialEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(FacialEnum.BrighteningHacial.name),
                onChanged: (val) {
                  setState(() {
                    _facialEnum = val;
                  });
                }),

            ////skin treatment
            ///
            Padding(padding: EdgeInsets.all(10.0)),
            const Text(
              "Skin Treatments",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<SkinTreatmentEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: SkinTreatmentEnum.Belfeloplasty,
                groupValue: _skinTreatmentEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(SkinTreatmentEnum.Belfeloplasty.name),
                onChanged: (val) {
                  setState(() {
                    _skinTreatmentEnum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<SkinTreatmentEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: SkinTreatmentEnum.ChemicalPeels,
                groupValue: _skinTreatmentEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(SkinTreatmentEnum.ChemicalPeels.name),
                onChanged: (val) {
                  setState(() {
                    _skinTreatmentEnum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<SkinTreatmentEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: SkinTreatmentEnum.DarmaFillers,
                groupValue: _skinTreatmentEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(SkinTreatmentEnum.DarmaFillers.name),
                onChanged: (val) {
                  setState(() {
                    _skinTreatmentEnum = val;
                  });
                }),

            Padding(padding: EdgeInsets.all(10.0)),
            const Text(
              "Extensions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<ExtensionsEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: ExtensionsEnum.HairExtension,
                groupValue: _extensionsEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(ExtensionsEnum.HairExtension.name),
                onChanged: (val) {
                  setState(() {
                    _extensionsEnum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<ExtensionsEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: ExtensionsEnum.LashExtension,
                groupValue: _extensionsEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(ExtensionsEnum.LashExtension.name),
                onChanged: (val) {
                  setState(() {
                    _extensionsEnum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<ExtensionsEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: ExtensionsEnum.NailExtension,
                groupValue: _extensionsEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(ExtensionsEnum.NailExtension.name),
                onChanged: (val) {
                  setState(() {
                    _extensionsEnum = val;
                  });
                }),

            Padding(padding: EdgeInsets.all(10.0)),
            const Text(
              ":: Pakage1 ::",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<Pakage1Enum>(
                contentPadding: EdgeInsets.all(0.0),
                value: Pakage1Enum.BodyMassage,
                groupValue: _pakage1Enum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(Pakage1Enum.BodyMassage.name),
                onChanged: (val) {
                  setState(() {
                    _pakage1Enum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<Pakage1Enum>(
                contentPadding: EdgeInsets.all(0.0),
                value: Pakage1Enum.Haircut,
                groupValue: _pakage1Enum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(Pakage1Enum.Haircut.name),
                onChanged: (val) {
                  setState(() {
                    _pakage1Enum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<Pakage1Enum>(
                contentPadding: EdgeInsets.all(0.0),
                value: Pakage1Enum.Facial,
                groupValue: _pakage1Enum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(Pakage1Enum.Facial.name),
                onChanged: (val) {
                  setState(() {
                    _pakage1Enum = val;
                  });
                }),

            Padding(padding: EdgeInsets.all(10.0)),
            const Text(
              ":: Pakage2 ::",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<Pakage2Enum>(
                contentPadding: EdgeInsets.all(0.0),
                value: Pakage2Enum.BodySpa,
                groupValue: _pakage2Enum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(Pakage2Enum.BodySpa.name),
                onChanged: (val) {
                  setState(() {
                    _pakage2Enum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<Pakage2Enum>(
                contentPadding: EdgeInsets.all(0.0),
                value: Pakage2Enum.HairSpa,
                groupValue: _pakage2Enum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(Pakage2Enum.HairSpa.name),
                onChanged: (val) {
                  setState(() {
                    _pakage2Enum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<Pakage2Enum>(
                contentPadding: EdgeInsets.all(0.0),
                value: Pakage2Enum.MakeUp,
                groupValue: _pakage2Enum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(Pakage2Enum.MakeUp.name),
                onChanged: (val) {
                  setState(() {
                    _pakage2Enum = val;
                  });
                }),

            Padding(padding: EdgeInsets.all(10.0)),
            const Text(
              "Service",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<ServiceEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: ServiceEnum.HomeService,
                groupValue: _serviceEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(ServiceEnum.HomeService.name),
                onChanged: (val) {
                  setState(() {
                    _serviceEnum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<ServiceEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: ServiceEnum.InPersonService,
                groupValue: _serviceEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(ServiceEnum.InPersonService.name),
                onChanged: (val) {
                  setState(() {
                    _serviceEnum = val;
                  });
                }),

            Padding(padding: EdgeInsets.all(10.0)),
            const Text(
              "Gender",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<GenderEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: GenderEnum.Female,
                groupValue: _genderEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(GenderEnum.Female.name),
                onChanged: (val) {
                  setState(() {
                    _genderEnum = val;
                  });
                }),
            SizedBox(
              width: 20.0,
            ),
            RadioListTile<GenderEnum>(
                contentPadding: EdgeInsets.all(0.0),
                value: GenderEnum.Male,
                groupValue: _genderEnum,
                tileColor: Colors.deepPurple.shade50,
                title: Text(GenderEnum.Male.name),
                onChanged: (val) {
                  setState(() {
                    _genderEnum = val;
                  });
                }),

            //////booking
            ///
            Padding(padding: EdgeInsets.all(10.0)),
            const Text(
              "Book Service",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            TextFormField(
              controller: contactNoController,
              decoration: InputDecoration(
                labelText: 'Number',
                prefixIcon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            TextFormField(
              controller: adressController,
              decoration: InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Confirm',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.w700),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xff4c505b),
                  child: IconButton(
                      color: Colors.white,
                      onPressed: getBookingDetails,
                      iconSize: 18,
                      icon: Icon(Icons.arrow_forward)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

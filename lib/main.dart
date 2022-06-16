// import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:open_file/open_file.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'mobile.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Seizure Intake Form';
    return GestureDetector(
        onTap: (() {
          FocusScope.of(context).unfocus();
        }),
        child: MaterialApp(
          title: appTitle,
          home: Scaffold(
            appBar: AppBar(
              title: const Text(appTitle),
              backgroundColor: const Color.fromARGB(255, 223, 224, 223),
              foregroundColor: Colors.black,
            ),
            body: const SingleChildScrollView(
              child: _MyCustomFormClass(),
            ),
            resizeToAvoidBottomInset: true,
          ),
        ));
  }
}

class _MyCustomFormClass extends StatefulWidget {
  const _MyCustomFormClass();

  @override
  MyCustomForm createState() => MyCustomForm();
}

class MyCustomForm extends State<_MyCustomFormClass> {
  TextEditingController _name = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  var _gender;

  @override
  Widget build(BuildContext context) {
    final genderList = ["Male", "Female", "Other", "Prefre not to say"];
    DropdownMenuItem<String> buildMenu(String item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        );
    return GestureDetector(
      onTap: (() {
        FocusScope.of(context).unfocus();
      }),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black38, width: 1),
              // color: Color.fromARGB(255, 255, 248, 249),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade600,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
                const BoxShadow(
                  color: Color.fromARGB(255, 255, 255, 255),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Patient\'s Information',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 2,
                    fontSize: 18,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name of Patient',
                        prefixIcon: InkWell(
                          child: Icon(Icons.person),
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                        prefixIcon: InkWell(
                          child: Icon(Icons.pending),
                        )),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black38, width: 1)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        hint: const Text('Gender'),
                        isExpanded: true,
                        value: _gender,
                        enableFeedback: true,
                        dropdownColor: const Color.fromARGB(255, 247, 242, 226),
                        items: genderList.map(buildMenu).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _gender = newVal;
                          });
                        }),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Weight',
                        prefixIcon: InkWell(
                          child: Icon(Icons.confirmation_number),
                        )),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextFormField(
                    controller: _date,
                    readOnly: true,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1920),
                              lastDate: DateTime.now())
                          .then((date) {
                        setState(() {
                          _date.text =
                              "${date?.day}-${date?.month}-${date?.year}";
                        });
                      });
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date Of Birth',
                        prefixIcon: InkWell(
                          child: Icon(Icons.calendar_month),
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        prefixIcon: InkWell(child: Icon(Icons.navigation))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number',
                        prefixIcon: InkWell(
                          child: Icon(Icons.phone),
                        )),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       primary: Colors.grey.shade800, // background
                //       onPrimary: Colors.white, // foreground
                //     ),
                //     onPressed: () async {},
                //     child: const Text('Add Profile Image'),
                //   ),
                // ),

                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade800, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () async {
                    final image = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['png','jpg','jpeg']
                    );
                    if(image==null){
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No image chosen'),
                        ),

                      );
                    }
      
                    final img_path = (image?.files.single.path);
                    print(img_path);
                    
                  },
                  child: const Text('Add Profile Image'),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black38, width: 1),
              // color: Color.fromARGB(255, 255, 248, 249),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade600,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
                const BoxShadow(
                  color: Color.fromARGB(255, 255, 255, 255),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Emergency Contact Details',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 2,
                    fontSize: 18,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        prefixIcon: InkWell(
                          child: Icon(Icons.person),
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number 1',
                        prefixIcon: InkWell(
                          child: Icon(Icons.phone_android_sharp),
                        )),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number 2',
                        prefixIcon: InkWell(
                          child: Icon(Icons.phone_android),
                        )),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black38, width: 1),
              // color: Color.fromARGB(255, 255, 248, 249),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade600,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
                const BoxShadow(
                  color: Color.fromARGB(255, 255, 255, 255),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Doctor Details',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 2,
                    fontSize: 18,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Full Name',
                        prefixIcon: InkWell(
                          child: Icon(Icons.person),
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contact Number',
                        prefixIcon: InkWell(
                          child: Icon(Icons.phone_android_sharp),
                        )),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email ID',
                        prefixIcon: InkWell(
                          child: Icon(Icons.email),
                        )),
                    keyboardType: TextInputType.emailAddress,
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly
                    // ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                _createPDF();
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();


    page.graphics.drawImage(
      PdfBitmap(await _readImageData("pdfimg.png")),
      Rect.fromLTWH(0, 100, 440, 500),
    );

    page.graphics.drawString('TEST PDF',PdfStandardFont(PdfFontFamily.helvetica,30));

    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'out.pdf');
  }

  Future<Uint8List> _readImageData(String name) async{
    final data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
  }
}

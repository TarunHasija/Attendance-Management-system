import 'dart:io';

import 'package:ams/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String birth = "Date of Birth";
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${User.employeeId.toLowerCase()}_profilepic.jpg");

    await ref.putFile(File(image!.path));

    /*ref refer to the reference to the root of the firebase storage
    then using getDownload Url we fetch the url of image which is a
    firebase link  to the image after that using then function we pass
    a value [value] to a setState function and assigning User.profilePic
     value to the value of image url we fetch using the getDownload Url */
    ref.getDownloadURL().then((value) async {
      setState(() {
        User.profilePicLink = value;
      });

      await FirebaseFirestore.instance
          .collection("Employee")
          .doc(User.id)
          .update({'profilePic': value});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                pickUploadProfilePic();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 80, bottom: 20),
                height: 120,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primary,
                ),
                child: Center(
                  child: User.profilePicLink == " "
                      ? Icon(
                          Icons.person,
                          size: deviceHeight(context) / 15,
                          color: Colors.white,
                          //using User.profilePic value which we assigned using
                          //   the value of [value] and passing it ot network as its takes
                          //   argument of a url and fetch that image
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(User.profilePicLink)),
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Employee ${User.employeeId}",
                  style: const TextStyle(fontSize: 18),
                )),
            const SizedBox(
              height: 50,
            ),
            User.canEdit
                ? textField("First Name", "First Name", firstNameController)
                : field(User.firstName, "First Name"),
            User.canEdit
                ? textField("Last Name", "Last Name", lastNameController)
                : field(User.lastName, "Last Name"),

            //------------Date of Birth Field--------------------

            User.canEdit
                ? GestureDetector(
                    onTap: () => {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: primary,
                                  secondary: primary,
                                  onSecondary: Colors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                  foregroundColor: primary,
                                )),
                                textTheme: const TextTheme(),
                              ),
                              child: child!,
                            );
                          }).then((value) {
                        setState(() {
                          birth = DateFormat("MM/dd/yyyy").format(value!);
                        });
                      }),
                    },
                    child: field(birth, "Date of Birth"),
                  )
                : field(User.birthDate, "Date Of Birth"),

            // -------------Date of Birth Field end------------------------
            User.canEdit
                ? textField("Address", "Address", addressController)
                : field(User.address, "Address"),

            //--------------Save Button -----------------------------------
            User.canEdit
                ? GestureDetector(
                    onTap: () async {
                      String firstName = firstNameController.text;
                      String lastName = lastNameController.text;
                      String address = addressController.text;
                      String birthDate = birth;

                      if (User.canEdit) {
                        if (firstName.isEmpty) {
                          showSnackBar("Please enter first name");
                        } else if (lastName.isEmpty) {
                          showSnackBar("Please enter your last name");
                        } else if (birthDate.isEmpty) {
                          showSnackBar("Please choose your Birth Date");
                        } else if (address.isEmpty) {
                          showSnackBar("Please enter your address");
                        } else {
                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(User.id)
                              .update({
                            'firstName': firstName,
                            'lastName': lastName,
                            'address': address,
                            'birthDate': birthDate,
                            'canEdit': false,
                          }).then((value) {
                            setState(() {
                              User.canEdit = false;
                              User.firstName = firstName;
                              User.lastName = lastName;
                              User.address = address;
                              User.birthDate = birthDate;
                            });
                          });
                        }
                      } else {
                        showSnackBar(
                            "You can't edit anymore , Please contact Department");
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16, top: 16),
                      height: 65,
                      width: deviceWidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black54),
                          color: primary),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget field(String text, String title) => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16, top: 10),
            height: 65,
            width: deviceWidth(context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black54)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      );

  // Textfield widget for profile page
  Widget textField(
      String hint, String title, TextEditingController controller) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20, top: 10),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black54,
            maxLines: 1,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.black38,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.black54,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black54))),
          ),
        ),
      ],
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
        )));
  }
}

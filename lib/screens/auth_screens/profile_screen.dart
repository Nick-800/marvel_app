import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/constants.dart';
import 'package:marvel_app/helpers/file_picker.dart';
import 'package:marvel_app/helpers/get_size.dart';
import 'package:marvel_app/models/user_model.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:marvel_app/widgets/buttons/main_button.dart';
import 'package:marvel_app/widgets/custome_text_form_filde.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController genderController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  List<String> genders = ['male', 'female'];
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isEnable = false;
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).getMe().then((userdata) {
      genderController.text = userdata!.gender;
      nameController.text = userdata.name;
      PhoneController.text = userdata.phone;
      dateController.text = userdata.dob.toIso8601String().substring(0, 10);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authConsumer, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile  Screen"),
        ),
        body: authConsumer.isFaild
            ? const Center(
                child: Text("soemthing went wrong "),
              )
            : authConsumer.isLoading || authConsumer.user == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Form(
                    key: formkey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 70),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  pickFiles().then((n) {
                                    if (n != null) {
                                      Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .updateUserPhoto(n);
                                    }
                                  });
                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      width: getSize(context).width * 0.4,
                                      height: getSize(context).width * 0.4,
                                      color: Colors.black12,
                                      child: Center(
                                          child: Image.network(
                                        fit: BoxFit.fill,
                                        width: getSize(context).width * 0.4,
                                        height: getSize(context).width * 0.4,
                                        authConsumer.user!.avatarUrl.toString(),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                            child: Container(
                                                width: getSize(context).width *
                                                    0.4,
                                                height: getSize(context).width *
                                                    0.4,
                                                color: Colors.black12,
                                                child: Icon(
                                                  Icons.person,
                                                  size: getSize(context).width *
                                                      0.15,
                                                )),
                                          );
                                        },
                                      )),
                                    ))),
                            SizedBox(
                              height: 40,
                            ),
                            CustomeTextFormFiled(
                                isEn: isEnable,
                                label: "name",
                                textEditingController: nameController,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "name cant be empty ";
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 25,
                            ),
                            CustomeTextFormFiled(
                                isEn: isEnable,
                                label: "phone",
                                textEditingController: PhoneController,
                                validate: (v) {
                                  if (v!.length != 10) {
                                    return " phone must be 10 numers ";
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            PopupMenuButton(
                              itemBuilder: (context) {
                                return List<PopupMenuItem>.from(
                                    genders.map((e) => PopupMenuItem(
                                          enabled: isEnable,
                                          onTap: () {
                                            setState(() {
                                              genderController.text = e;
                                              print(genderController.text);
                                            });
                                          },
                                          child: Text(e),
                                          value: e,
                                        )));
                              },
                              child: CustomeTextFormFiled(
                                  isEn: false,
                                  label: "Gender",
                                  textEditingController: genderController,
                                  validate: (v) {
                                    if (v!.isEmpty) {
                                      return "gsenser is requred ";
                                    }
                                    if (v != 'male' && v != 'female') {
                                      return "male or female ";
                                    }
                                    return null;
                                  }),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (isEnable) {
                                  showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1997),
                                          lastDate: DateTime(20060))
                                      .then((s) {
                                    setState(() {
                                      dateController.text =
                                          s!.toIso8601String().substring(0, 10);
                                      print(dateController.text);
                                    });
                                  });
                                }
                              },
                              child: CustomeTextFormFiled(
                                  isEn: false,
                                  label: "Date",
                                  hint: 'yyyy-mm-dd',
                                  textEditingController: dateController,
                                  validate: (v) {
                                    if (v!.isEmpty) {
                                      return "password is requred ";
                                    }
                                    return null;
                                  }),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: MainButton(
                                text: isEnable ? "cancel" : "edit",
                                onTap: () {
                                  setState(() {
                                    isEnable = !isEnable;
                                  });
                                  // Provider.of<AuthProvider>(context, listen: false).signup({
                                  //   "name": "${nameController.text}",
                                  //   "phone": "${PhoneController.text}",
                                  //   "gender": "${genderController.text}",
                                  //   "DOB": "${dateController.text}"
                                  // }).then((onValue) {
                                  //   if (onValue) {
                                  //     Navigator.pop(context);
                                  //     ScaffoldMessenger.of(context).showSnackBar(
                                  //         SnackBar(content: Text("created ")));
                                  //   }
                                  // });
                                },
                                borderRadius: 10,
                                btnColor: mainColor,
                              ),
                            ),
                            isEnable
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: MainButton(
                                      text: "save",
                                      onTap: () {
                                        Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .updateUser(UserModel(
                                                    id: authConsumer.user!.id,
                                                    name: nameController.text,
                                                    phone: nameController.text
                                                        .toString(),
                                                    serverId: authConsumer
                                                        .user!.serverId,
                                                    dob: DateTime.parse(
                                                        dateController.text),
                                                    gender:
                                                        genderController.text,
                                                    createdAt: authConsumer
                                                        .user!.createdAt,
                                                    updatedAt: authConsumer
                                                        .user!.updatedAt)
                                                .toJson())
                                            .then((onValue) {
                                          if (onValue) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text("Updated ")));

                                            isEnable = false;
                                          }
                                        });
                                      },
                                      borderRadius: 10,
                                      btnColor: mainColor,
                                    ),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
      );
    });
  }
}

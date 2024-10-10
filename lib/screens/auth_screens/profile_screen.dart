import 'package:flutter/material.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:marvel_app/widgets/custome_text_form_filde.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List genders = ["male", "female"];
  bool edit = false;

  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false)
        .getUser()
        .then((userData) {
      nameController.text = userData!.name;
      phoneController.text = userData!.phone;
      genderController.text = userData!.gender;
      dobController.text = userData!.dob.toString().substring(0, 10);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authConsumer, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile Screen"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    edit = !edit;
                  });
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 70),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/marvel_appLogo.png"),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomeTextFormFiled(
                      label: "name",
                      textEditingController: nameController,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "name cant be empty ";
                        }
                        return null;
                      },
                      isEn: edit),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomeTextFormFiled(
                      label: "phone",
                      textEditingController: phoneController,
                      validate: (v) {
                        if (v!.length != 10) {
                          return "phone must be only in 10 characters ";
                        }
                        return null;
                      },
                      isEn: edit),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomeTextFormFiled(
                      label: '',
                      textEditingController: TextEditingController(),
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "This field can't be empty";
                        }
                        return null;
                      },
              )
              ],
              ),
              ),
              ),
              ),
              );
              });
              
      
  }
}

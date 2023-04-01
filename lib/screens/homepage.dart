import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final departmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Appointment App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 100),
              buildInput("name", nameController),
              const SizedBox(height: 20),
              buildInput("Phone Number", phoneController),
              const SizedBox(height: 20),
              buildInput("age", ageController),
              const SizedBox(height: 20),
              buildInput("department", departmentController),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  var message =
                      "Hello there from ${phoneController.text} my name is ${nameController.text}. I am ${ageController.text} this years old. I am requestin to get a chance to meet the doctor in ${departmentController.text} department";
                  var client = Client();
                  try {
                    var response = await client.post(
                        Uri.parse(
                            "https://africas.up.railway.app/${message}/${phoneController.text}"),
                        headers: {
                          "Accept": "application/json",
                          "Content-type": "application/x-www-form-urlencoded"
                        });
                    if (response.statusCode == 200) {
                      print("messae send");
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildInput(String hintName, TextEditingController controller) {
  return Container(
    height: 60,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), border: Border.all()),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintName,
          hintStyle: TextStyle(
            color: Colors.grey[900],
          ),
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

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
  final hospitalNumber = TextEditingController();

  bool sending = false;

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text("name"),
                const SizedBox(height: 5),
                buildInput("name", nameController),
                const SizedBox(height: 20),
                Text("Phone"),
                const SizedBox(height: 5),
                buildInput("Phone Number", phoneController),
                const SizedBox(height: 20),
                Text("Hospital Number"),
                const SizedBox(height: 5),
                buildInput("hospital", hospitalNumber),
                const SizedBox(height: 20),
                Text("age"),
                const SizedBox(height: 5),
                buildInput("age", ageController),
                const SizedBox(height: 20),
                Text("department"),
                const SizedBox(height: 5),
                buildInput("department", departmentController),
                const SizedBox(height: 20),
                sending ? Center(child: const CircularProgressIndicator()) : GestureDetector(
                  onTap: () async {
                    setState(() {
                      sending = true;
                    });
                    var message =
                        "Hello there from ${phoneController.text} my name is ${nameController.text}. I am ${ageController.text} this years old. I am requestin to get a chance to meet the doctor in ${departmentController.text} department";
                    var client = Client();
                    try {
                      var response = await client.post(
                          Uri.parse(
                              "https://africas.up.railway.app/sms/send/${message}/${phoneController.text}/${hospitalNumber.text}"),
                          headers: {
                            "Accept": "application/json",
                            "Content-type": "application/x-www-form-urlencoded"
                          });
                      if (response.statusCode == 200) {
                        print("Message sent");
                        setState(() {
                          sending = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Message sent"),
                            ),
                          );
                        });
                      } else {
                        print("Message not sent");
                        setState(() {
                          sending = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Message not sent"),
                            ),
                          );
                        });
                      }

                      print("Message sent");
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

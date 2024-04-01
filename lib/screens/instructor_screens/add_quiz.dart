import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart';
import 'package:velocity_x/velocity_x.dart';
class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final ShowPlatformDatePicker platformDatePicker =
    ShowPlatformDatePicker(buildContext: context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0F1B47),
                    Color(0xFFE18D5B),
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      'Create Quiz'.text.xl4.white.make(),
                      //quiz title
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Quiz Title',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //points
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Points',
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 200,
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Choose Due Date',
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onTap: () async{
                            final newSelectedDatePicker =
                                await platformDatePicker.showPlatformDatePicker(
                              context,
                              selectedDate,
                              DateTime(2024),
                              DateTime.now().add(const Duration(days: 3650)),
                            );
                            setState(() {

                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_models/course_viewmodel.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final courseViewModel = CoursesViewmodel();

  final imageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? title;
  String? description;
  double? price;
  bool isLoading = false;

  void submit() async {
    if (formKey.currentState!.validate() &&
        imageController.text.trim().isNotEmpty) {
      formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });
      await courseViewModel.addCourse(
        title: title!,
        description: description!,
        imageUrl: imageController.text,
        price: price!,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kurs qo'shish"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nomi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos kurs nomini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                title = newValue;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Tarifi",
              ),
              minLines: 3,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos tarifi nomini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                description = newValue;
              },
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                final response = await showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text("Rasm"),
                      content: TextField(
                        controller: imageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Rasm URL",
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Bekor qilish"),
                        ),
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context, imageController.text);
                          },
                          child: const Text("Saqlash"),
                        ),
                      ],
                    );
                  },
                );

                if (response != null) {
                  setState(() {});
                }
              },
              child: Ink(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                  image: imageController.text.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(imageController.text),
                        )
                      : null,
                ),
                child: const Center(
                  child: Text(
                    "Rasm qo'shing",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Narxi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos narxini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                price = double.tryParse(newValue!) ?? 0;
              },
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : FilledButton(
                    onPressed: submit,
                    child: const Text("Yaratish"),
                  ),
          ],
        ),
      ),
    );
  }
}

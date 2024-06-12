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

      // Assuming addCourse returns a Future<void>, we should await it without using the result
      await courseViewModel.addCourse(
        title: title!,
        description: description!,
        imageUrl: imageController.text,
        price: price!,
      );

      // After adding course, go back to the previous screen
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Course"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter name";
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
                labelText: "Description",
              ),
              minLines: 3,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter description";
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
                final response = await showDialog<String>(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text("Image"),
                      content: TextField(
                        controller: imageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Image URL",
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text("Cancel"),
                        ),
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(ctx, imageController.text);
                          },
                          child: const Text("Save"),
                        ),
                      ],
                    );
                  },
                );

                if (response != null) {
                  setState(() {
                    imageController.text = response;
                  });
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
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Center(
                  child: imageController.text.isEmpty
                      ? const Text(
                          "Add Image",
                          style: TextStyle(fontSize: 16),
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Price",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter price";
                }
                if (double.tryParse(value) == null) {
                  return "Please enter a valid number";
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
                    child: const Text("Create"),
                  ),
          ],
        ),
      ),
    );
  }
}

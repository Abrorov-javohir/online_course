import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/course.dart';
import 'package:flutter_application_1/view_models/course_viewmodel.dart';
import 'package:flutter_application_1/view_models/lesson_viewmodel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AddLessonScreen extends StatefulWidget {
  final Course course;
  const AddLessonScreen({
    super.key,
    required this.course,
  });

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  final courseViewModel = CoursesViewmodel();
  final lessonsViewModel = LessonsViewmodel();
  final videoController = TextEditingController();
  YoutubePlayerController? _controller;
  final formKey = GlobalKey<FormState>();
  List<Course> courses = [];
  String? title;
  String? description;
  String? selectedCourseId;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      courses = await courseViewModel
          .getList(); 
      setState(() {});
    });

    selectedCourseId = widget.course.id;
  }

  void submit() async {
    if (formKey.currentState!.validate() &&
        videoController.text.trim().isNotEmpty) {
      formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });
      final lessonId = await lessonsViewModel.addLesson(
        title: title!,
        description: description!,
        videoUrl: videoController.text,
        courseId: widget.course.id,
      );
      List<String> lessonIds = [];
      for (var lesson in widget.course.lessons) {
        lessonIds.add(lesson);
      }
      lessonIds.add(lessonId!);
      await courseViewModel.addLessonsToCourse(
        selectedCourseId!,
        lessonIds,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dars qo'shish"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DropdownButtonFormField(
              value: widget.course.id,
              hint: const Text("Kursni tanlang"),
              items: courses.map((course) {
                return DropdownMenuItem(
                  value: course.id,
                  child: Text(course.title),
                );
              }).toList(),
              onChanged: (value) {
                selectedCourseId = value;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nomi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos dars nomini kiriting";
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
                  return "Iltimos dars tarifini kiriting";
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
                      title: const Text("Video"),
                      content: TextField(
                        controller: videoController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "YouTube Video URL",
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
                            Navigator.pop(context, videoController.text);
                          },
                          child: const Text("Saqlash"),
                        ),
                      ],
                    );
                  },
                );

                if (response != null) {
                  final videoId = YoutubePlayer.convertUrlToId(response);
                  if (videoId != null) {
                    _controller = YoutubePlayerController(
                      initialVideoId: videoId,
                      flags: const YoutubePlayerFlags(
                        autoPlay: true,
                        mute: true,
                      ),
                    );
                    setState(() {});
                  }
                }
              },
              child: Ink(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                  image: videoController.text.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(
                              'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(videoController.text)}/0.jpg'),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _controller == null
                    ? const Center(
                        child: Text(
                          "Video qo'shing",
                        ),
                      )
                    : YoutubePlayer(
                        controller: _controller!,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.amber,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.amber,
                          handleColor: Colors.amberAccent,
                        ),
                      ),
              ),
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

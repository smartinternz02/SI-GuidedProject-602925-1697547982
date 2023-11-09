import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rive_animation/services/video_service.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.94),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: pageHeight * 0.04,
                horizontal: pageWidth * 0.2,
              ),
              child: const Text(
                "Lip Reader",
                style: TextStyle(
                    fontSize: 45,
                    fontFamily: "Poppins",
                    height: 1.2,
                    color: Color(0xfff77d8e)),
              ),
            ),
            SizedBox(
              height: pageHeight * 0.045,
            ),
            Container(
              height: pageHeight * 0.3,
              width: pageWidth * 0.65,
              decoration: BoxDecoration(
                  color: const Color(0xfff77d8e).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.add_a_photo_outlined,
                size: pageWidth * 0.4,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: pageHeight * 0.09,
            ),
            ElevatedButton(
              onPressed: () async {
                var file =
                    await VideoService.getVideo(source: ImageSource.gallery);
                if (file == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("File Not Selected"),
                      backgroundColor: Theme.of(context).colorScheme.errorContainer,
                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("File Selected"),
                      backgroundColor: Theme.of(context).colorScheme.errorContainer,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  pageWidth * 0.4,
                  pageHeight * 0.053,
                ),
                backgroundColor: const Color(0xfff77d8e),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Upload",
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
            SizedBox(
              height: pageHeight * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    thickness: pageWidth * 0.01,
                    indent: pageWidth * 0.19,
                    endIndent: pageWidth * 0.05,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                const Text(
                  "OR",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: pageWidth * 0.01,
                    indent: pageWidth * 0.05,
                    endIndent: pageWidth * 0.19,
                    color: Colors.black.withOpacity(0.4),
                  ),
                )
              ],
            ),
            SizedBox(
              height: pageHeight * 0.04,
            ),
            ElevatedButton(
              onPressed: () async {
                var file =
                    await VideoService.getVideo(source: ImageSource.camera);
                if (file == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("File Not Selected"),
                      backgroundColor: Theme.of(context).colorScheme.errorContainer,
                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("File Selected"),
                      backgroundColor: Theme.of(context).colorScheme.errorContainer,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  pageWidth * 0.4,
                  pageHeight * 0.053,
                ),
                backgroundColor: const Color(0xfff77d8e),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Record your video",
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

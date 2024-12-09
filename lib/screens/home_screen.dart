import 'dart:io';

import 'package:digits_app/themes/app_pallete.dart';
import 'package:digits_app/widgets/dotted_border.dart';
import 'package:digits_app/widgets/gradinet_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker picker = ImagePicker();
  File? selectedImage;
  File? selectedCamImage;
  String result = '';

  @override
  void initState() {
    loadModel();
    super.initState();
  }

  Future<void> loadModel() async{
    try {
      await Tflite.loadModel(model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
    } catch(e) {
      print('Failed to load model: $e');
    }
  } 

  Future<File?> pickImage() async{
    try{
      final XFile? image =  await picker.pickImage(
        source: ImageSource.gallery
      );

      if(image != null){
        return File(image.path);
      }
      return null;
    } catch (e){
      return null;
    }
  }

  Future<void> predictImage(File image) async{
    try{
      final recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 1,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5
      );
      setState(() {
        if(recognitions != null && recognitions.isNotEmpty){
          result = recognitions[0]['label'];
        }
        else{
          result = 'no result';
        }
      });
    } catch(e){
      print('Error detecting the image: $e');
    }
  }

   Future<void> captureImage() async {
    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          selectedCamImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  void selectImage() async{
    final pickedImage = await pickImage();
    if(pickedImage!= null){
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: const Text(
              "Handwritten Digits Recognition",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            flexibleSpace: Container(  
              padding: const EdgeInsets.only(top: 100, left: 20,),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Pallete.gradient1,Pallete.backgroundColor],
                )
              ),
              child: const Text(
                "Handwritten Digits Recognition",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Pallete.whiteColor,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: selectImage,
                    child: selectedImage!=null 
                    ? SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            selectedImage!
                          ),
                        )
                      ) 
                    : const DottedBox(
                      text: 'Select The Digit Image', 
                      icon: Icon(
                        Icons.folder_open
                      ) 
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: captureImage,
                    child: selectedCamImage!=null 
                    ? SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            selectedCamImage!
                          ),
                        )
                      ) 
                    : const DottedBox(
                      text: 'Capture The Digit Image', 
                      icon: Icon(
                        Icons.camera
                      ) 
                    )
                  ),
                ),
                const SizedBox(height: 10,),
                Center(
                  child: result == '' 
                  ? const Text(
                    'Model Prediction',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Pallete.whiteColor
                    ),
                  )
                  : Text(
                    'Prediction: $result',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Pallete.whiteColor
                    ),
                  )
                ),
                const SizedBox(height: 30,),
                GradinetButton(
                  onTap: (){
                    predictImage(selectedImage!);
                  },
                  width: 250,
                  buttonText: 'Predict',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
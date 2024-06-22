import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfilePhotoUploadScreen extends StatefulWidget {
  const ProfilePhotoUploadScreen({super.key});

  @override
  State<ProfilePhotoUploadScreen> createState() => _ProfilePhotoUploadScreenState();
}

class _ProfilePhotoUploadScreenState extends State<ProfilePhotoUploadScreen> {
  File? _image;
  bool isUploaded = false;
  
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('profile_photos')
      .child('${user.uid}.jpg');
      final uploadTask = storageRef.putFile(_image!);

      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Update the user's profile photo URL in Firebase Auth
      await user.updatePhotoURL(downloadUrl);
      await user.reload();

      log('Profile photo URL:  ${user.photoURL}');
      
      setState(() {
        Navigator.pop(context);
      });
    } catch (e) {
      log('Error uploading profile photo: $e');
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Profile Photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null 
            ? 
             CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  
                )
            : const Icon(Icons.account_circle, size: 100),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
            
          ],
        ),
      ),
    );
  }
}

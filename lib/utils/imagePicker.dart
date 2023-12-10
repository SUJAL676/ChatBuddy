
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source,BuildContext context)
async {
  final ImagePicker _imagepicker=ImagePicker();
  XFile? _file=await _imagepicker.pickImage(source: source);
  if(_file!=null)
  {
    return await _file.readAsBytes();
  }
  else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Empty")));
  }
}
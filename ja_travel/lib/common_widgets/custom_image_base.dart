import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ja_travel/utils/image_utils.dart';

class CustomImageBase extends StatefulWidget {
  /*Custom widgte encargado de motstrar las imagenes ya sean network o file (base64) */
  const CustomImageBase({
    Key? key,
    this.height,
    this.width,
    this.fit,
    required this.defaultImage,
    this.imageString,
  }) : super(key: key);

  /*Definir la altura */
  final double? height;
  /*Definir la anchura */
  final double? width;
  /*Definiar el ratio */
  final BoxFit? fit;
  /*Definir el defaultImage */
  final defaultImage;
  /*Encargado de gestionar si se puede cambiar la imagen o no */
  final void Function(Future<String?>? value)? imageString;

  @override
  _CustomImageBaseState createState() => _CustomImageBaseState();
}

class _CustomImageBaseState extends State<CustomImageBase> {
  PickedFile? _image;

  @override
  Widget build(BuildContext context) {
    return widget.imageString != null
        ? GestureDetector(
            onTap: () {
              getImageFromUser(ImageSource.gallery);
            },
            child: chooseImageProfile(context))
        : chooseImageProfile(context);
  }

  Future getImageFromUser(ImageSource type) async {
    ImagePicker imagePicker = ImagePicker();
    try {
      final image = await imagePicker.getImage(source: type);
      setState(() {
        _image = image;
      });
    } catch (e) {
      print("Excepcion Image Picker: " + e.toString());
    }
  }

  Image chooseImageProfile(BuildContext context) {
    if (_image != null) {
      if (widget.imageString != null) {
        widget.imageString!(ImageUtils.encodePhoto(file: File(_image!.path)));
      }
      return Image.file(
        File(_image!.path),
        height: widget.height,
        fit: widget.fit,
        width: widget.width,
      );
    } else {
      return !ImageUtils.isNetwork(image: widget.defaultImage)
          ? Image.memory(
              ImageUtils.decodePhoto(photo: widget.defaultImage),
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
            )
          : Image.network(
              widget.defaultImage,
              height: widget.height,
              fit: widget.fit,
              width: widget.width,
            );
    }
  }
}

import 'package:flutter/material.dart';
import 'custom_image_base.dart';

/*Custom widget encargado de dibujar la cabecera de todos y hacerlo clickable o no */
class ProfilePhotoBackground extends StatelessWidget {
  const ProfilePhotoBackground(
      {Key? key,
      required this.bannerProfileImage,
      required this.photoProfileImage,
      this.bannerProfile,
      this.photoProfile})
      : super(key: key);

  /*Tipo funcion para obtener la foto cambiada */
  final Function(Future<String?>? value)? bannerProfile;
  final Function(Future<String?>? value)? photoProfile;
  /*Para cargar las primeras imagenes  */
  final String bannerProfileImage;
  final String photoProfileImage;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.topCenter, children: [
      SizedBox(
        height: 225,
      ),
      Stack(
        children: [
          Container(
            height: 175,
            width: MediaQuery.of(context).size.width,
            child: CustomImageBase(
              fit: BoxFit.cover,
              defaultImage: bannerProfileImage,
              imageString: bannerProfile,
            ),
          ),
          if (bannerProfile != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.edit,
                ),
              ),
            ),
        ],
      ),
      Positioned(
        bottom: 0,
        child: Stack(
          children: [
            ClipOval(
              child: CustomImageBase(
                  imageString: photoProfile,
                  height: 100,
                  defaultImage: photoProfileImage),
            ),
            if (photoProfile != null)
              Positioned(
                bottom: 0,
                right: 0,
                child: Icon(
                  Icons.camera_enhance_outlined,
                ),
              )
          ],
        ),
      )
    ]);
  }
}

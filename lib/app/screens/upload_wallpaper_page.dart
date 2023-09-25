import 'dart:io';
import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/extensions/xfile_to_file_extension.dart';
import 'package:dwalldrop/app/helpers/image_picker_helper.dart';
import 'package:dwalldrop/app/widgets/app_snack_bar.dart';
import 'package:dwalldrop/authentication/provider/is_logged_in_provider.dart';
import 'package:dwalldrop/backend/state/providers/upload_wallpaper_provider.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadWallpaperPage extends ConsumerStatefulWidget {
  const UploadWallpaperPage({super.key});

  @override
  ConsumerState<UploadWallpaperPage> createState() =>
      _UploadWallpaperPageState();
}

class _UploadWallpaperPageState extends ConsumerState<UploadWallpaperPage> {
  File? wallpaperFile;
  late final TextEditingController _wallpaperNameController;

  @override
  void initState() {
    super.initState();
    _wallpaperNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _wallpaperNameController.dispose();
  }

  // PICK THE WALLPAPER IMAGE FUNCTION
  Future<void> pickWallpaper(BuildContext context) async {
    final picker = await ImagePickerHelper.pickImageFromGallery();
    if (picker == null) {
      return;
    } else {
      final result = picker.toFile();
      setState(() {
        wallpaperFile = result;
      });
    }
  }

  Future<void> uploadFunction({
    required File? wallpaperFile,
    required String imageDimensions,
  }) async {
    await ref
        .read(
          uploadWallpaperProvider.notifier,
        )
        .uploadWallpaper(
          wallpaperFile: wallpaperFile!,
          wallpaperName: _wallpaperNameController.text,
          imageDimensions: '',
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    // final uploadComplete = ref.watch(uploadWallpaperProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(right: 21.w(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 26.h(context),
                ),
              ),
              TitleText(
                text: "Community Upload",
                size: 19.h(context),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 26.h(context),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
          child: Column(
            children: [
              SizedBox(height: 33.h(context)),

              SizedBox(height: 33.h(context)),
              Container(
                height: 330.h(context),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.h(context),
                  ),
                  color: AppColors.loginColor,
                ),
                child: wallpaperFile == null
                    ? const SizedBox()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(
                          25.h(context),
                        ),
                        child: Image.file(
                          wallpaperFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              SizedBox(height: 24.h(context)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleText(
                    text: "Your photos on Dwalldrops.",
                    size: 19.h(context),
                  ),
                  SizedBox(height: 8.h(context)),
                  TitleText(
                    text: "High quality photographs.",
                    size: 12.h(context),
                  ),
                  SizedBox(height: 8.h(context)),
                  TitleText(
                    text: "Original design and artwork.",
                    size: 12.h(context),
                  ),
                  SizedBox(height: 8.h(context)),
                  TitleText(
                    text: "No copyrighted or explicit content.",
                    size: 12.h(context),
                  ),
                ],
              ),
              SizedBox(height: 50.h(context)),

              // GIVE YOUR WALLPAPER A NAME
              SizedBox(
                height: 53.h(context),
                width: double.maxFinite,
                child: TextField(
                  controller: _wallpaperNameController,
                  style: TextStyle(
                    fontSize: 16.h(context),
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    labelText: "Give your wall a name",
                    labelStyle: TextStyle(
                      fontSize: 18.h(context),
                      color: Colors.white.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        40.h(context),
                      ),
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.lightGrey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 21.h(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SELECT WALLPAPER BUTTON
                  InkWell(
                    borderRadius: BorderRadius.circular(40.h(context)),
                    onTap: isLoggedIn
                        ? () async {
                            await pickWallpaper(context);
                          }
                        : () async {
                            // IMPLEMENT A SNACKBAR TO SHOW THAT THE USER MUST BE LOGGED IN TO UPLOAD THE IMAGE
                            appSnackBar(context, "Log in to upload wallpapers");
                          },
                    child: Ink(
                      height: 51.h(context),
                      width: 167,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          40.h(context),
                        ),
                        color: AppColors.loginColor,
                      ),
                      child: Center(
                        child: TitleText(
                          text: "Select...",
                          size: 16.h(context),
                        ),
                      ),
                    ),
                  ),

                  // UPLOAD BUTTON
                  // IF THE USER IS LOGGED IN THEN THE FUNCTIONAL BUTTON WILL DISPLAYED
                  if (isLoggedIn)
                    InkWell(
                      borderRadius: BorderRadius.circular(40.h(context)),
                      onTap: () async {
                        if (_wallpaperNameController.text.isNotEmpty &&
                            wallpaperFile != null) {
                          await uploadFunction(
                            wallpaperFile: wallpaperFile,
                            imageDimensions: '',
                          ).whenComplete(() {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          });
                        } else {
                          appSnackBar(context, "Fill the necessary things");
                        }
                      },
                      child: Ink(
                        height: 51.h(context),
                        width: 167,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            40.h(context),
                          ),
                          color: AppColors.yellowColor,
                        ),
                        child: Center(
                          child: TitleText(
                            text: "Upload",
                            color: Colors.black,
                            size: 16.h(context),
                          ),
                        ),
                      ),
                    )
                  // IF NOT THEN THE NON FUNCTIONAL BUTTON WILL BE DISPLAYED
                  else
                    Opacity(
                      opacity: 0.4,
                      child: Container(
                        alignment: Alignment.center,
                        height: 51.h(context),
                        width: 167,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            40.h(context),
                          ),
                          color: AppColors.yellowColor,
                        ),
                        child: TitleText(
                          text: "Upload",
                          color: Colors.black,
                          size: 16.h(context),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10.h(context)),
            ],
          ),
        ),
      ),
    );
  }
}

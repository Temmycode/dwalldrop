import 'dart:developer';
import 'package:dwalldrop/backend/enums/download_result.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';

class DownloadWallpaperClient {
  const DownloadWallpaperClient();
  static String error = '';
  Future<DownloadResult> downloadWallpaper({
    required String wallpaperUrl,
    required String wallpaperName,
  }) async {
    final externalStorage = await getApplicationDocumentsDirectory();
    try {
      // ignore: unused_local_variable
      await FlutterDownloader.enqueue(
        url: wallpaperUrl,
        savedDir: externalStorage.path,
        fileName: wallpaperName,
        showNotification: true,
        openFileFromNotification: false,
      );

      return DownloadResult.success;
    } catch (e) {
      error = e.toString();
      log(e.toString());
      return DownloadResult.failure;
    }
  }

  // THIS IS TO SET THE WALLPAPER TOTALLY
  Future<DownloadResult> setWallpaper({
    required int location,
    String? wallpaperUrl,
    String? wallpaperName,
  }) async {
    //  a value that will hold the location of the wallpaper we want to set
    String? downloadedWallpaperLocation;
    // variable hold the download result of our getDownloadedFilePathAndSetWallpaper() if the wallpaper has never been set
    DownloadResult? initialDownloadResult;
    try {
      // get all the tasks from the download manager and check if the it is null
      List<DownloadTask>? tasks = await FlutterDownloader.loadTasks();
      // checks if there are no downloads of any wallpaper on the device
      if (tasks == null) {
        // download the wallpaper and set it
        final downloadProcess = await downloadWallpaper(
          wallpaperUrl: wallpaperUrl!,
          wallpaperName: wallpaperName!,
        );
        if (downloadProcess == DownloadResult.success) {
          // check the downloaded wallpapers again in your storage
          List<DownloadTask>? newDownloadTask =
              await FlutterDownloader.loadTasks();

          // this function will get the downloaded wallpapers file so the wallpaper can be set
          final downloadResult = await getDownloadedFilePathAndSetWallpaper(
            tasks: newDownloadTask!,
            wallpaperUrl: wallpaperUrl,
            downloadedWallpaper: downloadedWallpaperLocation!,
            location: location,
          );

          // set your initail download result to the result gotten from the function above
          initialDownloadResult = downloadResult;
        }

        return initialDownloadResult!;
      } else {
        // get the wallpaper from the storage and set the wallpaper
        // the wallpaper has been downloaded before
        final downloadResult = await getDownloadedFilePathAndSetWallpaper(
          tasks: tasks,
          wallpaperUrl: wallpaperUrl!,
          downloadedWallpaper: downloadedWallpaperLocation!,
          location: location,
        );

        return downloadResult;
      }
    } catch (e) {
      error = e.toString();
      log(e.toString());
      return DownloadResult.failure;
    }
  }

  // this function retrieves the downloaded wallpaper and changes the phone wallpaper
  Future<DownloadResult> getDownloadedFilePathAndSetWallpaper({
    required List<DownloadTask> tasks,
    required String wallpaperUrl,
    required String downloadedWallpaper,
    required int location,
  }) async {
    try {
      DownloadTask? task = tasks.firstWhere(
        (task) =>
            task.url == wallpaperUrl &&
            task.status == DownloadTaskStatus.complete,
      );
      downloadedWallpaper = '${task.savedDir}/${task.filename!}';
      final bool result = await WallpaperManager.setWallpaperFromFile(
        downloadedWallpaper,
        location,
      );
      return result ? DownloadResult.success : DownloadResult.failure;
    } catch (e) {
      error = e.toString();
      log(e.toString());
      return DownloadResult.failure;
    }
  }
}

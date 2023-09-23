import 'package:dwalldrop/backend/enums/download_result.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
      return DownloadResult.failure;
    }
  }

  // THIS IS TO SET THE WALLPAPER TOTALLY

  // Future<String?> getDownloadedFilePath(String taskId) async {
  //   try {
  //     List<DownloadTask> tasks = await FlutterDownloader.loadTasks();
  //     DownloadTask? task = tasks.firstWhere(
  //       (task) =>
  //           task.taskId == taskId && task.status == DownloadTaskStatus.complete,
  //       orElse: () => null,
  //     );

  //     if (task != null) {
  //       return task.savedDir + '/' + task.filename;
  //     }
  //   } catch (e) {
  //     print('Error getting downloaded file path: $e');
  //   }
  //   return null;
  // }
}

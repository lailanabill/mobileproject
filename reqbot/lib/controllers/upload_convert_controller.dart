import 'package:file_picker/file_picker.dart';
import 'dart:io';

class UploadConvertController {
  List<String> uploadedFiles = [];
  String errorMessage = '';

  /// Picks files based on the specified type (audio or text).
  Future<List<String>> pickFile(String type) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: type == 'audio'
            ? FileType.audio
            : FileType.custom, // Use FileType.custom for text
        allowedExtensions: type == 'text' ? ['txt', 'md'] : null,
      );

      if (result != null && result.files.isNotEmpty) {
        final pickedFiles = result.files.map((file) => file.path!).toList();
        uploadedFiles.addAll(pickedFiles);
        return pickedFiles;
      } else {
        throw Exception('No files selected');
      }
    } catch (e) {
      errorMessage = 'Error uploading file: $e';
      throw Exception(errorMessage);
    }
  }

  /// Reads the content of a text file.
  Future<String> readFileContent(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.readAsString();
      } else {
        throw Exception('File does not exist at $filePath');
      }
    } catch (e) {
      errorMessage = 'Error reading file: $e';
      throw Exception(errorMessage);
    }
  }

  /// Deletes a file from the uploaded list.
  void deleteFile(String filePath) {
    uploadedFiles.remove(filePath);
  }

  /// Clears all uploaded files.
  void clearAllFiles() {
    uploadedFiles.clear();
  }

  /// Processes the uploaded files and performs specific actions (e.g., send to API).
  Future<void> processFiles(Function(String) onFileProcessed) async {
    try {
      for (final filePath in uploadedFiles) {
        // Perform specific processing logic here
        final content = await readFileContent(filePath);
        onFileProcessed(content);
      }
    } catch (e) {
      errorMessage = 'Error processing files: $e';
      throw Exception(errorMessage);
    }
  }
}

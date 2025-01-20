import 'dart:io';

void main() {
  final filePath = ".env";
  if (File(filePath).existsSync()) {
    print("SUCCESS: .env file found at $filePath");
    final content = File(filePath).readAsStringSync();
    print("Content of .env: $content");
  } else {
    print("FAILURE: .env file not found.");
  }
}
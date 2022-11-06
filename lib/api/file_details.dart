class FileDetailApi {
  final String fileName;
  final String owner;

  FileDetailApi(this.fileName, {this.owner = ""});
}

class FileDetails {
  final String fileName;
  final String url;
  final String owner;
  final int saves;
  final bool isRequestOnly;
  final List<String> tags;

  FileDetails({
    required this.fileName,
    required this.url,
    required this.owner,
    required this.saves,
    required this.isRequestOnly,
    required this.tags,
  });
}

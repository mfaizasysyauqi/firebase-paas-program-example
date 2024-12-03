class Note {
  final String id;
  final String content;
  final DateTime? timestamp;

  Note({
    required this.id,
    required this.content,
    this.timestamp,
  });
}
class ProjectModel {
  final int id;
  final String name;
  final String transcription;
//represent structured data where keys correspond to property names, and values hold the associated data.
  ProjectModel({
    required this.id,
    required this.name,
    required this.transcription,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      name: map['name'],
      transcription: map['transcription'] ?? '', // Default to empty string
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'transcription': transcription,
    };
  }
}

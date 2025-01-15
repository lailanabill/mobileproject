// ProjectModel represents a structured data model for projects.
// It maps the properties of a project to the corresponding fields in the database.
class ProjectModel {
  final int id; // Unique identifier for the project.
  final String name; // Name of the project.
  final String transcription; // Transcription associated with the project.

  // Constructor for creating a new ProjectModel instance.
  //
  // Parameters:
  // - id: Unique identifier for the project.
  // - name: Name of the project.
  // - transcription: Transcription associated with the project.
  ProjectModel({
    required this.id,
    required this.name,
    required this.transcription,
  });

  // Factory constructor for creating a ProjectModel instance from a map.
  //
  // Parameters:
  // - map: A map containing key-value pairs where keys match the property names.
  //
  // Returns:
  // - A new ProjectModel instance populated with data from the map.
  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'], // Extracts 'id' from the map.
      name: map['name'], // Extracts 'name' from the map.
      transcription: map['transcription'] ?? '', // Defaults to an empty string if null.
    );
  }

  // Converts the ProjectModel instance into a map.
  //
  // Returns:
  // - A map where keys are property names, and values are their corresponding data.
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Maps the 'id' property.
      'name': name, // Maps the 'name' property.
      'transcription': transcription, // Maps the 'transcription' property.
    };
  }
}

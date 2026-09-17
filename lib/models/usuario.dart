class Usuario {
  final int id;
  final String nombre;
  final String correo;
  final String telefono;

  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.telefono,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      telefono: json['telefono'],
    );
  }
}
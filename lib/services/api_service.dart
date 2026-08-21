import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Desde el emulador Android:
  // 10.0.2.2 = computadora donde está ejecutándose FastAPI.
  static const String baseUrl = 'http://10.0.2.2:8000';

  // ==========================================
  // REGISTRAR USUARIO
  // ==========================================
  static Future<Map<String, dynamic>> registrarUsuario({
    required String nombre,
    required String correo,
    required String password,
    required String telefono,
  }) async {
    final url = Uri.parse('$baseUrl/usuarios/');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nombre': nombre,
        'correo': correo,
        'password': password,
        'telefono': telefono,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['detail'] ?? 'Error al registrar usuario',
    );
  }

  // ==========================================
  // INICIAR SESIÓN
  // ==========================================
  static Future<String> iniciarSesion({
    required String correo,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/usuarios/login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        // FastAPI OAuth2PasswordRequestForm
        // recibe el correo en "username".
        'username': correo,
        'password': password,
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data['access_token'];
    }

    throw Exception(
      data['detail'] ?? 'Correo o contraseña incorrectos',
    );
  }
}
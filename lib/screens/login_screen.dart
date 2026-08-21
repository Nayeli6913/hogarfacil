import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _correoController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  bool _cargando = false;
  bool _ocultarPassword = true;

  @override
  void dispose() {
    _correoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ==========================================
  // LOGIN
  // ==========================================
  Future<void> _iniciarSesion() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _cargando = true;
    });

    try {
      final token = await ApiService.iniciarSesion(
        correo: _correoController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Inicio de sesión exitoso',
          ),
          backgroundColor: Colors.green,
        ),
      );

      // Por ahora mostramos el token en consola
      // para comprobar que FastAPI respondió correctamente.
      debugPrint('TOKEN RECIBIDO: $token');

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _cargando = false;
        });
      }
    }
  }

  // ==========================================
  // INTERFAZ
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,

                children: [

                  // ==========================
                  // ICONO
                  // ==========================

                  const Icon(
                    Icons.home_work_rounded,
                    size: 80,
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 20),

                  // ==========================
                  // NOMBRE
                  // ==========================

                  const Text(
                    'HogarFácilNayeli',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Inicia sesión para continuar',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ==========================
                  // CORREO
                  // ==========================

                  TextFormField(
                    controller: _correoController,

                    keyboardType:
                        TextInputType.emailAddress,

                    decoration: InputDecoration(
                      labelText:
                          'Correo electrónico',

                      hintText:
                          'ejemplo@correo.com',

                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),

                      filled: true,
                      fillColor: Colors.white,
                    ),

                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Ingresa tu correo';
                      }

                      if (!value.contains('@')) {
                        return 'Ingresa un correo válido';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  // ==========================
                  // CONTRASEÑA
                  // ==========================

                  TextFormField(
                    controller:
                        _passwordController,

                    obscureText:
                        _ocultarPassword,

                    decoration: InputDecoration(
                      labelText: 'Contraseña',

                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),

                      suffixIcon: IconButton(
                        icon: Icon(
                          _ocultarPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),

                        onPressed: () {
                          setState(() {
                            _ocultarPassword =
                                !_ocultarPassword;
                          });
                        },
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),

                      filled: true,
                      fillColor: Colors.white,
                    ),

                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return 'Ingresa tu contraseña';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 28),

                  // ==========================
                  // BOTÓN LOGIN
                  // ==========================

                  SizedBox(
                    height: 52,

                    child: ElevatedButton(
                      onPressed:
                          _cargando
                              ? null
                              : _iniciarSesion,

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue,

                        foregroundColor:
                            Colors.white,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),

                      child: _cargando
                          ? const SizedBox(
                              width: 24,
                              height: 24,

                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'INICIAR SESIÓN',

                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==========================
                  // REGISTRO
                  // ==========================

                  TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  },

  child: const Text(
    '¿No tienes una cuenta? Regístrate',

    style: TextStyle(
      fontSize: 15,
    ),
  ),
),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
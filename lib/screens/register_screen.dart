import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final passwordController = TextEditingController();
  final telefonoController = TextEditingController();

  bool cargando = false;
  bool ocultarPassword = true;

  Future<void> registrar() async {
    if (nombreController.text.trim().isEmpty ||
        correoController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        telefonoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa todos los campos'),
        ),
      );
      return;
    }

    setState(() {
      cargando = true;
    });

    try {
      await ApiService.registrarUsuario(
        nombre: nombreController.text.trim(),
        correo: correoController.text.trim(),
        password: passwordController.text,
        telefono: telefonoController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario registrado correctamente'),
        ),
      );

      await Future.delayed(const Duration(milliseconds: 800));

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst('Exception: ', ''),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          cargando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    nombreController.dispose();
    correoController.dispose();
    passwordController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.person_add,
              size: 80,
            ),

            const SizedBox(height: 20),

            const Text(
              'Crear una cuenta',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: nombreController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: correoController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: telefonoController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: ocultarPassword,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    ocultarPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      ocultarPassword = !ocultarPassword;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: cargando ? null : registrar,
                child: cargando
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Registrarse',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: cargando
                  ? null
                  : () {
                      Navigator.pop(context);
                    },
              child: const Text('Ya tengo una cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
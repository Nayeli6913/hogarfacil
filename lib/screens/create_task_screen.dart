import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _hogarController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _hogarController.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    try {
      await ApiService.crearTarea(
        titulo: _tituloController.text,
        descripcion: _descripcionController.text,
        idHogar: int.parse(_hogarController.text),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tarea creada correctamente"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva tarea"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: "Título",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese el título";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: "Descripción",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese la descripción";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _hogarController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "ID del hogar",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese el ID del hogar";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: _loading ? null : _guardar,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
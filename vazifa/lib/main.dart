import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlashlightControl(),
    );
  }
}

class FlashlightControl extends StatefulWidget {
  const FlashlightControl({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FlashlightControlState();
  }
}

class _FlashlightControlState extends State<FlashlightControl> {
  static const platform = MethodChannel('com.example/flashlight');
  bool _isFlashOn = false;

  Future<void> _toggleFlashlight(bool value) async {
    try {
      if (value) {
        await platform.invokeMethod('turnOn');
      } else {
        await platform.invokeMethod('turnOff');
      }
      setState(() {
        _isFlashOn = value;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Erroe: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chiroq"),
        centerTitle: true,
      ),
      body: Center(
        child: SwitchListTile(
          title: const Text("Chiroq(on/of)"),
          value: _isFlashOn,
          onChanged: (value) {
            _toggleFlashlight(value);
          },
        ),
      ),
    );
  }
}

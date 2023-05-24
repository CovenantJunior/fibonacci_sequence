import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const Color primaryColor = Color.fromRGBO(51, 153, 255, 1.0);
// const TargetPlatform platform = TargetPlatform.android;

void main() {
  runApp(const FibonacciSequence());
}

class FibonacciSequencePainter {}
  static const seedRadius = 2.0; // Seeds
  static const scaleFactor = 4;  // Scale
  static const tau = math.pi * 2;  // Tau
  static final phi = (math.sqrt(5) + 1) / 2; // Phi

  final int seeds;

  FibonacciSequencePainter(this.seeds);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width / 2;

    // Loop through seeds
    for (var i = 0; i < seeds; i++) {
      final theta = i * tau / phi;
      final r = math.sqrt(i) * scaleFactor;
      final x = center + r * math.cos(theta);
      final y = center - r * math.sin(theta);
      final offset = Offset(x, y);
      if (!size.contains(offset)) {
        continue;
      }
      drawSeed(canvas, x, y);
    }
  }

  @override
  bool shouldRepaint(FibonacciSequencePainter oldDelegate) {
    return oldDelegate.seeds != seeds;
  }

    // Draw a small circle showing a seed centered at (x,y).
  void drawSeed(Canvas canvas, double x, double y) {
    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..color = primaryColor;
    canvas.drawCircle(Offset(x, y), seedRadius, paint);
  }


  // Define FibonacciSequence
  class FibonacciSequence extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
      return _FibonacciSequence();
    }
  }

  // Build Widget
  class _FibonacciSequence extends State<FibonacciSequence> {
  double seeds = 100.0;

  int get seedCount => seeds.floor();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        platform: platform,
        brightness: Brightness.dark,
        sliderTheme: SliderThemeData.fromPrimaryColors(
          primaryColor: primaryColor,
          primaryColorLight: primaryColor,
          primaryColorDark: primaryColor,
          valueIndicatorTextStyle: const DefaultTextStyle.fallback().style,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Sunflower"),
        ),
        drawer: Drawer(
          child: ListView(
            children: const [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Sunflower 🌻",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: CustomPaint(
                    painter: FibonacciSequencePainter(seedCount),
                  ),
                ),
              ),
              Text("Showing $seedCount seeds"),
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 300),
                child: Slider.adaptive(
                  min: 20,
                  max: 2000,
                  value: seeds,
                  onChanged: (newValue) {
                    setState(() {
                      seeds = newValue;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigating to the GitHub repository
                  launchUrl('https://github.com/CovenantJunior/fibonacci-sequence');
                },
                child: const Text('GitHub'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
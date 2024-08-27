import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TweenAnimationBuilder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TweenAnimationBuilder Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ColorAnimationPage()),
                );
              },
              child: const Text('Color Animation'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SizeAnimationPage()),
                );
              },
              child: const Text('Size Animation'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RotationAnimationPage()),
                );
              },
              child: const Text('Rotation Animation'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FileUploadPage()),
                );
              },
              child: const Text('File Upload Progress'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CountdownTimerPage()),
                );
              },
              child: const Text('Countdown Timer'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeatherPage()),
                );
              },
              child: const Text('Weather Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const ProfilePage()),
                );
              },
              child: const Text('Profile Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Advanced3DCardPage()),
                );
              },
              child: const Text('Advanced 3D Card'),
            ),

          ],
        ),
      ),
    );
  }
}

class ColorAnimationPage extends StatelessWidget {
  const ColorAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Animation'),
      ),
      body: Center(
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(begin: Colors.blue, end: Colors.red),
          duration: const Duration(seconds: 3),
          builder: (BuildContext context, Color? color, Widget? child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(color ?? Colors.blue, BlendMode.modulate),
              child: child,
            );
          },
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class SizeAnimationPage extends StatelessWidget {
  const SizeAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Size Animation'),
      ),
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 50, end: 200),
          duration: const Duration(seconds: 3),
          builder: (BuildContext context, double size, Widget? child) {
            return Container(
              width: size,
              height: size,
              color: Colors.green,
            );
          },
        ),
      ),
    );
  }
}

class RotationAnimationPage extends StatelessWidget {
  const RotationAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rotation Animation'),
      ),
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 2 * 3.141592653589793),
          duration: const Duration(seconds: 3),
          builder: (BuildContext context, double angle, Widget? child) {
            return Transform.rotate(
              angle: angle,
              child: child,
            );
          },
          child: Container(
            width: 100,
            height: 100,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({super.key});

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  double uploadProgress = 0;

  void startUpload() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        uploadProgress = 0.2;
      });
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        uploadProgress = 0.5;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        uploadProgress = 0.8;
      });
    });
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        uploadProgress = 1.0;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startUpload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Upload Progress'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: uploadProgress),
            duration: const Duration(seconds: 1),
            builder: (BuildContext context, double progress, Widget? child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 20),
                  Text('${(progress * 100).toInt()}% Uploaded'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}


class CountdownTimerPage extends StatefulWidget {
  const CountdownTimerPage({super.key});

  @override
  _CountdownTimerPageState createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
      ),
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1, end: 0),
          duration: const Duration(seconds: 10),
          builder: (BuildContext context, double value, Widget? child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: value,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                Text(
                  '${(value * 10).toInt()}',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
          onEnd: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Countdown Complete!')),
            );
          },
        ),
      ),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool isSunny = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Weather Card'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isSunny = !isSunny;
            });
          },
          child: AnimatedWeatherCard(isSunny: isSunny),
        ),
      ),
    );
  }
}

class AnimatedWeatherCard extends StatelessWidget {
  final bool isSunny;

  const AnimatedWeatherCard({Key? key, required this.isSunny}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        begin: isSunny ? Colors.blue : Colors.grey,
        end: isSunny ? Colors.grey : Colors.blue,
      ),
      duration: const Duration(seconds: 2),
      builder: (context, color, child) {
        return Container(
          width: 300,
          height: 200,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: isSunny ? 30 : 20, end: isSunny ? 20 : 30),
                duration: const Duration(seconds: 2),
                builder: (context, temperature, child) {
                  return Text(
                    '${temperature.toInt()}°C',
                    style: const TextStyle(fontSize: 50, color: Colors.white),
                  );
                },
              ),
              const SizedBox(height: 20),
              TweenAnimationBuilder<IconData>(
                tween: IconTween(
                  begin: isSunny ? Icons.wb_sunny : Icons.cloud,
                  end: isSunny ? Icons.cloud : Icons.wb_sunny,
                ),
                duration: const Duration(seconds: 2),
                builder: (context, icon, child) {
                  return Icon(
                    icon,
                    color: Colors.white,
                    size: 60,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class IconTween extends Tween<IconData> {
  IconTween({required IconData begin, required IconData end}) : super(begin: begin, end: end);

  @override
  IconData lerp(double t) {
    return t < 0.5 ? begin! : end!;
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Profile Card'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: AnimatedProfileCard(isExpanded: isExpanded),
        ),
      ),
    );
  }
}

class AnimatedProfileCard extends StatelessWidget {
  final bool isExpanded;

  const AnimatedProfileCard({Key? key, required this.isExpanded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 200, end: isExpanded ? 400 : 200),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, height, child) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 20, end: isExpanded ? 40 : 20),
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          builder: (context, borderRadius, child) {
            return TweenAnimationBuilder<Color?>(
              tween: ColorTween(
                begin: Colors.white,
                end: isExpanded ? Colors.blue[100] : Colors.white,
              ),
              duration: const Duration(seconds: 1),
              builder: (context, color, child) {
                return Container(
                  height: height,
                  width: 300,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(borderRadius),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: isExpanded ? 1 : 0),
                        duration: const Duration(seconds: 1),
                        builder: (context, opacity, child) {
                          return Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: height * 0.3,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.blue,
                                    Colors.purple,
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(borderRadius),
                                  topRight: Radius.circular(borderRadius),
                                ),
                              ),
                              child: Opacity(
                                opacity: opacity,
                                child: const Center(
                                  child: Text(
                                    'Profile',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 1, end: isExpanded ? 1.5 : 1),
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                              builder: (context, scale, child) {
                                return Transform.scale(
                                  scale: scale,
                                  child: const CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        'https://www.w3schools.com/w3images/avatar2.png'),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 1, end: isExpanded ? 0 : 1),
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                              builder: (context, opacity, child) {
                                return Opacity(
                                  opacity: opacity,
                                  child: const Text(
                                    'John Doe',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                    ),
                                  ),
                                );
                              },
                            ),
                            if (isExpanded) ...[
                              const SizedBox(height: 20),
                              const Text(
                                'Mobile Developer',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Flutter Enthusiast',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class Advanced3DCardPage extends StatefulWidget {
  const Advanced3DCardPage({super.key});

  @override
  _Advanced3DCardPageState createState() => _Advanced3DCardPageState();
}

class _Advanced3DCardPageState extends State<Advanced3DCardPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced 3D Card Animation'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Advanced3DCard(isExpanded: isExpanded),
        ),
      ),
    );
  }
}

class Advanced3DCard extends StatelessWidget {
  final bool isExpanded;

  const Advanced3DCard({super.key, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: isExpanded ? 180 : 0),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOutBack,
      builder: (context, rotationY, child) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1, end: isExpanded ? 1.5 : 1),
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          builder: (context, scale, child) {
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: isExpanded ? 1 : 0),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (context, borderRadius, child) {
                return TweenAnimationBuilder<Color?>(
                  tween: ColorTween(
                    begin: Colors.blue[100],
                    end: isExpanded ? Colors.purple[300] : Colors.blue[100],
                  ),
                  duration: const Duration(seconds: 1),
                  builder: (context, color, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // Perspective transformation
                        ..rotateY(rotationY * math.pi / 180)
                        ..scale(scale),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(borderRadius * 20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 30,
                              spreadRadius: 10,
                              offset: Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0, end: isExpanded ? 1 : 0),
                              duration: const Duration(seconds: 1),
                              curve: const Interval(0.2, 1, curve: Curves.easeInOut),
                              builder: (context, opacity, child) {
                                return Opacity(
                                  opacity: opacity,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.blue.withOpacity(0.7),
                                            Colors.purple.withOpacity(0.7),
                                            Colors.red.withOpacity(0.7),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(borderRadius * 20),
                                          topRight: Radius.circular(borderRadius * 20),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '3D Card',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TweenAnimationBuilder<double>(
                                    tween: Tween<double>(begin: 1, end: isExpanded ? 1.2 : 1),
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                    builder: (context, scale, child) {
                                      return Transform.scale(
                                        scale: scale,
                                        child: const CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              'https://www.w3schools.com/w3images/avatar2.png'),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TweenAnimationBuilder<double>(
                                    tween: Tween<double>(begin: 1, end: isExpanded ? 0 : 1),
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                    builder: (context, opacity, child) {
                                      return Opacity(
                                        opacity: opacity,
                                        child: const Text(
                                          'John Doe',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  if (isExpanded) ...[
                                    const SizedBox(height: 20),
                                    const Text(
                                      'Mobile Developer',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Flutter Enthusiast',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
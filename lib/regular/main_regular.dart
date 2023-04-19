import 'dart:async';

import 'package:flutter/material.dart';
import 'package:product_tours_tutorial/regular/widgets/product_tour.dart';
import 'package:showcaseview/showcaseview.dart';

import 'controllers/product_tour_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await productTourController.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Product Tours',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final GlobalKey _firstTooltip = GlobalKey();
  final GlobalKey _secondTooltip = GlobalKey();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProductTour(
      firstTooltip: _firstTooltip,
      secondTooltip: _secondTooltip,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Showcase(
                  key: _firstTooltip,
                  onBarrierClick: () =>
                      productTourController.nextStep(context: context),
                  description:
                      'Here you can see how many times you have pressed the button',
                  child: Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Showcase(
            key: _secondTooltip,
            disposeOnTap: true,
            onTargetClick: () =>
                productTourController.nextStep(context: context),
            description:
                'This is the button you can press to increment the counter',
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}

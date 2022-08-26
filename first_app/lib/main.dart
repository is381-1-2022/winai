import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/1',
      routes: {
        '/': (context) => const MyHomePage(title: 'Home'),
        '/1': (context) => FirstPage(),
        '/2': (context) => SecondPage(),
        '/3': (context) => ThirdPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _image = 'images/logo-small.png';

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 100.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Image.asset(
                  _image,
                  height: 200,
                ),
              ),
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text('My first text'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter--;
                        _image = 'images/sad.png';
                      });
                    },
                    child: Text('-'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter = 0;
                        _image = 'images/logo-small.png';
                      });
                    },
                    child: Text('reset'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter++;
                        _image = 'images/smile.png';
                      });
                    },
                    child: Text('+'),
                  ),
                ],
              ),
              MyDynamicButton(),
              MyButton(),
              MyButton(),
              MyButton(),
              MyButton(),
              MyButton(),
              MyButton(),
              MyButton(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('My button'),
    );
  }
}

class MyDynamicButton extends StatefulWidget {
  @override
  State<MyDynamicButton> createState() => _MyDynamicButtonState();
}

class _MyDynamicButtonState extends State<MyDynamicButton> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _counter++;
        });
      },
      child: Text('$_counter'),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Hello'),
                ),
              );
            },
            icon: const Icon(Icons.tiktok),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/2');
            },
            icon: const Icon(Icons.forward),
          ),
        ],
      ),
      body: const Center(
        child: Text('Page 1'),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: const Center(
        child: Text('Page 2'),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 3'),
      ),
      body: const Center(
        child: Text('Page 3'),
      ),
    );
  }
}

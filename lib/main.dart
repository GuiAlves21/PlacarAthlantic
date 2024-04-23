import 'package:flutter/material.dart';
import 'placarVirtualMenu.dart';
import 'placarEletronicoMenu.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:placar_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1D2F40),
              Color(0xFF20638C),
              Color(0xFF2CB1BF),
              Color(0xFF2CBFBF),
              Color(0xFFD9D9D9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.25, 0.5, 0.75, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/imagens/padrao.png',
                    width: 200.0,
                    height: 200.0,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'ATHLANTIC',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 25.0,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlacarVirtualMenu()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF1D2F40),
                  minimumSize: Size(200.0, 50.0),
                ),
                child: Text(
                  'Placar Virtual',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlacarEletronicoMenu()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF1D2F40),
                  minimumSize: Size(200.0, 50.0),
                ),
                child: Text(
                  'Placar Eletrônico',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

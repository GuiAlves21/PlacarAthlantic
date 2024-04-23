import 'package:flutter/material.dart';
import 'dart:async';
import 'package:placar_app/firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

class PlacarFutsalHandBasEle extends StatefulWidget {
  @override
  _PlacarFutsalHandBasEleState createState() => _PlacarFutsalHandBasEleState();
}

class _PlacarFutsalHandBasEleState extends State<PlacarFutsalHandBasEle> {
  int placarEquipeA = 0;
  int placarEquipeB = 0;
  int placarSetEquipeA = 0;
  int placarSetEquipeB = 0;
  String textoExibido = '';
  int placarTempoSet = 0;
  int minutos = 0;
  int segundos = 0;
  Timer? timer;
  String tempoPlacar = "";
  TextEditingController minutosController = TextEditingController();
  TextEditingController segundosController = TextEditingController();
  TextEditingController textoExibidoController = TextEditingController();

  late final DatabaseReference _placarEquipeA;
  late final DatabaseReference _placarEquipeB;
  late final DatabaseReference _textoExibido;
  late final DatabaseReference _placarTempoSet;
  late final DatabaseReference _placarSetEquipeA;
  late final DatabaseReference _placarSetEquipeB;
  late final DatabaseReference _tempoPlacar;
  late StreamSubscription<DatabaseEvent> _placarEquipeAsubscription;
  late StreamSubscription<DatabaseEvent> _placarEquipeBsubscription;
  late StreamSubscription<DatabaseEvent> _textoExibidosubscription;
  late StreamSubscription<DatabaseEvent> _placarTempoSetsubscription;
  late StreamSubscription<DatabaseEvent> _placarSetEquipeAsubscription;
  late StreamSubscription<DatabaseEvent> _placarSetEquipeBsubscription;
  late StreamSubscription<DatabaseEvent> _tempoPlacarsubscription;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _tempoPlacar = FirebaseDatabase.instance.ref("placar/cronometro_placar");
    _placarEquipeA = FirebaseDatabase.instance.ref("placar/gols_casa");
    _placarEquipeB = FirebaseDatabase.instance.ref("placar/gols_visitante");
    _textoExibido = FirebaseDatabase.instance.ref('placar/texto_placar');
    _placarTempoSet = FirebaseDatabase.instance.ref('placar/set_quarto_tempo');
    _placarSetEquipeA = FirebaseDatabase.instance.ref('placar/set_falta_local');
    _placarSetEquipeB = FirebaseDatabase.instance.ref('placar/visitante');

    try {
      final tempoPlacarSnapshot = await _tempoPlacar.get();
      tempoPlacar = tempoPlacarSnapshot.value as String;
      final placarEquipeASnapshot = await _placarEquipeA.get();
      placarEquipeA = placarEquipeASnapshot.value as int;
      final placarEquipeBSnapshot = await _placarEquipeB.get();
      placarEquipeB = placarEquipeBSnapshot.value as int;
      final textoExibidoSnapshot = await _textoExibido.get();
      textoExibido = textoExibidoSnapshot.value as String;
      final placarTempoSetSnapshot = await _placarTempoSet.get();
      placarTempoSet = placarTempoSetSnapshot.value as int;
      final placarSetEquipeASnapshot = await _placarSetEquipeA.get();
      placarSetEquipeA = placarSetEquipeASnapshot.value as int;
      final placarSetEquipeBSnapshot = await _placarSetEquipeB.get();
      placarSetEquipeB = placarSetEquipeBSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }
    print("Iniciando a leitura do Firebase...");
    _tempoPlacarsubscription =
        _tempoPlacar.onValue.listen((DatabaseEvent event) {
      setState(() {
        tempoPlacar = (event.snapshot.value ?? 0) as String;
      });
    });
    _placarEquipeAsubscription =
        _placarEquipeA.onValue.listen((DatabaseEvent event) {
      setState(() {
        placarEquipeA = (event.snapshot.value ?? 0) as int;
      });
    });
    _placarEquipeBsubscription =
        _placarEquipeB.onValue.listen((DatabaseEvent event) {
      setState(() {
        placarEquipeB = (event.snapshot.value ?? 0) as int;
      });
    });
    _placarTempoSetsubscription =
        _placarTempoSet.onValue.listen((DatabaseEvent event) {
      setState(() {
        placarTempoSet = (event.snapshot.value ?? 0) as int;
      });
    });

    _textoExibidosubscription =
        _textoExibido.onValue.listen((DatabaseEvent event) {
      setState(() {
        textoExibido = (event.snapshot.value ?? 0) as String;
      });
    });

    _placarSetEquipeAsubscription =
        _placarSetEquipeA.onValue.listen((DatabaseEvent event) {
      setState(() {
        placarSetEquipeA = (event.snapshot.value ?? 0) as int;
      });
    });

    _placarSetEquipeBsubscription =
        _placarSetEquipeB.onValue.listen((DatabaseEvent event) {
      setState(() {
        placarSetEquipeB = (event.snapshot.value ?? 0) as int;
      });
    });
  }

  void definirTempo() async {
    setState(() {
      minutos = int.tryParse(minutosController.text) ?? 0;
      segundos = int.tryParse(segundosController.text) ?? 0;
      String minutosText = minutosController.text;
      String segundosText = segundosController.text;
      tempoPlacar = '$minutosText$segundosText';
      print('$tempoPlacar');
      pararTemporizador();
    });
    await _tempoPlacar.set(tempoPlacar);
  }

  void iniciarTemporizador() {
    int tempoTotalEmSegundos = (minutos * 60) + segundos;

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (tempoTotalEmSegundos > 0) {
          if (segundos == 0) {
            minutos--;
            segundos = 59;
          } else {
            segundos--;
          }
          tempoTotalEmSegundos--;

          _tempoPlacar.set(formatarTempoBanco((minutos * 60) + segundos));
        } else {
          pararTemporizador();
        }
      });
    });
  }

  void pararTemporizador() {
    setState(() {
      timer?.cancel();
    });
  }

  String formatarTempoBanco(int segundos) {
    int minutos = segundos ~/ 60;
    int segundosRestantes = segundos % 60;
    String minutosStr = minutos.toString().padLeft(2, '0');
    String segundosStr = segundosRestantes.toString().padLeft(2, '0');
    return '$minutosStr$segundosStr';
  }

  String formatarTempo(int segundos) {
    int minutos = segundos ~/ 60;
    int segundosRestantes = segundos % 60;
    String minutosStr = minutos.toString().padLeft(2, '0');
    String segundosStr = segundosRestantes.toString().padLeft(2, '0');
    return '$minutosStr:$segundosStr';
  }

  void atualizarTextoExibido() async {
    setState(() {
      textoExibido = textoExibidoController.text;
    });

    await _textoExibido.set(textoExibido);
  }

  incrementarPlacarEquipeA() async {
    print("Incrementando placar da equipe A.");
    await _placarEquipeA.set(ServerValue.increment(1));
  }

  decrementarPlacarEquipeA() async {
    print("Decrementando placar da equipe A.");
    await _placarEquipeA.set(ServerValue.increment(-1));
  }

  incrementarPlacarEquipeB() async {
    await _placarEquipeB.set(ServerValue.increment(1));
  }

  decrementarPlacarEquipeB() async {
    await _placarEquipeB.set(ServerValue.increment(-1));
  }

  incrementarPlacarSetEquipeA() async {
    await _placarSetEquipeA.set(ServerValue.increment(1));
  }

  decrementarPlacarSetEquipeA() async {
    await _placarSetEquipeA.set(ServerValue.increment(-1));
  }

  resetSetA() async {
    await _placarSetEquipeA.set(0);
  }

  incrementarPlacarSetEquipeB() async {
    await _placarSetEquipeB.set(ServerValue.increment(1));
  }

  decrementarPlacarSetEquipeB() async {
    await _placarSetEquipeB.set(ServerValue.increment(-1));
  }

  resetSetB() async {
    await _placarSetEquipeB.set(0);
  }

  incrementarPlacarTempo() async {
    await _placarTempoSet.set(ServerValue.increment(1));
  }

  decrementarPlacarTempo() async {
    await _placarTempoSet.set(ServerValue.increment(-1));
  }

  resetTempo() async {
    await _placarTempoSet.set(0);
  }

  resetPlacar() async {
    await _placarEquipeA.set(0);
    await _placarEquipeB.set(0);
  }

  void dispose() {
    timer?.cancel();
    minutosController.dispose();
    segundosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Tempo Regressivo'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                _mostrarDialogoDeAjuda(context);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 5.0),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 300,
                ),
                child: TextField(
                  controller: textoExibidoController,
                  decoration: InputDecoration(
                      labelText: 'Texto para ser exibido no placar:'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  atualizarTextoExibido();
                },
                child: Text('Definir'),
              ),
              SizedBox(height: 10.0),
              Text(
                'Texto Exibido: $textoExibido',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Tempo: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    child: TextFormField(
                      controller: minutosController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Min',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    ':',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    child: TextFormField(
                      controller: segundosController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Seg',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: definirTempo,
                    child: Text(
                      'Definir',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: iniciarTemporizador,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: pararTemporizador,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.pause,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: definirTempo,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.refresh,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.5),
              Column(
                children: <Widget>[
                  Text(
                    'Tempo Restante:',
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      formatarTempo((minutos * 60) + segundos),
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Set/Falta(L)',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$placarSetEquipeA',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: incrementarPlacarSetEquipeA,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: decrementarPlacarSetEquipeA,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Column(
                          children: <Widget>[
                            InkWell(
                              onTap: resetSetA,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.refresh,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Column(
                      children: <Widget>[
                        Text(
                          'Tempo:',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$placarTempoSet',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        SizedBox(height: 5.0),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: incrementarPlacarTempo,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: decrementarPlacarTempo,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Column(
                          children: <Widget>[
                            InkWell(
                              onTap: resetTempo,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.refresh,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Column(
                      children: <Widget>[
                        Text(
                          'Set/Falta(V)',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$placarSetEquipeB',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: incrementarPlacarSetEquipeB,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: decrementarPlacarSetEquipeB,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Column(
                          children: <Widget>[
                            InkWell(
                              onTap: resetSetB,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.refresh,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Local',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$placarEquipeA',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: incrementarPlacarEquipeA,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: decrementarPlacarEquipeA,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.remove,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: <Widget>[
                      Text(
                        'Visitante',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$placarEquipeB',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: incrementarPlacarEquipeB,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: decrementarPlacarEquipeB,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.remove,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 22.5),
                    ElevatedButton(
                      onPressed: resetPlacar,
                      child: Text(
                        'Resetar Placar',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ]),
            ],
          ),
        ));
  }
}

void _mostrarDialogoDeAjuda(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Ajuda'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(
                'Digite o minutos e segundos desejados e depois selecione o botão definir para ser apresentado no visor.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.play_arrow),
                title: Text('Inicia o Crônometro definido.'),
              ),
              ListTile(
                leading: Icon(Icons.pause),
                title: Text('Para o Crônometro.'),
              ),
              ListTile(
                leading: Icon(Icons.refresh),
                title: Text(
                    'Volta os valores para 0, no caso do Cronometro volta para o tempo definido'),
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Aumenta o Valor em 1'),
              ),
              ListTile(
                leading: Icon(Icons.remove),
                title: Text('Diminui o Valor em 1'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'dart:async';

class PlacarVoleiTenisMesa extends StatefulWidget {
  @override
  _PlacarVoleiTenisMesaState createState() => _PlacarVoleiTenisMesaState();
}

class _PlacarVoleiTenisMesaState extends State<PlacarVoleiTenisMesa> {
  int placarEquipeA = 0;
  int placarEquipeB = 0;
  int placarSetEquipeA = 0;
  int placarSetEquipeB = 0;
  String nomeEquipeA = '';
  String nomeEquipeB = '';
  int placarTempoSet = 0;
  int minutos = 0;
  int segundos = 0;
  Timer? timer;
  TextEditingController equipeAController = TextEditingController();
  TextEditingController equipeBController = TextEditingController();

  void definirTempo() {
    setState(() {
      minutos = 00;
      segundos = 00;
    });

    int tempoTotalEMSegundos = (minutos * 60) + segundos;
    segundos = tempoTotalEMSegundos;
    pararTemporizador();
  }

  void iniciarTemporizador() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (segundos == 59) {
          minutos++;
          segundos = 0;
        } else {
          segundos++;
        }
      });
    });
  }

  void pararTemporizador() {
    setState(() {
      timer?.cancel();
    });
  }

  String formatarTempo(int segundos) {
    int minutos = segundos ~/ 60;
    int segundosRestantes = segundos % 60;
    String minutosStr = minutos.toString().padLeft(2, '0');
    String segundosStr = segundosRestantes.toString().padLeft(2, '0');
    return '$minutosStr:$segundosStr';
  }

  void incrementarPlacarEquipeA() {
    setState(() {
      placarEquipeA++;
    });
  }

  void decrementarPlacarEquipeA() {
    setState(() {
      placarEquipeA--;
    });
  }

  void incrementarPlacarEquipeB() {
    setState(() {
      placarEquipeB++;
    });
  }

  void decrementarPlacarEquipeB() {
    setState(() {
      placarEquipeB--;
    });
  }

  void incrementarPlacarSetEquipeA() {
    setState(() {
      placarSetEquipeA++;
    });
  }

  void decrementarPlacarSetEquipeA() {
    setState(() {
      placarSetEquipeA--;
    });
  }

  void resetSetA() {
    setState(() {
      placarSetEquipeA = 0;
    });
  }

  void incrementarPlacarSetEquipeB() {
    setState(() {
      placarSetEquipeB++;
    });
  }

  void decrementarPlacarSetEquipeB() {
    setState(() {
      placarSetEquipeB--;
    });
  }

  void resetSetB() {
    setState(() {
      placarSetEquipeB = 0;
    });
  }

  void incrementarPlacarTempo() {
    setState(() {
      placarTempoSet++;
    });
  }

  void decrementarPlacarTempo() {
    setState(() {
      placarTempoSet--;
    });
  }

  void resetTempo() {
    setState(() {
      placarTempoSet = 0;
    });
  }

  void resetPlacar() {
    setState(() {
      placarEquipeA = 0;
      placarEquipeB = 0;
    });
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Tempo Progressivo'),
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
                    'Tempo:',
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
                        '$nomeEquipeA',
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
                        '$nomeEquipeB',
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
              SizedBox(height: 5.0),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 300,
                ),
                child: TextField(
                  controller: equipeAController,
                  decoration: InputDecoration(labelText: 'Nome equipe A:'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    nomeEquipeA = equipeAController.text;
                  });
                },
                child: Text('Definir'),
              ),
              SizedBox(height: 5.0),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 300,
                ),
                child: TextField(
                  controller: equipeBController,
                  decoration: InputDecoration(labelText: 'Nome equipe B:'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    nomeEquipeB = equipeBController.text;
                  });
                },
                child: Text('Definir'),
              ),
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

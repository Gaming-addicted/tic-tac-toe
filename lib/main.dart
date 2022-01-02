import 'package:flutter/material.dart';

void main() => runApp(TicTacToe());

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool ohTurn = true; //first player print 0
  List<String> displayEx0h = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],

      // button for feedback
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.mail),
          color: Colors.amber[700],
          iconSize: 40,
        ),
        backgroundColor: Colors.red[900],
        elevation: 10.0,
      ),
      //want to add a feedback form and my details by clicking on this button but i already passed the dead line so, i will try to update this app ASAP.
      //ended here

      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Player O',
                            style: myTextStyle,
                          ),
                          Text(
                            ohScore.toString(),
                            style: myTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Player X',
                            style: myTextStyle,
                          ),
                          Text(
                            exScore.toString(),
                            style: myTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade700)),
                      child: Center(
                        child: Text(
                          displayEx0h[index],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayEx0h[index] == '') {
        displayEx0h[index] = 'O';
        filledBoxes += 1;
      } else if (!ohTurn && displayEx0h[index] == '') {
        displayEx0h[index] = 'X';
        filledBoxes += 1;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //checks row 1st
    if (displayEx0h[0] == displayEx0h[1] &&
        displayEx0h[0] == displayEx0h[2] &&
        displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    }

    //checks row 2nd
    if (displayEx0h[3] == displayEx0h[4] &&
        displayEx0h[3] == displayEx0h[5] &&
        displayEx0h[3] != '') {
      _showWinDialog(displayEx0h[3]);
    }

    //checks row 3rd
    if (displayEx0h[6] == displayEx0h[7] &&
        displayEx0h[6] == displayEx0h[8] &&
        displayEx0h[6] != '') {
      _showWinDialog(displayEx0h[6]);
    }

    //checks column 1st
    if (displayEx0h[0] == displayEx0h[3] &&
        displayEx0h[0] == displayEx0h[6] &&
        displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    }

    //checks column 2nd
    if (displayEx0h[1] == displayEx0h[4] &&
        displayEx0h[1] == displayEx0h[7] &&
        displayEx0h[1] != '') {
      _showWinDialog(displayEx0h[2]);
    }

    //checks column 3rd
    if (displayEx0h[2] == displayEx0h[5] &&
        displayEx0h[2] == displayEx0h[8] &&
        displayEx0h[2] != '') {
      _showWinDialog(displayEx0h[6]);
    }

    //checks diagonal
    if (displayEx0h[6] == displayEx0h[4] &&
        displayEx0h[6] == displayEx0h[2] &&
        displayEx0h[6] != '') {
      _showWinDialog(displayEx0h[6]);
    }

    //checks diagonal
    if (displayEx0h[0] == displayEx0h[4] &&
        displayEx0h[0] == displayEx0h[8] &&
        displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Draw'),
            actions: [
              FloatingActionButton.large(
                child: Text('Play Again!'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('WINNER! IS:' + winner),
            actions: [
              FloatingActionButton.large(
                child: Text('Play Again!'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    if (winner == 'O') {
      ohScore += 1;
    } else if (winner == 'X') {
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayEx0h[i] = '';
      }
    });
    filledBoxes = 0;
  }
}

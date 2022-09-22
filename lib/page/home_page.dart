import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_num_mobile/game_guess.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //var _input = '';
  final _input = TextEditingController(); //อ่านค่าที่ใส่มาในช่องว่าง
  final _game = Game();
  int count = 0;

  // state variable
  var _feedbackText = '';

  //var _showTestButton = false;

  void handleClickGuess() {
    /*
    setState(() {
      _showTestButton = !_showTestButton;
    });*/

    var guess = int.tryParse(_input.text);
      if (guess == null) {
        setState(() {
          _feedbackText = 'ไม่ถูกต้อง กรุณาใส่เป็นตัวเลข';
        });
      } else {
        var result = _game.doGuess(guess);
        if (result == Result.tooHigh) {
          count++;
          _handleClickButton('x');
          setState(() {
            _feedbackText = '$guess : มากเกินไป';
          });
        } else if (result == Result.tooLow) {
          count++;
          _handleClickButton('x');
          setState(() {
            _feedbackText = '$guess : น้อยเกินไป';
          });
        } else {
          count++;
          setState(() {
            _feedbackText = '$guess : ถูกต้อง (ทาย $count ครั้ง)';
          });
        }
      }
  }

  void _handleClickButton(var num) {
    if (_input.text.length < 3) {
      setState(() {
          _input.text = _input.text + num.toString();
      });
    }else{
      _input.text == null;
    }

    setState(() {
      if (num == -1) {
        _input.text = _input.text.substring(0, _input.text.length - 1);
      } else if (num == 'x') {
        _input.text = _input.text.substring(0, _input.text.length - _input.text.length);
      }
    });
  }

  Widget _buildNumberButton(var num) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _handleClickButton(num);
        },
        customBorder: CircleBorder(),
        child: Container(
          width: 80.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xFFCCCCCC),
              width: 1.0,
            ),
          ),
          /*
          child: Text(
            num.toString(),
            style: GoogleFonts.firaCode(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          */
          child: num == -1
              ? Icon(Icons.backspace_outlined)
              : Text(
                  num.toString(),
                  style: GoogleFonts.firaCode(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          /*
          child: num == -2
              ? Icon(Icons.close_outlined)
              : Text(
                num.toString(),
                style: GoogleFonts.firaCode(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
            ),
          ),
           */
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          decoration: BoxDecoration(
            //BoxDecoration กำหนดรูปทรงของ box
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(20.0), //ความมนของมุม box
            boxShadow: const [
              //เงาของ box
              BoxShadow(color: Colors.purple, blurRadius: 5)
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/guess_logo.png',
                    width: 80.0,
                  ),
                  Column(
                    children: [
                      Text(
                        'GUESS',
                        style: GoogleFonts.roboto(
                          fontSize: 40.0,
                          color: Colors.purple[200],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'THE NUMBER',
                        style: GoogleFonts.roboto(
                          fontSize: 20.0,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              TextField(
                controller: _input,       //เก็บค่า input
                style: GoogleFonts.roboto(
                  fontSize: 50.0,
                ),
              ),
              Text(
                'ทายเลข 1 ถึง 100',
                style: GoogleFonts.roboto(fontSize: 20),
              ),
              Text(
                _feedbackText,
                style: GoogleFonts.roboto(fontSize: 20),
              ),
              Column(
                children: [
                  for (var row in [
                    [1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9],
                    ['x', 0, -1],
                  ])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [for (var i in row) _buildNumberButton(i)],
                    ),
                ],
              ),
              ElevatedButton(
                onPressed: handleClickGuess,
                child: const Text('GUESS'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

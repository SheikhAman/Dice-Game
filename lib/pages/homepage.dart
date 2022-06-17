import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String appBarTitle;
 const HomePage({required this.appBarTitle,Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> diceList = const [
    'images/dice1.png',
    'images/dice2.png',
    'images/dice3.png',
    'images/dice4.png',
    'images/dice5.png',
    'images/dice6.png',
  ];

  int _firstDindex = 0, _secondDindex = 0 , _diceSum = 0, point= 0;
  final Random _random = Random.secure();
  bool _isGameStarted = false;
  bool _isGameEnded = false;
  String gameMsg  = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.red,
      appBar: AppBar(title: Text(widget.appBarTitle)
      ,centerTitle: true,
         backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child:
          _isGameStarted ? gamePage() : startGame(),
          ),
        ),

    );
  }
  Widget gamePage(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

         Expanded(child: Padding(padding: const EdgeInsets.all(8),
           child: Image.asset(diceList[_firstDindex])
           ,),),

          Expanded(child: Padding(padding: const EdgeInsets.all(8),
          child: Image.asset(diceList[_secondDindex],),
          )),
        ],
      ) ,
        ElevatedButton(
            onPressed: _isGameEnded ? null :  _rollDice ,
            child:  const Text('Roll'),
          style: ElevatedButton.styleFrom(primary: const Color(0xffA149FA),
          onPrimary: const Color(0xffF7EC09),
          ),
        ),
        Text('Dice sum : $_diceSum',
        style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
        ),
      if(point>0)Text('Your Point: $point',style: const TextStyle(color:Color(0xffF5EEDC),
      fontSize: 18, fontWeight: FontWeight.bold
      ),),
      if(point>0 && !_isGameEnded)const Text('Keep rolling until you match your point',
      style: TextStyle(color: Color(0xffFF4949),
          backgroundColor: Color(0xff541690),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      ),
      Text(gameMsg,style: const TextStyle(fontSize: 22,color: Color(0xffFFC300),fontWeight: FontWeight.bold),),
      if(_isGameEnded)  ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Color(0xff5463FF)),
            onPressed: _reset ,
            child: const Text('Play Again',style: TextStyle(color: Color(0xffECECEC))),
        ),

      ],
    );

  }

  void _rollDice() {
    setState(() {
      _firstDindex = _random.nextInt(6); //5
      _secondDindex = _random.nextInt(6); //5
      _diceSum = _firstDindex + _secondDindex + 2;
  if(point>0){
    secondRole();
  }else{
    firstRole();
      }
    }
    );

  }

 Widget  startGame() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
              child: Image.asset('images/diceBg.png', fit: BoxFit.cover)),
          Expanded(
            flex: 1,
            child: Text('''
*** Rules           
* You can roll two dice and each dice has six
  faces.
* These faces contain 1,2,3,4,5 and 6 spots.
* After the dice have come to rest, the sum of the 
  spots on the two upward faces is calculated.
* If the sum is 7 or 11 on the first throw, the 
  player wins.
* If the sum is 2,3 or 12 on the first throw, you
  lose.
* If the sum is 4,5,6,8,9 or 10 on the first throw,
  then that sum  becomes the player's "points".
* To win, you must continue rolling the dice until 
  your dice-sum equal to your points. If dice-sum 
  gets equal to 7 you lose.
''', style: TextStyle(color: Colors.white,fontSize: 14,letterSpacing: 0.3),
            ),
          ),
          ElevatedButton(
              onPressed: (){
                setState((){
                  _isGameStarted = true;
                });
              },
               style: ElevatedButton.styleFrom(primary: const Color(0xff99154E),
               onPrimary:const Color(0xffFFBBCC),
               ),
            child: const Text('Start Game',style: TextStyle(fontSize: 15),),
          ),
        ],
      ),
    );
 }

 void _reset(){
   setState(() {

     _firstDindex = 0;
     _secondDindex = 0 ;
     _diceSum = 0;
     point= 0;
      _isGameStarted = false;
      _isGameEnded = false;
      gameMsg  = '';

   });
 }

  void secondRole() {
   if(_diceSum == point){
     gameMsg = 'You Win';
     _isGameEnded = true;
   }else if(_diceSum == 7){
     gameMsg = 'You Lose';
     _isGameEnded = true;
   }

  }

  void firstRole() {
    switch (_diceSum) {
      case 7:
      case 11:
        gameMsg = 'You Win!!!';
        _isGameEnded = true;
        break;
      case 2:
      case 3:
      case 12:
        gameMsg = 'You Lost';
        _isGameEnded = true;
        break;
      default :
        point = _diceSum;
        break;
    }
  }



}


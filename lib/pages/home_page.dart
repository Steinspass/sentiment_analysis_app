import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sentiment_analysis/api/service_api.dart';
import 'package:sentiment_analysis/model/sent_analysis_model.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  bool _loading = true;
  final TextEditingController _textEditingController = TextEditingController();

  APIService apiService = APIService();
  Future<SentAnalysisModel> analysis;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ 
              Color(0xFFA6C46E),
              Color(0xFF5FD3B0),  
              Color(0xFFB499FF),
              Color(0xFFFF99C5)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _buildColumnContainer(context),
      ),
    );
  }

  Widget _buildColumnContainer(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          height: MediaQuery.of(context).size.height ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.5,
              ),
              Text(
                'Sentiment Analysis',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF8C6EC4),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'with NLP Algorithm',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8C6EC4),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              _boxContainer(),
              
            ],
          ),
        ),
    );
  }

  Widget _boxContainer() {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Color(0xFF8C6EC4),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 6,
            blurRadius: 8
          )
        ]
      ),
      child: _containerTextEdit(),
    );
  }

  Widget _containerTextEdit() {
    return Column(
      children: [
        Center(
          child: _loading ? _containerTextField() : Container(),
        ),
        SizedBox(
          height: 40.0,
        ),
        _buttonSend(),
        SizedBox(
          height: 20.0,
        ),
        _textPrediction()
      ],
    );
  }

  Widget _containerTextField() {
    return TextField(
      controller: _textEditingController,
      style: TextStyle(
        color: Colors.blueGrey[50],
        fontWeight: FontWeight.w500,
        fontSize: 18.0
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.blueGrey[100],
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
        ),
        labelText: 'Add a descriptive text:',
        enabledBorder: UnderlineInputBorder(      
          borderSide: BorderSide(color: Color(0xFF5FD3B0)),   
        ),  
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF5FD3B0)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF5FD3B0)),
        ), 
      ),
      cursorColor: Color(0xFF5FD3B0),
      
    );
  }

  Widget _buttonSend() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          GestureDetector(
            onTap: ()  {
              
              setState(() {
                print(_textEditingController.text);
              
                analysis =  apiService
                  .post(query: {'text' : _textEditingController.text });
              });

            },
            child: Container(
              width: MediaQuery.of(context).size.width - 200,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16
              ),
              decoration: BoxDecoration(
                color: Color(0xFF5FD3B0),
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 1,
                    blurRadius: 2
                  )
                ]
              ),
              child: Text(
                'Find Emotions',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF8C6EC4)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textPrediction() {
    return FutureBuilder<SentAnalysisModel>(
      future: analysis,
      builder: (context, snapshot){
        
        if(snapshot.hasData){
          return Text(
            'Prediction is ' + snapshot.data.emotions,
            style: TextStyle(
              fontSize: 22.0,
              fontStyle: FontStyle.italic,
              color: Color(0xFF5FD3B0),
              fontWeight: FontWeight.bold
            ),
          );

        }else if(snapshot.hasError){

          return Text(
            '${snapshot.error}',
            style: TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
              color: Color(0xFFFF99C5),
              fontWeight: FontWeight.bold
            ),
          );

        }

        return Container();
        
      }
    );
  }
}
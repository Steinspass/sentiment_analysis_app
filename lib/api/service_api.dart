
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sentiment_analysis/model/sent_analysis_model.dart';
import 'package:http/http.dart' as http;

class APIService{
  static const String _apiKey = 'e2d59ff6afmsh09dec7e83d36e20p15b3f1jsnb80e880999f8';
  static const String _baseUrl = 'https://twinword-emotion-analysis-v1.p.rapidapi.com/analyze/';
  static const Map<String, String> _header = {
    "content-type"    : "application/x-www-form-urlencoded",
    "x-rapidapi-host" : "twinword-emotion-analysis-v1.p.rapidapi.com",
    "x-rapidapi-key"  : _apiKey,
    "useQueryString"  : 'true'
  };


  Future<SentAnalysisModel> post({
    @required Map<String, String> query
  }) async {
    
    final response = await http.post(_baseUrl, headers: _header, body: query);

    print(response.statusCode);

    if(response.statusCode == 200){
      print('success' + response.body);

      return SentAnalysisModel.fromJson(json.decode(response.body));

    }else{
      throw Exception('Failed to load json data');
    }
  }

}

class SentAnalysisModel{

  final String emotions;

  SentAnalysisModel({this.emotions});

  factory SentAnalysisModel.fromJson(Map<String, dynamic> json){

    return SentAnalysisModel(emotions: json['emotions_detected'][0]);
    
  }
}
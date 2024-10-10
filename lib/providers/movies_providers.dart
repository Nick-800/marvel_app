import 'dart:convert';

import 'package:marvel_app/models/movies_model.dart';
import 'package:marvel_app/providers/base_provider.dart';
// import 'package:marvel_app/services/api.dart';

class MoviesProviders extends BaseProvider {
  List<MoviesModel> movies = [];


  fetchMovies() async {

    setIsLoading(true);
    var data = await api.get("https://mcuapi.herokuapp.com/api/v1/movies");

    if (data.statusCode == 200) {
      setIsFailed(false);
      var decodeData = jsonDecode(data.body)["data"];
      movies= List<MoviesModel>.from(decodeData.map((e)=>MoviesModel.fromJson(e)));
    }
    else{
      setIsFailed(true);
    }

    setIsLoading(false);
  }
}

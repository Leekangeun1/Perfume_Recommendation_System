import 'dart:async';
import 'package:flutter/material.dart';

class SearchData with ChangeNotifier{
  String brandData ="";
  String perfumeData = "";
  String brandID = "";
  String category = "";
  String season = "";
  String sex = "";
  String perfumeDetail = "";
  int numOfPerfume = 0;

  setBrandData(data){
    brandData = data;
    notifyListeners();
  }

  setBrandID(data){
    brandID = data;
    notifyListeners();
  }

  setPerfumeData(data){
    perfumeData = data;
    notifyListeners();
  }

  setCategory(data){
    category = data;
    notifyListeners();
  }

  setSeason(data){
    season = data;
    notifyListeners();
  }

  setSex(data){
    sex = data;
    notifyListeners();
  }

  setNumOfPerfume(data){
    numOfPerfume = data;
    notifyListeners();
  }

  setPerfumeDetail(data){
    perfumeDetail = data;
    notifyListeners();
  }
}


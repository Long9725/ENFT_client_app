import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  List<String> _addressList;

  LocationProvider(this._addressList);

  getAddressList() => _addressList;

  setAddressList(List<String> addressList) {
    _addressList = addressList;
    notifyListeners();
  }
}

import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitai_coach/core/utils/loaders/loaders.dart';

class NetworkManager extends GetxController {
  static NetworkManager instance = Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectivityStatus =
      ConnectivityResult.none.obs;

  /// Initialize the network manager and set up the continually check the connection status
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  /// Update the connection status based on the result of the connectivity check
  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    _connectivityStatus.value = result;
    if (_connectivityStatus.value == ConnectivityResult.none) {
      TLoaders.warningSnackBar(
        title: 'No Internet',
        message: 'Please check your internet connection',
      );
    } else {
      TLoaders.successSnackBar(
        title: 'Connected',
        message: 'You are now connected to the internet',
      );
    }
  }

  ///update the connection status based in connectivity and show a relevant popup for no internet connection.
  Future<void> updateMyConnectionStatus() async {
    try {
      final results = await _connectivity.checkConnectivity();
      final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
      _connectivityStatus.value = result;
      if (_connectivityStatus.value == ConnectivityResult.none) {
        TLoaders.warningSnackBar(
          title: 'No Internet',
          message: 'Please check your internet connection',
        );
      } else {
        TLoaders.successSnackBar(
          title: 'Connected',
          message: 'You are now connected to the internet',
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Something went wrong');
    }
  }

  ///check the internet connection status
  Future<bool> isConnected() async {
    try {
      final results = await _connectivity.checkConnectivity();
      final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
      if (result == ConnectivityResult.none) {
        TLoaders.warningSnackBar(
          title: 'No Internet',
          message: 'Please check your internet connection',
        );
        return false;
      }
      TLoaders.successSnackBar(
        title: 'Connected',
        message: 'You are now connected to the internet',
      );
      return true;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Something went wrong');
      return false;
    }
  }
  //return true if connected to the internet and false if not connected to the internet
  

  ///Dispose the network manager and cancel the subscription
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}


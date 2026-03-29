import 'package:flutter/foundation.dart';

import '../../../../core/models/portfolio_bundle.dart';
import '../../../../core/services/api_service.dart';

enum PortfolioStatus { loading, ready, error }

class PortfolioController extends ChangeNotifier {
  PortfolioController({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  final ApiService _apiService;

  PortfolioStatus _status = PortfolioStatus.loading;
  PortfolioStatus get status => _status;

  PortfolioBundle? _bundle;
  PortfolioBundle? get bundle => _bundle;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> load() async {
    _status = PortfolioStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _bundle = await _apiService.fetchPortfolio();
      _status = PortfolioStatus.ready;
    } catch (_) {
      _status = PortfolioStatus.error;
      _errorMessage =
          'Failed to load portfolio data. Check backend availability and try again.';
    }

    notifyListeners();
  }
}

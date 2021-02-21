import 'package:rxdart/rxdart.dart';
import 'package:unsplash_app/data/api_data.dart';
import 'package:unsplash_app/models/user_profile_model.dart';

class HomeDrawerBloc {
  final ApiData _apiData;

  HomeDrawerBloc({
    ApiData apiData,
  }) : _apiData = apiData ?? ApiData();

  final data = BehaviorSubject<UserProfile>();

  final isLoading = BehaviorSubject<bool>.seeded(false);

  getUserProfile() async {
    isLoading.add(true);
    try {
      UserProfile response = await _apiData.getMe();
      data.add(response);
    } catch (e) {
      data.addError(e);
    } finally {
      isLoading.add(false);
    }
  }

  void dispose() {
    data.close();
    isLoading.close();
  }
}

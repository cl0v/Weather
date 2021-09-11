import 'models.dart';
import 'repository.dart';
import 'utils/simple_bloc.dart';

class CityBloc extends SimpleBloc<List<CityInfo>> {
  WeatherRepository repository = WeatherRepository();

  var _cachedList = <CityInfo>[];

  void init() async {
    _cachedList
      ..add(await repository.getWeather('Curitiba, BR'))
      ..add(await repository.getWeather('Sydney, AU'))
      ..add(await repository.getWeather('London, GB'))
      ..add(await repository.getWeather('London, CA'));
    add(_cachedList);
  }

  addCity(String name) async {
    _cachedList..add(await repository.getWeather(name));
    add(_cachedList);
  }

  // filterCity(String name) {
  //   final filteredCities = _cachedList.map((e) {
  //     if (e.name.toLowerCase().contains(name.toLowerCase())) return e;
  //   }).toList();
  // }
}

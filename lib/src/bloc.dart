import 'models.dart';
import 'repository.dart';
import 'utils/simple_bloc.dart';

class CityBloc extends SimpleBloc<List<CityInfo>> {
  CityBloc({
    this.repository = const WeatherRepository(),
  });
  final IWeatherRepository repository;

  var _cachedList = <CityInfo>[];

  void init() async {
    try {
      _cachedList
        ..add(await repository.getWeather('Curitiba, BR'))
        ..add(await repository.getWeather('Sydney, AU'))
        ..add(await repository.getWeather('London, GB'))
        ..add(await repository.getWeather('London, CA'));
      add(_cachedList);
    } catch (e) {
      addError('Ocorreu um Error');
    }
  }

  addCity(String name) async {
    try {
      _cachedList..add(await repository.getWeather(name));
      add(_cachedList);
    } catch (e) {
      _cachedList = [];
      addError('Você digitou errado o nome da cidade');
    }
  }

  filterCity(String name) {
    return add(_cachedList
        .where((city) => city.name.toLowerCase().contains(name.toLowerCase()))
        .toList());
  }
}

import 'models.dart';
import 'repository.dart';
import 'utils/simple_bloc.dart';

class CityBloc extends SimpleBloc<List<CityInfo>> {
  CityBloc({
    this.repository = const WeatherRepository(),
  });
  final IWeatherRepository repository;

  var _cachedList = <CityInfo>[];

  void init([restart = false]) async {
    try {
     if(!restart) _cachedList
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
    } on BadRequestException catch (e) {
      addError('${e.message}, tente novamente');
    } catch (e) {
      addError('Ocorreu um erro inexperado');
    }
  }

  filterCity(String name) {
    return add(_cachedList
        .where((city) => city.name.toLowerCase().contains(name.toLowerCase()))
        .toList());
  }
}

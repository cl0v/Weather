import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather/src/bloc.dart';
import 'utils/navigator.dart';

import 'models.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CityBloc bloc = CityBloc();

  TextEditingController cityNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    bloc.init();
  }

  onAddCityPressed() {
    bloc.addCity(cityNameController.text);
    cityNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<List<CityInfo>>(
            stream: bloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Timer(Duration(seconds: 2), () {
                  bloc.init();
                });
                return Text('${snapshot.error}, aguarde 2 segundos...');
              }
              if (!snapshot.hasData || snapshot.data == null)
                return Center(
                  child: CircularProgressIndicator(),
                );
              final list = snapshot.data ?? [];
              return ListView(children: [
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextField(
                        onChanged: bloc.filterCity,
                        controller: cityNameController,
                      ),
                    ),
                    IconButton(
                      onPressed: onAddCityPressed,
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                ...list
                    .map((city) => Card(
                      child: ListTile(
                            title: Text('${city.name}, ${city.country}'),
                            subtitle: Text('${city.temperature}°C'),
                            onTap: () => push(
                              context,
                              CityDetails(city: city),
                            ),
                          ),
                    ))
                    .toList(),
              ]);
            }),
      ),
    );
  }
}

class CityDetails extends StatelessWidget {
  const CityDetails({Key? key, required this.city}) : super(key: key);
  final CityInfo city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => pop(context),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              '${city.temperature.toStringAsFixed(1)}°C',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(city.name),
          ],
        ),
      ),
    );
  }
}

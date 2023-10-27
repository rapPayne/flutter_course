import 'package:daam/ShowingTimes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';
import 'state/Film.dart';

class FilmBrief extends ConsumerWidget {
  final Film film;
  const FilmBrief({required this.film, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime _selectedDate = ref.watch(selectedDateProvider);
    return GestureDetector(
      onTap: () {
        ref.read(selectedFilmProvider.notifier).set(film);
        Navigator.pushNamed(context, '/film');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Image.network("http://localhost:3008${film.poster_path}",
                height: 100),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(children: [
                  Text(
                    film.title ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(
                      film.tagline ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ShowingTimes(
                    film: film,
                    selected_date: _selectedDate,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

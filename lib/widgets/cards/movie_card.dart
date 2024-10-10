import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:marvel_app/models/movies_model.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.moviesModel});
  final MoviesModel moviesModel;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GridTile(
          footer: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.transparent])),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Duration(minutes: moviesModel.duration)
                        .toString()
                        .substring(0, 4),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    maxFontSize: 18,
                    minFontSize: 10,
                    maxLines: 2,
                    moviesModel.title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          child: Image.network(
            moviesModel.coverUrl,
            loadingBuilder: (context, child, loadingProgress) {
              return loadingProgress != null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : child;
            },
            fit: BoxFit.cover,
          )),
    );
  }
}

class MovieCardStack extends StatelessWidget {
  const MovieCardStack({super.key, required this.moviesModel});
  final MoviesModel moviesModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(
              moviesModel.coverUrl,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress != null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : child;
              },
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Duration(minutes: moviesModel.duration)
                            .toString()
                            .substring(0, 4),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AutoSizeText(
                        moviesModel.title,
                        maxLines: 2,
                        maxFontSize: 18,
                        minFontSize: 10,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/constants.dart';
import 'package:marvel_app/helpers/functions_helper.dart';
import 'package:marvel_app/helpers/get_size.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:marvel_app/providers/movies_providers.dart';
import 'package:marvel_app/screens/auth_screens/profile_screen.dart';
import 'package:marvel_app/widgets/cards/movie_card.dart';
import 'package:marvel_app/widgets/icons/custome_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<MoviesProviders>(context, listen: false).fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProviders>(builder: (context, movieConsumer, _) {
      return Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .logout()
                          .then((onValue) {
                        if (onValue) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScreenRouter()),
                            (route) => false,
                          );
                        } else {
                          printDebug("FAILED");
                        }
                      });
                    },
                    child: const Text("LogOut"))
              ],
            ),
          ),
        ),
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: Size.zero,
              child: Divider(
                color: mainColor.withOpacity(0.1),
              )),
          title: Image.asset(
            "assets/marvel_appLogo.png",
            width: getSize(context).width * 0.2,
          ),
          centerTitle: true,
          actions: [
            CustomIconButton(
                asset: "assets/icons/FavoriteButton.png", onTap: () {}),
            const SizedBox(width: 8),
            CustomIconButton(
                asset: "assets/icons/InboxIcon.png",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfileScreen()));
                }),
          ],
        ),
        body: AnimatedSwitcher(
            duration: animationDuration,
            child: movieConsumer.isFaild
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_outlined,
                        size: getSize(context).width * 0.5,
                        color: mainColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Something Went wrong")
                    ],
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: movieConsumer.isLoading
                        ? 6
                        : movieConsumer.movies.length,
                    itemBuilder: (context, index) => movieConsumer.isLoading
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Shimmer.fromColors(
                                baseColor: Colors.black12,
                                highlightColor: Colors.white38,
                                child: Container(
                                  color: Colors.white,
                                  height: double.infinity,
                                  width: double.infinity,
                                )),
                          )
                        : MovieCardStack(
                            moviesModel: movieConsumer.movies[index]))),
      );
    });
  }
}

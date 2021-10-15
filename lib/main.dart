import 'package:dro_hometask/presentation/screens/categorypage/bloc/category_bloc.dart';
import 'package:dro_hometask/presentation/screens/homepage/home.dart';
import 'package:dro_hometask/presentation/screens/pharmacy_screen/bloc/phamarcy_bloc.dart';
import 'package:dro_hometask/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common/size_config.dart';
import 'presentation/screens/cartpage/cartBloc/cartbloc_bloc.dart';

void main() async {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CartblocBloc>(create: (_) => CartblocBloc()),
    BlocProvider<PhamarcyBloc>(create: (_) => PhamarcyBloc()),
    BlocProvider<CategoryBloc>(create: (_) => CategoryBloc())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DRO Med',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 24),
        backgroundColor: Colors.white,
        accentColor: XColors.accentColor,
        textTheme: const TextTheme(
            headline1: TextStyle(
              fontFamily: "Proxima",
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            headline2: TextStyle(
              fontFamily: "Proxima",
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            bodyText1: TextStyle(
              fontFamily: "Proxima",
              fontSize: 15,
              color: Colors.black,
            ),
            bodyText2: TextStyle(
              fontFamily: "Proxima",
              fontSize: 12,
              color: Colors.black,
            ),
            headline3: TextStyle(
              fontFamily: "Proxima",
              fontSize: 20,
              color: Colors.black,
            )),
      ),
      home: Material(
        child: Builder(builder: (BuildContext context) {
          final Size size = MediaQuery.of(context).size;
          SizeConfig.init(
            context,
            width: size.width,
            height: size.height,
            allowFontScaling: true,
          );

          return HomeScreen();
        }),
      ),
    );
  }
}

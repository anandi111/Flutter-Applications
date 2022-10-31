import 'package:astrology_app/helpers/zodic_api_helper.dart';
import 'package:astrology_app/modals/zodic.dart';
import 'package:astrology_app/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/lists.dart';

class AstroDetailPage extends StatefulWidget {
  AstroDetailPage({Key? key, required this.index}) : super(key: key);
  int index;

  @override
  State<AstroDetailPage> createState() => _AstroDetailPageState();
}

class _AstroDetailPageState extends State<AstroDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).focusColor,
        title: Text("Astrology App"),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<Themeprovider>(context, listen: false)
                    .changeTheme();
              },
              icon: const Icon(
                Icons.light_mode,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          ShaderMask(
            shaderCallback: (b) {
              return const LinearGradient(colors: [
                Colors.lightBlueAccent,
                Colors.indigo,
                Colors.deepPurple
              ]).createShader(b);
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 5, color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(zodicList[widget.index].photoString,
                          color: Colors.white, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              color: Color(0xff252a41),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (b) {
                        return const LinearGradient(colors: [
                          Colors.lightBlueAccent,
                          Colors.indigo,
                          Colors.deepPurple
                        ]).createShader(b);
                      },
                      child: Text(zodicList[widget.index].name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: ZodicAPIHelper.zodicAPIHelper
                          .fetchingUserData(sign: zodicList[widget.index].name),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text(
                              "Ooooops!\nNo internet connection found\nCheck your connection",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600));
                        } else if (snapshot.hasData) {
                          Zodic? data = snapshot.data as Zodic?;

                          return Column(
                            children: [
                              Text(data!.date,
                                  style: const TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                data.discription,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          );
                        }
                        return const CircularProgressIndicator(
                            color: Colors.deepPurpleAccent);
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

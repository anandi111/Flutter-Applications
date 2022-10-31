import 'package:astrology_app/providers/theme_provider.dart';
import 'package:astrology_app/utils/lists.dart';
import 'package:astrology_app/views/datail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AstroHomePage extends StatefulWidget {
  const AstroHomePage({Key? key}) : super(key: key);

  @override
  State<AstroHomePage> createState() => _AstroHomePageState();
}

class _AstroHomePageState extends State<AstroHomePage> {
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
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: DragTarget(onAccept: (int data) {
              print("aceepeted.......");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AstroDetailPage(index: data),
                  ));
            }, builder: (context, accepted, rejected) {
              return Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 5, color: Colors.deepPurpleAccent)),
                child: Center(
                    child: Text(
                  "Drag to\nSelect\nSign",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).splashColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )),
              );
            }),
          ),
          const Spacer(),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: zodicList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (200 / 300),
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Draggable(
                              data: i,
                              feedback: ShaderMask(
                                shaderCallback: (b) {
                                  return const LinearGradient(colors: [
                                    Colors.lightBlueAccent,
                                    Colors.indigo,
                                    Colors.deepPurple
                                  ]).createShader(b);
                                },
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  child: Image.asset(zodicList[i].photoString,
                                      color: Colors.white, fit: BoxFit.contain),
                                ),
                              ),
                              child: ShaderMask(
                                shaderCallback: (b) {
                                  return const LinearGradient(colors: [
                                    Colors.lightBlueAccent,
                                    Colors.indigo,
                                    Colors.deepPurple
                                  ]).createShader(b);
                                },
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  child: Image.asset(zodicList[i].photoString,
                                      color: Colors.white, fit: BoxFit.contain),
                                ),
                              ),
                            ),
                            Text(zodicList[i].name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

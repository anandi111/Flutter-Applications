import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper_1/globals/globals.dart';
import 'package:sky_scrapper_1/globals/globals1.dart';
import 'package:sky_scrapper_1/helpers/carrdatahelper.dart';
import 'package:sky_scrapper_1/models/carrdata.dart';
import 'package:sky_scrapper_1/providers/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int val1 = 139;
  int val2 = 55;
  int temp = 1;
  double amt = 1;
  String error = "No";
  TextEditingController amtHaveController = TextEditingController();

  initState() {
    super.initState();
    amtHaveController.text = amt.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Currency Converter",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme();
              },
              icon: const Icon(Icons.light_mode_outlined))
        ],
        backgroundColor: Color(0xff01677e),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text(
                "From",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xff484858),
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(10),
                          isExpanded: true,
                          value: val1,
                          items: allCurrencies
                              .map((e) => DropdownMenuItem(
                                    value: allCurrencies.indexOf(e),
                                    child: Text(
                                      e,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (int? value) {
                            setState(() {
                              val1 = value!;
                            });
                          },
                          dropdownColor: Colors.grey,
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.blue,
                          icon: const Icon(Icons.pin_drop_outlined),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xff484858),
                          )),
                      child: Center(
                        child: TextField(
                          onSubmitted: (val) {
                            setState(() {
                              amt = double.parse(val);
                            });
                          },
                          controller: amtHaveController,
                          style: Theme.of(context).textTheme.bodySmall,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorText: (amtHaveController.text.contains(","))
                                  ? "Enter valid amount."
                                  : null),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "To",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xff484858),
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(10),
                          isExpanded: true,
                          value: val2,
                          items: allCurrencies
                              .map((e) => DropdownMenuItem(
                                    value: allCurrencies.indexOf(e),
                                    child: Text(
                                      e,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (int? value) {
                            setState(() {
                              val2 = value!;
                            });
                          },
                          dropdownColor: Colors.grey,
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.blue,
                          icon: const Icon(Icons.pin_drop_outlined),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              FutureBuilder(
                future: CarrAPIHelper.currAPIHelper.fetchingUserData(
                    From: currVal[val1],
                    To: currVal[val2],
                    amount: amt,
                    error: error),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "assets/no-internet.png",
                              color: Color(0xff01677e),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Whoops!",
                            style: Theme.of(context).textTheme.bodySmall!.merge(
                                const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              "slow or no internet connection\ncheck your connection or try again",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .merge(const TextStyle(
                                      fontSize: 16, color: Colors.grey))),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    CurrData? data = snapshot.data as CurrData?;

                    if (data!.error == "Failed to convert currency.") {
                      return Center(
                        child: Column(
                          children: [
                            Container(
                              height: 350,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                "assets/LiKrekyaT-removebg-preview.png",
                                color: Color(0xff01677e),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Oh no!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .merge(const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "something went wrong\nplease enter correct amount.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .merge(const TextStyle(
                                        fontSize: 16, color: Colors.grey))),
                          ],
                        ),
                      );
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Result:",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 150,
                          width: 350,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              "${amt} ${currVal[val1]}",
                              style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "=",
                          style: Theme.of(context).textTheme.bodySmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 150,
                          width: 350,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "${data!.data} ${currVal[val2]}",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          data.error,
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Edr(),
    ClockScreen(),
    CalendarScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Uy",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: "Soat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Kalendar",
          ),
        ],
      ),
    );
  }
}

class Edr extends StatefulWidget {
  const Edr({super.key});

  @override
  State<Edr> createState() => _EdrState();
}

class _EdrState extends State<Edr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Background Container
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 17, 134, 87),
                image: DecorationImage(
                  image: AssetImage("rasm/mosque.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 110),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Assalamu alaykum",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("rasm/boy.png"),
                            fit: BoxFit.cover,
                          ),
                          color: const Color.fromARGB(255, 220, 178, 119),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Positioned card
            Positioned(
              top: 130,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 223, 230, 235),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later,
                              color: const Color.fromARGB(255, 213, 158, 18),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Duhr time",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: const Color.fromARGB(255, 213, 158, 18),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Uzbekistan",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            '12:08',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                        ),
                        Text(
                          "Kokand",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("rasm/mosq.png")),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: const Color.fromARGB(255, 33, 76, 34),
                              )),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("rasm/quran.png")),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: const Color.fromARGB(255, 33, 76, 34),
                              )),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("rasm/tasbih.png")),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: const Color.fromARGB(255, 33, 76, 34),
                              )),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("rasm/kaba.png")),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: const Color.fromARGB(255, 33, 76, 34),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Mosque"),
                        Text("Qur`an"),
                        Text("Tasbeeh"),
                        Text("Kaaba")
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 380,
              left: 35,
              child: Container(
                width: 430,
                height: 80,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 17, 134, 87),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
            ),
            Positioned(
              top: 390,
              left: 50,
              child: Container(
                child: Center(
                  child: Container(
                      width: 40,
                      height: 40,
                      child: Image(
                        image: AssetImage("rasm/islam.png"),
                        fit: BoxFit.cover,
                      )),
                ),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(15))),
              ),
            ),
            Positioned(
                top: 399,
                left: 140,
                child: Text(
                  "The last surah you read.",
                  style: TextStyle(color: Colors.white),
                )),
            Positioned(
                top: 420,
                left: 140,
                child: Text(
                  "No surah read yet",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                )),
            Positioned(
                top: 400,
                left: 410,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                  size: 40,
                )),
            Positioned(
              top: 470,
              left: 40,
              child: Text(
                "MAKKAH LIVE",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ),
            Positioned(
              top: 499,
              left: 40,
              child: Container(
                width: 400,
                height: 150,
                child: Center(
                  child: Container(
                    width: 350,
                    height: 120,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("rasm/makka.png"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Clock Screen
class ClockScreen extends StatelessWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Soat Sahifasi",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Calendar Screen
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Kalendar Sahifasi",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(color: Colors.deepPurple),
      ),
      home: const AnimatedDollarScreen(),
    );
  }
}

class AnimatedDollarScreen extends StatefulWidget {
  const AnimatedDollarScreen({super.key});

  @override
  _AnimatedDollarScreenState createState() => _AnimatedDollarScreenState();
}

class _AnimatedDollarScreenState extends State<AnimatedDollarScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.2).animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
            ),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [Colors.green, Colors.lightGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Text(
                '\$',
                style: TextStyle(
                  fontSize: 150,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login', _loginController.text);
    prefs.setString('password', _passwordController.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NextScreen()),
    );
  }

  Widget _buildGlassContainer(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        child: child,
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        border: InputBorder.none,
        suffixIcon: suffixIcon,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Center(child: Text("Ro'yhatdan O'tish")),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const SizedBox(height: 20),
              _buildGlassContainer(
                _buildGlassTextField(
                  controller: _nameController,
                  labelText: "Ism",
                ),
              ),
              const SizedBox(height: 16),
              _buildGlassContainer(
                _buildGlassTextField(
                  controller: _surnameController,
                  labelText: "Familiya",
                ),
              ),
              const SizedBox(height: 16),
              _buildGlassContainer(
                _buildGlassTextField(
                  controller: _loginController,
                  labelText: "Login",
                ),
              ),
              const SizedBox(height: 16),
              _buildGlassContainer(
                _buildGlassTextField(
                  controller: _passwordController,
                  labelText: "Parol",
                  obscureText: !_isPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Image.asset(
                      _isPasswordVisible ? 'rasm/2.png' : 'rasm/monkey.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToNextScreen,
                child: const Text("Saqlash"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatefulWidget {
  const NextScreen({super.key});

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginValid = true;
  bool _isPasswordValid = true;

  Future<void> _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedLogin = prefs.getString('login') ?? '';
    String savedPassword = prefs.getString('password') ?? '';

    setState(() {
      _isLoginValid = _loginController.text == savedLogin;
      _isPasswordValid = _passwordController.text == savedPassword;
    });

    if (_isLoginValid && _isPasswordValid) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const turt()),
      );
    }
  }

  // Glass container va glass textfield usullarini chaqirish
  Widget _buildGlassContainer(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        child: child,
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        border: InputBorder.none,
        suffixIcon: suffixIcon,
        errorText: _isLoginValid ? null : 'Login yoki parol noto\'g\'ri',
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Center(child: Text("Kirish")),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              _buildGlassContainer(
                _buildGlassTextField(
                  controller: _loginController,
                  labelText: "Login",
                ),
              ),
              const SizedBox(height: 16),
              _buildGlassContainer(
                _buildGlassTextField(
                  controller: _passwordController,
                  labelText: "Parol",
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkLogin,
                child: const Text("Kirish"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class turt extends StatefulWidget {
  const turt({super.key});

  @override
  State<turt> createState() => _turtState();
}

class _turtState extends State<turt> {
  List<dynamic> currencies = [];
  bool isLoading = true;
  String name = '';
  String surname = '';
  String currentTime = '';
  String lastUpdated = '';
  double exchangeRate = 0;
  double amountInDollars = 0;
  double amountInSoms = 0;

  @override
  void initState() {
    super.initState();
    fetchCurrencies();
    loadUserData();
    updateCurrentTime();
  }

  // Fetch currency data from API
  Future<void> fetchCurrencies() async {
    final response = await http.get(
      Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'),
    );
    if (response.statusCode == 200) {
      setState(() {
        currencies = json.decode(response.body);
        isLoading = false;
        lastUpdated = DateTime.now().toString(); // Set last updated time
        exchangeRate = double.parse(currencies
            .firstWhere((currency) => currency['Ccy'] == 'USD')['Rate']
            .toString());
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load currencies');
    }
  }

  // Load user data from SharedPreferences
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Muhammad'; // Default name
      surname = prefs.getString('surname') ?? 'Solih'; // Default surname
    });
  }

  // Update current time every second
  void updateCurrentTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        currentTime = "${now.hour}:${now.minute}:${now.second}";
      });
    });
  }

  // Show the dialog for currency conversion
  void showCurrencyDialog(Map<String, dynamic> currency) {
    final TextEditingController controller = TextEditingController();
    double exchangeRate = double.parse(currency['Rate'].toString());
    double amountInSoms = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Convert ${currency['CcyNm_UZ']} to So'm"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter amount in dollars',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      double dollars = double.tryParse(controller.text) ?? 0;
                      setState(() {
                        amountInSoms = dollars * exchangeRate;
                      });
                    },
                    child: Text('Convert'),
                  ),
                  if (amountInSoms > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Converted Amount: ${amountInSoms.toStringAsFixed(2)} so\'m',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(currentTime, style: const TextStyle(fontSize: 18)),
            Text('$name $surname', style: const TextStyle(fontSize: 18)),
          ],
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'USD Rate: ${exchangeRate.toStringAsFixed(2)} so\'m',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Last Updated: $lastUpdated',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: currencies.length,
                    itemBuilder: (context, index) {
                      final currency = currencies[index];
                      exchangeRate = double.parse(currency['Rate'].toString());

                      double previousRate = currency['PrevRate'] != null
                          ? double.parse(currency['PrevRate'].toString())
                          : exchangeRate;
                      double change = exchangeRate - previousRate;

                      return GestureDetector(
                        onTap: () {
                          showCurrencyDialog(currency);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Text(
                              currency['Ccy'] ?? '',
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.deepPurple),
                            ),
                            title: Text(
                              currency['CcyNm_UZ'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rate: ${currency['Rate']} so'm",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      change > 0
                                          ? Icons.arrow_upward
                                          : (change < 0
                                              ? Icons.arrow_downward
                                              : Icons.remove),
                                      color: change > 0
                                          ? Colors.green
                                          : (change < 0
                                              ? Colors.red
                                              : Colors.grey),
                                    ),
                                    Text(
                                      change > 0
                                          ? "+${change.toStringAsFixed(2)} so'm"
                                          : (change < 0
                                              ? "-${(-change).toStringAsFixed(2)} so'm"
                                              : "No change"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: change > 0
                                              ? Colors.green
                                              : (change < 0
                                                  ? Colors.red
                                                  : Colors.grey)),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Last updated: $lastUpdated",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

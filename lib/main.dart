import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/screens/1_discover_screen.dart';
import 'package:news_app/screens/2_home_screen.dart';
import 'package:news_app/screens/4_profile_screen.dart';
import 'package:news_app/screens/auth_wrapper.dart';
import 'package:news_app/screens/messages_screen.dart';
import 'package:news_app/screens/reels_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✓ Firebase initialized');
  } catch (e) {
    print('⚠️ Firebase init error (app will run in demo mode): $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      initialData: null,
      child: MaterialApp(
        title: 'Portal Berita',
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFF0F2F5),
          primaryColor: Colors.black,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF0F2F5),
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Daftar halaman untuk navigasi bawah
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),     // Index 0
    const DiscoverScreen(), // Index 1
    const ReelsScreen(),    // Index 2
    const MessagesScreen(), // Index 3
    const ProfileScreen(),  // Index 4
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home_2),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.search_normal_1),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.video_play),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.message),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black, // Warna ikon aktif
        unselectedItemColor: Colors.grey[600], // Warna ikon non-aktif
        onTap: _onItemTapped,
        showSelectedLabels: false, // Sembunyikan label
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed, // Agar 5 item muat dengan rapi
      ),
    );
  }
}
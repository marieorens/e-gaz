import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:egaz/pages_client/customer_profile.dart';
import 'package:egaz/pages_client/customer_shopping_cart.dart';
import 'package:egaz/pages_client/customer_history.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class Store {
  final String name;
  final String location;
  final String openingHours;
  final String distance;

  Store({
    required this.name,
    required this.location,
    required this.openingHours,
    required this.distance,
  });
}

final stores = [
  Store(
    name: 'TRIOMPHE MARKET HM',
    location: 'Abomey Calavi, Bénin',
    openingHours: '08:00-20:00',
    distance: '2.1km',
  ),
  Store(
    name: 'PALMA LIQUEURS',
    location: 'Abomey Calavi, Bénin',
    openingHours: '09:00-19:00',
    distance: '2.5km',
  ),
  Store(
    name: 'COMA MEUBLE ET DECOR',
    location: 'COMA MEUBLE & DéCOR,Godomey à côté de...',
    openingHours: '08:00-20:00',
    distance: '2.8km',
  ),
  Store(
    name: 'SNEAKERS229',
    location: 'Cotonou, Bénin',
    openingHours: '09:00-21:00',
    distance: '3.3km',
  ),
  Store(
    name: 'RESTAURANT BOB',
    location: 'Abomey Calavi, Bénin',
    openingHours: '10:00-23:00',
    distance: '3.7km',
  ),
  Store(
    name: 'SORAYA ET FILS',
    location: 'Abomey Calavi, Bénin',
    openingHours: '09:00-22:59',
    distance: '3.8km',
  ),
  Store(
    name: 'THYAME',
    location: 'Cotonou, Bénin',
    openingHours: '10:00-21:00',
    distance: '3.9km',
  ),
  Store(
    name: 'LE ROI DU CHAWARMA',
    location: 'Cotonou, Bénin',
    openingHours: '09:00-00:00',
    distance: '4.0km',
  ),
];

class _CustomerScreenState extends State<CustomerScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const CustomerHomeScreen(),
    const CartPage(),
    const PurchaseHistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[selectedIndex],
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        iconSize: 35,
        activeColor: const Color.fromARGB(255, 43, 0, 255),
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            icon: Icons.home,
            title: 'Accueil',
          ),
          BarItem(
            icon: Icons.shopping_cart,
            title: 'Panier',
          ),
          BarItem(
            icon: Icons.history,
            title: 'Mes achats',
          ),
        ],
      ),
    );
  }
}

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> carouselItems = [
      {
        'image': 'assets/images/gaze.jpg',
        'title': 'Pour votre confort...',
      },
      {
        'image': 'assets/images/comfort.jpg',
        'title': 'Depuis chez vous...',
      },
      {
        'image': 'assets/images/delivery.jpg',
        'title': 'Livraison rapide...',
      },
    ];

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                Text(
                  'e-gaz',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 28,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
            ),
            items: carouselItems.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            item['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Text(
                            item['title']!,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: const Offset(0, 2),
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),

          // Recherche vendeurs
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                // Logique pour la recherche
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.pink.shade200],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Rechercher une boutique',
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                        ),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 28,
                      ),
                      onPressed: () {
                        // Action de recherche
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final store = stores[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade200,
                      ),
                      child: const Icon(Icons.store),
                    ),
                    title: Text(
                      store.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          store.location,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Heures d\'ouverture: ${store.openingHours}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          store.distance,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

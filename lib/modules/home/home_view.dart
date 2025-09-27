import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softtouch/controllers/navigation_controller.dart';
import 'package:softtouch/modules/drawer/drawer_view.dart';
import '../booking/booking_view.dart';
import '../cart/cart_view.dart';
import '../profile/profile_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navController = Get.put(NavigationController());
    
    final List<Widget> pages = [
      const _HomeContent(),
      const BookingView(),
      const CartView(),
      const ProfileView(),
    ];

    return Scaffold(
      extendBody: true,
      body: Obx(() => pages[navController.currentIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: navController.currentIndex.value,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: navController.changeIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Schedule"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      )),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();
  
  static final HomeViewmodel _viewModel = HomeViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      drawer: DrawerView(),
      
      body: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting + Profile
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: const Icon(Icons.menu, size: 28),
                      ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        
                        Text(
                          "Hello, Cara",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Welcome to Beauty Salon",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                    
                  ],
                ),
                const SizedBox(height: 16),

                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Service categories
                SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildServiceCategory(
                        Icons.face_retouching_natural,
                        "Hair",
                      ),
                      _buildServiceCategory(Icons.brush, "Body Spa"),
                      _buildServiceCategory(Icons.remove_red_eye, "Make Up"),
                      _buildServiceCategory(Icons.colorize, "Nail"),
                      _buildServiceCategory(Icons.more_horiz, "More"),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Beauty Specialist title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Beauty Specialist",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Beauty Specialist horizontal list
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildSpecialistCard(
                        context,
                        "Alison Leman",
                        "Masseur",
                        4.0,
                        "https://i.pravatar.cc/150?img=1",
                      ),
                      _buildSpecialistCard(
                        context,
                        "Cara Sweet",
                        "Stylist",
                        5.0,
                        "https://i.pravatar.cc/150?img=2",
                      ),
                      _buildSpecialistCard(
                        context,
                        "Tonya Jey",
                        "Makeup Artist",
                        4.5,
                        "https://i.pravatar.cc/150?img=3",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Best Offers title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Best Offers",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Best Offers horizontal list
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildOfferCard(
                        "For all makeup",
                        "50% OFF",
                        "https://picsum.photos/200/120?1",
                      ),
                      _buildOfferCard(
                        "Hair Treatment",
                        "30% OFF",
                        "https://picsum.photos/200/120?2",
                      ),
                    ],
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

  // Helper methods
  Widget _buildServiceCategory(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.pink),
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSpecialistCard(
    BuildContext context,
    String name,
    String role,
    double rating,
    String imageUrl,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () => _viewModel.navigateToBooking(),
        child: Container(
          width: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    role,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.yellow),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildOfferCard(String title, String discount, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.pink[100],
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                discount,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

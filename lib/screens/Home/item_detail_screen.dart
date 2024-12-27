import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shondhan/models/property_model.dart';
import 'package:shondhan/screens/Home/custom_widgets/floating_widget.dart';
import 'package:shondhan/screens/Home/custom_widgets/house_widget.dart';
import 'package:shondhan/utils/app-constant.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetailScreen extends StatelessWidget {
  final Property property;

  const ItemDetailScreen({super.key, required this.property});

  // Function to launch URLs (for videos)
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  // Function to launch WhatsApp
  Future<void> _launchWhatsApp(String phoneNumber) async {
    final Uri uri = Uri.parse("https://wa.me/$phoneNumber");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch WhatsApp';
    }
  }

  // Function to make a call
  Future<void> _makeCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: "tel", path: phoneNumber);
    if (!await launchUrl(uri)) {
      throw 'Could not make call';
    }
  }

  // Calculate the time difference since submission
  String _getTimeSinceSubmission(DateTime createdAt) {
    final Duration difference = DateTime.now().difference(createdAt);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final oCcy = NumberFormat("#,##,###", "en_INR"); // Updated number format

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Property Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppConstant.appScendoryColor,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and Video Carousel
            _buildMediaCarousel(screenWidth),

            // Property Price, Building Name, Address, and Timeline
            _buildPropertyHeader(oCcy),

            const SizedBox(height: 10),

            // House Information
            _buildSectionHeader("House Information"),
            _buildHouseInfo(),

            // Utilities Included
            _buildSectionHeader("Utilities Included"),
            _buildGridSection(property.utilitiesIncluded),

            // Nearby Facilities
            _buildSectionHeader("Nearby Facilities"),
            _buildGridSection(property.nearbyFacilities),

            // Additional Features
            _buildSectionHeader("Additional Features"),
            _buildAdditionalFeatures(),

            // Description
            _buildSectionHeader("Description"),
            _buildDescription(),

            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          
          // FloatingActionButton(
          //   heroTag: "whatsapp",
          //   onPressed: () => _launchWhatsApp("8801721665453"),
          //   child: const Icon(Icons.message),
          //   backgroundColor: Colors.green,
          // ),
          Spacer(),
          FloatingActionButton(
            heroTag: "call",
            onPressed: () => _makeCall("8801721665453"),
            child: const Icon(Icons.call,color: Colors.white,),
            backgroundColor: AppConstant.appScendoryColor,
          ),
          SizedBox(width: 18,)
        ],
      ),
    );
  }

  // Widget for Image and Video Carousel
  Widget _buildMediaCarousel(double screenWidth) {
    List<Widget> mediaItems = [
      ...property.propertyImgs.map((imagePath) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imagePath,
            width: screenWidth,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      }),
      Column(
        children: property.propertyVideos.map((videoUrl) {
          return GestureDetector(
            onTap: () => _launchURL(videoUrl), // Opens the video URL
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10), // Spacing between items
              width: double.infinity,
              height: 200, // Adjust height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      property.propertyImgs.first, // Display the first image
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.black12,
                          child: const Icon(
                            Icons.broken_image,
                            size: 80,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 80,
                      color: Colors.deepPurple, // Play button color
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 250.0,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
        ),
        items: mediaItems,
      ),
    );
  }

  // Widget for Property Header with Timeline
  Widget _buildPropertyHeader(NumberFormat oCcy) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${property.buildingName} - Floor ${property.floor.ceil()}',
              style: GoogleFonts.notoSans(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$' + oCcy.format(property.rentPrice),
              style: GoogleFonts.notoSans(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.deepPurple),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    property.address,
                    style: GoogleFonts.notoSans(
                        fontSize: 16, color: Colors.grey.shade600),
                  ),
                ),
                _buildTimeline(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Dynamic Timeline
  Widget _buildTimeline() {
    return Container(
      height: 45,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Text(
          _getTimeSinceSubmission(property.createdAt),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Widget for House Information
  Widget _buildHouseInfo() {
    return _buildCard(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            HouseWidget(
              icon: Icons.square_foot,
              number: property.sizeSqft.ceil().toString(),
              type: "Size (sqft)",
            ),
            HouseWidget(
              icon: Icons.bed,
              number: property.bedroom.ceil().toString(),
              type: "Bedrooms",
            ),
            HouseWidget(
              icon: Icons.bathtub,
              number: property.washroom.ceil().toString(),
              type: "Washrooms",
            ),
            HouseWidget(
              icon: Icons.kitchen,
              number: property.kitchen.ceil().toString(),
              type: "Kitchen",
            ),
            HouseWidget(
              icon: Icons.dining,
              number:
                  property.diningSpace.ceil().toString(), // Added dining room
              type: "Dining Room",
            ),
            HouseWidget(
              icon: Icons.living,
              number: property.livingRoom.ceil().toString(),
              type: "Living Room",
            ),
            HouseWidget(
              icon: Icons.store,
              number: property.storeRoom.ceil().toString(),
              type: "Store Room",
            ),
            HouseWidget(
              icon: Icons.balcony,
              number: property.veranda.ceil().toString(),
              type: "Veranda",
            ),
          ],
        ),
      ),
    );
  }

// Widget for Utilities and Nearby Facilities
  Widget _buildGridSection(List<String> items) {
    IconData getIcon(String item) {
      switch (item.toLowerCase()) {
        case "school":
          return Icons.school;
        case "hospital":
          return Icons.local_hospital;
        case "market":
          return Icons.shopping_cart;
        case "park":
          return Icons.park;
        case "gym":
          return Icons.fitness_center;
        case "transport":
          return Icons.directions_bus;
        case "restaurant":
          return Icons.restaurant;
        case "gas":
          return Icons.local_gas_station;
        case "water":
          return Icons.water_drop;
        case "electricity":
          return Icons.flash_on;
        case "lift":
          return Icons.elevator;
        case "generator":
          return Icons.power;
        case "mosque":
          return Icons.mosque;
        default:
          return Icons.location_on; // Fallback icon
      }
    }

    return _buildCard(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.map((item) {
            return HouseWidget(
              icon: getIcon(item),
              number: "", // No numeric value for utilities
              type: item,
            );
          }).toList(),
        ),
      ),
    );
  }

  // Widget for Additional Features
  Widget _buildAdditionalFeatures() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeatureRow(
              Icons.check, "Furnished", property.furnished ? "Yes" : "No"),
          _buildFeatureRow(
              Icons.pets, "Pet Friendly", property.petFriendly ? "Yes" : "No"),
          _buildFeatureRow(Icons.local_parking, "Parking Space",
              property.parkingSpace ? "Available" : "Not Available"),
        ],
      ),
    );
  }

  // Widget for Feature Row
  Widget _buildFeatureRow(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(label),
      trailing:
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  // Generic Card Widget
  Widget _buildCard({required Widget child}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: const EdgeInsets.all(12), child: child),
    );
  }

  // Widget for Section Header
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.notoSans(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  // Widget for Description
  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0), // Add space below the card
      child: _buildCard(
        child: Text(
          property.description,
          textAlign: TextAlign.justify,
          style:
              GoogleFonts.notoSans(fontSize: 16, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
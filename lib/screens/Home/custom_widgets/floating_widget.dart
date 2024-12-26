import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingWidget extends StatelessWidget {
  final IconData leadingIcon;
  final String txt;
  final VoidCallback onPressed;

  const FloatingWidget({
    super.key,
    required this.leadingIcon,
    required this.txt,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 150,
      child: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        elevation: 5,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(75.0),
        ),
        heroTag: null,
        child: Ink(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0),
            borderRadius: BorderRadius.circular(75.0),
          ),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 300.0,
              minHeight: 50.0,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  leadingIcon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    txt,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void launchWhatsApp() async {
  const number = '8801721665453'; 
  const url = 'https://wa.me/$number';
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  } catch (e) {
    print('Error launching WhatsApp: $e');
  }
}

void makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  try {
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      print('Could not launch $launchUri');
    }
  } catch (e) {
    print('Error making phone call: $e');
  }
}
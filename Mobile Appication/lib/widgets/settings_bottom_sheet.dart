import 'package:flutter/material.dart';

void showSettingsBottomSheet(BuildContext context, Map<String, dynamic> user) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(
        width: double.infinity,
        height: 830,
        padding: EdgeInsets.only(top: 12, bottom: 24),
        decoration: BoxDecoration(
          color: Color(0xFFF7F9FB),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Setting",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // Profile block
            Container(
              margin: EdgeInsets.only(left: 18, right: 18, top: 18),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(Icons.person, size: 30),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            user['user_name'] ?? "Unknown",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  // Email + Username info
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.email, size: 20),
                            SizedBox(width: 12),
                            Text("Email"),
                            Spacer(),
                            Text(
                              user['email'] ?? "Unknown",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.person_outline, size: 20),
                            SizedBox(width: 12),
                            Text("User name"),
                            Spacer(),
                            Text(
                              user["user_name"] ?? "Unknown",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            SizedBox(height: 10),

            // Personalize option
            Container(
              margin: EdgeInsets.only(left: 18, right: 18),
              padding: EdgeInsets.only(left: 26, right: 26),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(16),
              ),
              height: 60,
              child: Row(
                children: [
                  Text("Personalize", style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Sign Out button
            Container(
              margin: EdgeInsets.only(left: 18, right: 18),
              padding: EdgeInsets.only(left: 26, right: 26),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              height: 60,
              child: Center(
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.red.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

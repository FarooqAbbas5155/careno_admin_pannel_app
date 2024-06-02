import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Table'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Table(
          border: TableBorder.all(color: Colors.black),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FlexColumnWidth(2.0), // Name
            1: FlexColumnWidth(3.0), // Phone
            2: FlexColumnWidth(3.0), // Email
            3: FlexColumnWidth(4.0), // Gender
            4: FlexColumnWidth(2.0), // Gender
            5: FlexColumnWidth(1.0), // Gender
          },
          children: [
            TableRow(
              children: [
                _buildTableCell('Image', header: true),
                _buildTableCell('Name', header: true),
                _buildTableCell('Phone', header: true),
                _buildTableCell('Email', header: true),
                _buildTableCell('Gender', header: true),
                _buildTableCell('Action', header: true),
              ],
            ),
            // Generate rows dynamically
            ..._buildTableRows(),
          ],
        ),
      ),
    );
  }

  List<TableRow> _buildTableRows() {
    List<TableRow> rows = [];

    // Simulated data (you can replace this with your actual data)
    List<Map<String, String>> userData = [
      {
        'name': 'John Doe',
        'phone': '+1234567890',
        'email': 'johndoe@example.com',
        'gender': 'Male',
      },
      {
        'name': 'Jane Smith',
        'phone': '+9876543210',
        'email': 'janesmith@example.com',
        'gender': 'Female',
      },
      // Add more user data as needed
    ];

    // Create TableRow widgets for each user data entry
    userData.forEach((user) {
      rows.add(
        TableRow(
          children: [
            _buildTableCell('Avatar'),
            _buildTableCell(user['name'] ?? ''),
            _buildTableCell(user['phone'] ?? ''),
            _buildTableCell(user['email'] ?? ''),
            _buildTableCell(user['gender'] ?? ''),
            _buildTableCell('Edit'),
          ],
        ),
      );
    });

    return rows;
  }

  Widget _buildTableCell(String text, {bool header = false}) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: header ? Colors.grey[300] : Colors.white,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: header ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// class CustomTable extends StatefulWidget {
//   @override
//   _CustomTableState createState() => _CustomTableState();
// }
//
// class _CustomTableState extends State<CustomTable> {
//   late Future<List<User>> _usersFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _usersFuture = getUsersFromDatabase();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Table'),
//       ),
//       body: Container(
//         color: Colors.white,
//         padding: EdgeInsets.all(20.0),
//         child: FutureBuilder<List<User>>(
//           future: _usersFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator(); // Show loading indicator while fetching data
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               List<User> users = snapshot.data ?? [];
//               return Table(
//                 border: TableBorder.all(color: Colors.black),
//                 defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                 children: [
//                   TableRow(
//                     children: [
//                       _buildTableCell('Name', header: true),
//                       _buildTableCell('Phone', header: true),
//                       _buildTableCell('Email', header: true),
//                       _buildTableCell('Gender', header: true),
//                     ],
//                   ),
//                   for (var user in users)
//                     TableRow(
//                       children: [
//                         _buildTableCell(user.name),
//                         _buildTableCell(user.phone),
//                         _buildTableCell(user.email),
//                         _buildTableCell(user.gender),
//                       ],
//                     ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTableCell(String text, {bool header = false}) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       color: header ? Colors.grey[300] : Colors.white,
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: TextStyle(fontWeight: header ? FontWeight.bold : FontWeight.normal),
//       ),
//     );
//   }
// }
//
//

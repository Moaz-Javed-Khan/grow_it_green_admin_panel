// import 'package:flutter/cupertino.dart';

// class ItemListTile extends StatefulWidget {
//   const ItemListTile({super.key});

//   @override
//   State<ItemListTile> createState() => _ItemListTileState();
// }

// class _ItemListTileState extends State<ItemListTile> {
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Image.network(image),
//       title: Text(list[index]['name']),
//       subtitle: Row(
//         children: [
//           // ignore: prefer_interpolation_to_compose_strings
//           Text('${'Price: ' + list[index]['price']} Rs.'),
//           const SizedBox(width: 20),
//           Text(
//               // ignore: prefer_interpolation_to_compose_strings
//               'Quantity: ' + list[index]['quantity']),
//         ],
//       ),
//       // ignore: prefer_const_literals_to_create_immutables
//       trailing: SizedBox(
//         // height: double.infinity,
//         width: 400,
//         child: Row(
//           // mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           // ignore: prefer_const_literals_to_create_immutables
//           children: [
//             MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: GestureDetector(
//                 onTap: () {
//                   showMyDialog(
//                     title,
//                     description,
//                     price,
//                     quantity,
//                     image,
//                     list[index]['id'],
//                   );
//                 },
//                 child: Row(
//                   // ignore: prefer_const_literals_to_create_immutables
//                   children: [
//                     const Icon(Icons.edit),
//                     const SizedBox(width: 16),
//                     const Text("Edit"),
//                   ],
//                 ),
//               ),
//             ),
//             MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: GestureDetector(
//                 onTap: () {
//                   ref.child(list[index]['id'].toString()).remove();
//                 },
//                 child: Row(
//                   // ignore: prefer_const_literals_to_create_immutables
//                   children: [
//                     const Icon(Icons.delete),
//                     const SizedBox(width: 16),
//                     const Text("Delete"),
//                   ],
//                 ),
//               ),
//             ),
//             // const ListTile(
//             //   leading: Icon(Icons.edit),
//             //   title: Text("Edit"),
//             // ),
//             // const ListTile(
//             //   leading: Icon(Icons.delete),
//             //   title: Text("Delete"),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

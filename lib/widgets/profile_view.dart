// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:komisains_app/core/auth/models/auth.dart';
// import 'package:provider/provider.dart';

// class ProfileView extends StatelessWidget {
//   const ProfileView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final profile = Provider.of<Auth>(context).items;
//     return Container(
//         child: Column(
//       children: <Widget>[
//         SizedBox(
//           height: 15,
//         ),
//         AttributeItem(
//             attribute: 'Nama',
//             profileAttribute: profile!.name,
//             heightSize: MediaQuery.of(context).size.height * 0.07),
//         AttributeItem(
//             attribute: 'TTL',
//             profileAttribute: profile.tempatTanggalLahir,
//             heightSize: MediaQuery.of(context).size.height * 0.07),
//         AttributeItem(
//             attribute: 'Email',
//             profileAttribute: profile.email,
//             heightSize: MediaQuery.of(context).size.height * 0.07),
//         AttributeItem(
//             attribute: 'Alamat',
//             profileAttribute: profile.address,
//             heightSize: MediaQuery.of(context).size.height * 0.07),
//         AttributeItem(
//             attribute: 'No Telfon',
//             profileAttribute: profile.hp,
//             heightSize: MediaQuery.of(context).size.height * 0.07),
//         AttributeItem(
//             attribute: 'Jenis Kelamin',
//             profileAttribute: profile.sex,
//             heightSize: MediaQuery.of(context).size.height * 0.07),
//         Row(
//           children: <Widget>[
//             AttributeItem(
//               attribute: 'Jurusan',
//               profileAttribute: profile.department,
//               heightSize: MediaQuery.of(context).size.height * 0.07,
//               widthSize: MediaQuery.of(context).size.width * 0.6,
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(5, 5, 20, 4),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 width: MediaQuery.of(context).size.width * 0.240,
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       profile.angkatanKuliah,
//                       style: const TextStyle(color: Colors.white70),
//                     ),
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                     border: Border.all(width: 1.0, color: Colors.white70)),
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: <Widget>[
//             AttributeItem(
//               attribute: 'Nama Angkatan',
//               profileAttribute: profile.namaAngkatan,
//               heightSize: MediaQuery.of(context).size.height * 0.07,
//               widthSize: MediaQuery.of(context).size.width * 0.6,
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(5, 5, 20, 4),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 width: MediaQuery.of(context).size.width * 0.240,
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       profile.yearJoin ?? "Angkatan",
//                       style: const TextStyle(color: Colors.white70),
//                     ),
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                     border: Border.all(width: 1.0, color: Colors.white70)),
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//           child: Container(
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'Jenjang Training : ',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextSpan(
//                         text: profile.jenjangTraining,
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//                 border: Border.all(width: 1.0, color: Colors.white70)),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//           child: Container(
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'Pengalaman Organisasi : ',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextSpan(
//                         text: profile.pengalamanOrganisasi,
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//                 border: Border.all(width: 1.0, color: Colors.white70)),
//           ),
//         ),
//         AttributeItem(
//           attribute: 'Linkedin',
//           profileAttribute: profile.linkedin,
//           heightSize: MediaQuery.of(context).size.height * 0.07,
//         ),
//         AttributeItem(
//           attribute: 'Instagram',
//           profileAttribute: profile.instagram,
//           heightSize: MediaQuery.of(context).size.height * 0.07,
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
//           child: Container(
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'Media Sosial Lainnya : ',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextSpan(
//                         text: profile.pengalamanOrganisasi,
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//                 border: Border.all(width: 1.0, color: Colors.white70)),
//           ),
//         ),
//       ],
//     ));
//   }
// }

// class AttributeItem extends StatelessWidget {
//   final String attribute;
//   final String profileAttribute;
//   final heightSize;
//   final widthSize;
//   const AttributeItem({
//     required this.attribute,
//     required this.profileAttribute,
//     required this.heightSize,
//     this.widthSize,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final widthSizeFix = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//       child: Container(
//         height: heightSize,
//         width: widthSize == null ? widthSizeFix : widthSize,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//             border: Border.all(width: 1.0, color: Colors.white70)),
//         child: Row(children: <Widget>[
//           Container(
//             width: MediaQuery.of(context).size.width * 0.25,
//             child: Align(
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: AutoSizeText(
//                   attribute,
//                   style: const TextStyle(
//                       color: Color(0xff6EA88F),
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   bottomLeft: Radius.circular(20)),
//               color: Colors.white,
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 profileAttribute,
//                 style: const TextStyle(color: Colors.white70, fontSize: 13),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

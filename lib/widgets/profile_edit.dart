// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:komisains_app/core/auth/models/auth.dart';
// import 'package:provider/provider.dart';

// class EditProfileScreen extends StatefulWidget {
//   static const routeName = '/edit-profile';
//   const EditProfileScreen({Key? key}) : super(key: key);

//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   Map<String, String> _editProfile = {
//     'id': '',
//     'name': '',
//     'email': '',
//     'nohp': '',
//     'department': '',
//     'sex': '',
//     'angkatan_kuliah': '',
//     'year_join': '',
//     'jenjang_training': '',
//     'pengalaman_organisasi': '',
//     'linkedin': '',
//     'instagram': '',
//     'lainnya': '',
//     'address': '',
//     'nama_angkatan': '',
//     'tempat_tanggal_lahir': '',
//   };
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _noHpController = TextEditingController();
//   final _jurusanController = TextEditingController();
//   final _jenisKelaminController = TextEditingController();
//   final _angkatanKuliahController = TextEditingController();
//   final _tahunBergabungController = TextEditingController();
//   final _jenjangTrainingController = TextEditingController();
//   final _pengalamanOrganisasiController = TextEditingController();
//   final _linkedlnController = TextEditingController();
//   final _instagramController = TextEditingController();
//   final _lainnyaController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _namaAngkatanController = TextEditingController();
//   final _tempatTanggalLahirController = TextEditingController();

//   final _nameFocusNode = FocusNode();
//   final _emailFocusNode = FocusNode();
//   final _noHpFocusNode = FocusNode();
//   final _jurusanFocusNode = FocusNode();
//   final _angkatanFocusNode = FocusNode();
//   final _jenisKelaminFocusNode = FocusNode();
//   final _tahunBergabungFocusNode = FocusNode();
//   final _jenjangTrainingFocusNode = FocusNode();
//   final _pengalamanOrganisasiFocusNode = FocusNode();
//   final _linkedlnFocusNode = FocusNode();
//   final _instagramFocusNode = FocusNode();
//   final _lainnyaFocusNode = FocusNode();
//   final _addressFocusNode = FocusNode();
//   final _namaAngkatanFocusNode = FocusNode();
//   final _tempatTanggalLahirFocusNode = FocusNode();
//   final _form = GlobalKey<FormState>();
//   var _isInit = true;
//   var _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _nameFocusNode.dispose();
//     _emailFocusNode.dispose();
//     _noHpFocusNode.dispose();
//     _jurusanFocusNode.dispose();
//     _angkatanFocusNode.dispose();
//     _jenisKelaminFocusNode.dispose();
//     _tahunBergabungFocusNode.dispose();
//     _jenjangTrainingFocusNode.dispose();
//     _pengalamanOrganisasiFocusNode.dispose();
//     _linkedlnFocusNode.dispose();
//     _instagramFocusNode.dispose();
//     _lainnyaFocusNode.dispose();
//     _namaAngkatanFocusNode.dispose();
//     _tempatTanggalLahirFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       final profileId = ModalRoute.of(context)!.settings.arguments as String;
//       if (profileId != null) {
//         Provider.of<Auth>(context, listen: false).getData();
//       }
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

//   Future<void> _saveForm() async {
//     final isValid = _form.currentState!.validate();
//     if (!isValid) {
//       return;
//     }
//     _form.currentState!.save();
//     setState(() {
//       _isLoading = true;
//     });
//     if (_editProfile['id'] != null) {
//       await Provider.of<Auth>(context, listen: false)
//           .updateProfile(_editProfile);
//     } else {
//       await showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: Text('An error occurred!'),
//           content: Text('Something went wrong.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Okay'),
//               onPressed: () {
//                 Navigator.of(ctx).pop();
//               },
//             )
//           ],
//         ),
//       );
//     }
//     setState(() {
//       _isLoading = false;
//       Navigator.of(context).pop();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profile = Provider.of<Auth>(context).items;
//     _editProfile['id'] = profile!.id.toString();
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xff6EA88F),
//         ),
//         child: SingleChildScrollView(
//           physics: ScrollPhysics(),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20),
//                       child: Icon(
//                         FontAwesomeIcons.arrowLeft,
//                         color: Colors.white,
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 20),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         border: Border.all(width: 1.0, color: Colors.white),
//                       ),
//                       height: MediaQuery.of(context).size.height * 0.04,
//                       width: MediaQuery.of(context).size.width * 0.2,
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       child: Row(
//                         children: <Widget>[
//                           InkWell(
//                             onTap: _saveForm,
//                             child: Text(
//                               'Simpan',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Form(
//                 key: _form,
//                 child: Column(
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.075,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: TextFormField(
//                             cursorColor: Colors.white,
//                             style: const TextStyle(
//                                 color: Colors.white, fontSize: 14),
//                             decoration: InputDecoration(
//                                 labelText: 'Nama :',
//                                 labelStyle:
//                                     const TextStyle(color: Colors.white),
//                                 focusColor: Colors.white,
//                                 border: InputBorder.none,
//                                 enabledBorder: InputBorder.none,
//                                 errorBorder: InputBorder.none,
//                                 disabledBorder: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 hoverColor: Colors.white,
//                                 counterStyle:
//                                     const TextStyle(color: Colors.white)),
//                             textInputAction: TextInputAction.next,
//                             focusNode: _nameFocusNode,
//                             controller: _nameController,
//                             onFieldSubmitted: (_) {
//                               FocusScope.of(context)
//                                   .requestFocus(_tempatTanggalLahirFocusNode);
//                             },
//                             onSaved: (value) {
//                               _editProfile['name'] = value!;
//                             },
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.075,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: TextFormField(
//                             cursorColor: Colors.white,
//                             style: const TextStyle(
//                                 color: Colors.white, fontSize: 14),
//                             decoration: InputDecoration(
//                                 labelText: 'Tempat Tanggal Lahir :',
//                                 labelStyle:
//                                     const TextStyle(color: Colors.white),
//                                 focusColor: Colors.white,
//                                 border: InputBorder.none,
//                                 enabledBorder: InputBorder.none,
//                                 errorBorder: InputBorder.none,
//                                 disabledBorder: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 hoverColor: Colors.white,
//                                 counterStyle:
//                                     const TextStyle(color: Colors.white)),
//                             textInputAction: TextInputAction.next,
//                             focusNode: _tempatTanggalLahirFocusNode,
//                             controller: _tempatTanggalLahirController,
//                             onFieldSubmitted: (_) {
//                               FocusScope.of(context)
//                                   .requestFocus(_emailFocusNode);
//                             },
//                             onSaved: (value) {
//                               _editProfile['tempat_tanggal_lahir'] = value!;
//                             },
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.075,
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Email :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.next,
//                               focusNode: _emailFocusNode,
//                               controller: _emailController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_noHpFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['email'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.15,
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Alamat :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.next,
//                               focusNode: _addressFocusNode,
//                               controller: _addressController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_noHpFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['address'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.075,
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'No Hp :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.next,
//                               focusNode: _noHpFocusNode,
//                               controller: _noHpController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_jurusanFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['nohp'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.075,
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Jurusan :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.next,
//                               focusNode: _jurusanFocusNode,
//                               controller: _jurusanController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_angkatanFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['department'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.075,
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Angkatan Kuliah :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.next,
//                               focusNode: _angkatanFocusNode,
//                               controller: _angkatanKuliahController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_jenisKelaminFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['angkatan_kuliah'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.075,
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Jenis Kelamin :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.next,
//                               focusNode: _jenisKelaminFocusNode,
//                               controller: _jenisKelaminController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_tahunBergabungFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['sex'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.075,
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Nama Angkatan :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.next,
//                               focusNode: _namaAngkatanFocusNode,
//                               controller: _namaAngkatanController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_jenjangTrainingFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['nama_angkatan'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.075,
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Tahun Bergabung HMI :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.next,
//                               focusNode: _tahunBergabungFocusNode,
//                               controller: _tahunBergabungController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_namaAngkatanFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['year_join'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Jenjang Training :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.newline,
//                               keyboardType: TextInputType.multiline,
//                               maxLines: null,
//                               focusNode: _jenjangTrainingFocusNode,
//                               controller: _jenjangTrainingController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context).requestFocus(
//                                     _pengalamanOrganisasiFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['jenjang_training'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Pengalaman Organisasi :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.newline,
//                               keyboardType: TextInputType.multiline,
//                               maxLines: null,
//                               focusNode: _pengalamanOrganisasiFocusNode,
//                               controller: _pengalamanOrganisasiController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_linkedlnFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['pengalaman_organisasi'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.075,
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Linkedln :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.next,
//                               focusNode: _linkedlnFocusNode,
//                               controller: _linkedlnController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_instagramFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['linkedin'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.075,
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Instagram :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.next,
//                               focusNode: _instagramFocusNode,
//                               controller: _instagramController,
//                               onFieldSubmitted: (_) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_lainnyaFocusNode);
//                               },
//                               onSaved: (value) {
//                                 _editProfile['instagram'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
//                       child: Container(
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: TextFormField(
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                               decoration: InputDecoration(
//                                   labelText: 'Media Sosial Lainnya :',
//                                   labelStyle:
//                                       const TextStyle(color: Colors.white),
//                                   focusColor: Colors.white,
//                                   border: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   hoverColor: Colors.white,
//                                   counterStyle:
//                                       const TextStyle(color: Colors.white)),
//                               textInputAction: TextInputAction.newline,
//                               keyboardType: TextInputType.multiline,
//                               maxLines: null,
//                               focusNode: _lainnyaFocusNode,
//                               controller: _lainnyaController,
//                               onFieldSubmitted: (_) {
//                                 _saveForm();
//                               },
//                               onSaved: (value) {
//                                 _editProfile['lainnya'] = value!;
//                               },
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(width: 1.0, color: Colors.white70)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

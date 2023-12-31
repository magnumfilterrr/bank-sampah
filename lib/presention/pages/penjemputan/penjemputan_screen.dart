// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_field, unused_element
// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

part of '../pages.dart';

class PenjemputanScreen extends StatefulWidget {
  final NewInquiryModel addInquiry;
  const PenjemputanScreen({
    Key? key,
    required this.addInquiry,
  }) : super(key: key);

  @override
  State<PenjemputanScreen> createState() => _PenjemputanScreenState();
}

class _PenjemputanScreenState extends State<PenjemputanScreen> {
  String? _serviceName;
  int? _price;

  @override
  void initState() {
    _serviceName = widget.addInquiry.service_name;
    _price = widget.addInquiry.price;
    super.initState();
  }

  TextEditingController lokasiController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController jamController = TextEditingController();
  TextEditingController menitController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String? groupValue;
  String urlImage = "";
  File? _image;
  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(
        () {
          _image = File(pickedImage.path);
          urlImage = '';
        },
      );
    }
  }

  Future<void> _getImageFromGalery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(
        () {
          _image = File(pickedImage.path);
          urlImage = '';
        },
      );
    }
  }

  bool isProfileCompleted() {
    if (lokasiController.text.isNotEmpty && tanggalController.text.isNotEmpty
        // waktuController.text.isNotEmpty &&
        // beratController.text.isNotEmpty
        ) {
      return true;
    } else {
      return false;
    }
  }

  DateTime pickDate = DateTime.now();
  // String formatDate = DateFormat.yMMMEd().format(DateTime.now());

  double getTotal() {
    final weightText = weightController.text;
    final double price = _price!.toDouble();
    final getWeight =
        weightText.split(',').map((str) => double.tryParse(str) ?? 0.00);
    double total = 0.00;
    for (var weight in getWeight) {
      total += price * weight;
    }
    return total;
  }

  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDateTime) {
      setState(() {
        selectedDateTime = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );

    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(selectedDateTime.year,
            selectedDateTime.month, selectedDateTime.day, 0, 0, 0);
      });
    }
  }

  bool validate() {
    if (lokasiController.text.isEmpty ||
        tanggalController.text.isEmpty ||
        jamController.text.isEmpty ||
        menitController.text.isEmpty ||
        weightController.text.isEmpty) {
      Commons().showSnackbarError(context, "Semua field harus diisi.");
      return false;
    }
    if (_image == null) {
      Commons().showSnackbarError(context, 'Photo Sampah Tidak Boleh Kosong');
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Detail Penjemputan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              context.goNamed(Routes.NavigasiBar);
            },
            child: const Icon(CupertinoIcons.arrow_left, color: Colors.black)),
      ),
      body: BlocListener<NewInquiryCubit, NewInquiryState>(
        listener: (context, state) {
          if (state is NewInquiryIsError) {
            Commons().showSnackbarError(context, state.message!);
          } else if (state is NewInquiryIsSuccess) {
            context.goNamed(Routes.SuccesPenjemputan);
            Commons().showSnackbarInfo(context, "Add New Inquiry Berhasil");
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 26, left: 20),
                  child: Text(
                    'Atur Lokasi',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 36,
                  child: TextFormField(
                    controller: lokasiController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      suffixIcon: const Icon(Icons.location_on),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Atur lokasi penjemputan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 24, left: 20),
                  child: Text(
                    "Tanggal Penjemputan",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 36,
                  child: TextFormField(
                    readOnly: true,
                    controller: tanggalController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          // await showDatePicker(

                          //         context: context,
                          //         initialDate: pickDate,
                          //         firstDate: DateTime(1800),
                          //         lastDate: DateTime(2100))
                          //     .then((value) {
                          //   if (value != null) {
                          //     setState(() {
                          //       pickDate = value;
                          //     });
                          //   }
                          // });

                          //   final dateFormat = DateFormat("yyyy-MM-dd HH:mm");
                          //   tanggalController.text = pickDate.toString();
                          //   DateTimeField(
                          //     format: dateFormat,
                          //     onShowPicker: (context, pickDate) async {
                          //       return await showDatePicker(
                          //         context: context,
                          //         firstDate: DateTime(1900),
                          //         initialDate: pickDate!,
                          //         lastDate: DateTime(2100),
                          //       ).then((DateTime? pickDate) async {
                          //         if (pickDate != null) {
                          //           final time = await showTimePicker(
                          //             context: context,
                          //             initialTime:
                          //                 TimeOfDay.fromDateTime(pickDate),
                          //           );
                          //           return DateTimeField.combine(pickDate, time);
                          //         } else {
                          //           return pickDate;
                          //         }
                          //       });
                          //     },
                          //   );
                          // },
                          //   final DateFormat dateFormat =
                          //       DateFormat("yyyy-MM-dd");
                          //   final DateTime? pickedDateTime = await showDatePicker(
                          //     context: context,
                          //     firstDate: DateTime(1900),
                          //     initialDate: pickDate,
                          //     lastDate: DateTime(2100),
                          //   );

                          //   if (pickedDateTime != null) {
                          //     pickDate = pickedDateTime;
                          //     tanggalController.text =
                          //         dateFormat.format(pickedDateTime);

                          //   }
                          _selectDate(context);

                          tanggalController.text =
                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(selectedDateTime);
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Tanggal Penjemputan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24, left: 20),
                child: Text('Pilih Waktu', style: TextStyle(fontSize: 14)),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 20),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: TextFormField(
                        controller: jamController,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            var intValue = int.tryParse(value) ?? 0;
                            // var value = 0;
                            if (intValue < 01) {
                              intValue = 01;
                            } else if (intValue > 12) {
                              intValue = 12;
                              jamController.text = intValue.toString();
                            }
                          });
                          if (value.length == 2) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '00',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0.5,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 6),
                    child: Text(
                      ":",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 6),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: TextFormField(
                        controller: menitController,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            var intValue = int.tryParse(value) ?? 0;
                            // var value = 0;
                            if (intValue < 00) {
                              intValue = 00;
                            } else if (intValue > 59) {
                              intValue = 59;
                              menitController.text = intValue.toString();
                            }
                          });
                          if (value.length == 2) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '00',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0.5,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: "AM",
                      groupValue: groupValue,
                      title: const Text("AM"),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: "PM",
                      groupValue: groupValue,
                      title: const Text("PM"),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  "Berat dan bentuk sampah",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 20),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: TextFormField(
                        controller: weightController,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          if (value.length == 2) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '00',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0.5,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                      top: 5,
                    ),
                    child: Text(
                      "Kg",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return SizedBox(
                              height: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      _getImageFromGalery();
                                    },
                                    child: const ListTile(
                                      leading: Icon(
                                          CupertinoIcons.photo_on_rectangle),
                                      title: Text(
                                        "Gallery",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _getImageFromCamera();
                                    },
                                    child: const ListTile(
                                      leading: Icon(
                                          CupertinoIcons.photo_camera_solid),
                                      title: Text(
                                        "Camera",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(_image!,
                                width: MediaQuery.of(context).size.width,
                                height: 125.0,
                                fit: BoxFit.cover),
                          )
                        : Container(
                            height: 125.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('asset/images/sampah.png'),
                                  fit: BoxFit.fill),
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  15,
                                ),
                              ),
                            ),
                          )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 70, left: 20),
                      child: Text(
                        "Total Biaya",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 70, right: 20),
                        child: Text(
                          '${getTotal()}',
                          style: TextStyle(
                              fontSize: 22.0, color: Color(0xFF019BF1)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8D50),
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (validate()) {
                        setState(() {
                          BlocProvider.of<NewInquiryCubit>(context)
                              .addQuiry(NewInquiryRequest(
                            widget.addInquiry.service_name,
                            int.parse(weightController.text),
                            lokasiController.text,
                            _image!,
                            tanggalController.text,
                          ));
                        });
                      }
                    },
                    child: const Text("Proses Penjemputan"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

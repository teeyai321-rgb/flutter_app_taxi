import 'package:flutter/material.dart';

class TaxiFareUI extends StatefulWidget {
  const TaxiFareUI({super.key});

  @override
  State<TaxiFareUI> createState() => _TaxiFareUIState();
}

class _TaxiFareUIState extends State<TaxiFareUI> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _trafficController = TextEditingController();
  double _fare = 0;

  @override
  void dispose() {
    _distanceController.dispose();
    _trafficController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 251, 255),
      body: Column(
        children: [
          Container(
            height: 55,
            width: double.infinity,
            color: const Color(0xFFFFC107),
            alignment: Alignment.center,
            child: const Text(
              'Taxi Fare',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(36, 14, 36, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            Center(
                              child: Image.asset(
                                'assets/images/taxi.png',
                                height: 180,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 22),
                            const Center(
                              child: Text(
                                'คำนวณค่าโดยสารแท็กซี่',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'ระยะทาง (กิโลเมตร) 🛣️',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _distanceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'กรุณากรอกระยะทาง',
                                hintStyle: TextStyle(fontSize: 15),
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            const Text(
                              'เวลารถติด (นาที) ⏰',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _trafficController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'กรุณากรอกเวลารถติด',
                                hintStyle: TextStyle(fontSize: 15),
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  final distance = double.tryParse(
                                    _distanceController.text.trim(),
                                  );
                                  final trafficMinutes = double.tryParse(
                                    _trafficController.text.trim().isEmpty
                                        ? '0'
                                        : _trafficController.text.trim(),
                                  );

                                  if (distance == null ||
                                      distance <= 0 ||
                                      trafficMinutes == null ||
                                      trafficMinutes < 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Color(0xFFF44336),
                                        content: Row(
                                          children: [
                                            Icon(
                                              Icons.warning_rounded,
                                              color: Colors.amber,
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                'กรุณากรอกข้อมูลให้ถูกต้อง',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  double fare;

                                  if (distance <= 1) {
                                    fare = 35;
                                  } else if (distance <= 10) {
                                    fare = 35 + (distance - 1) * 6.5;
                                  } else if (distance <= 20) {
                                    fare = 35 + (9 * 6.5) + (distance - 10) * 7;
                                  } else if (distance <= 40) {
                                    fare = 35 +
                                        (9 * 6.5) +
                                        (10 * 7) +
                                        (distance - 20) * 8;
                                  } else if (distance <= 60) {
                                    fare = 35 +
                                        (9 * 6.5) +
                                        (10 * 7) +
                                        (20 * 8) +
                                        (distance - 40) * 8.5;
                                  } else if (distance <= 80) {
                                    fare = 35 +
                                        (9 * 6.5) +
                                        (10 * 7) +
                                        (20 * 8) +
                                        (20 * 8.5) +
                                        (distance - 60) * 9;
                                  } else {
                                    fare = 35 +
                                        (9 * 6.5) +
                                        (10 * 7) +
                                        (20 * 8) +
                                        (20 * 8.5) +
                                        (20 * 9) +
                                        (distance - 80) * 10.5;
                                  }

                                  setState(() {
                                    _fare = fare + (trafficMinutes * 3);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFC107),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 70),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Text(
                                  'คำนวณค่าโดยสาร',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 19),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _distanceController.clear();
                                    _trafficController.clear();
                                    _fare = 0;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 70),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Text(
                                  'ยกเลิก',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(minHeight: 200),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEDB5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('ค่าโดยสารแท็กซี่',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(
                                      _fare.toStringAsFixed(2),
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text('บาท',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

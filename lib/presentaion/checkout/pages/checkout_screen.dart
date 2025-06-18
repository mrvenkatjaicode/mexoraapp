import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/data/mock.dart';
import 'package:mexoraapp/presentaion/checkout/bloc/checkout_bloc.dart';
import 'package:mexoraapp/presentaion/checkout/bloc/checkout_event.dart';
import 'package:mexoraapp/presentaion/checkout/bloc/checkout_state.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mexoraapp/presentaion/checkout/widgets/paymenticon_widget.dart';
import 'package:mexoraapp/presentaion/checkout/widgets/pricerow_widget.dart';
import 'package:mexoraapp/presentaion/checkout/widgets/toggle_widget.dart';
import 'package:mexoraapp/presentaion/homemain/pages/homemain_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;

  const CheckoutScreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  static int selectedCard = 0;
  static bool homeDelivery = true;
  static String selectedPaymentMethod = "";

  void showAlertsuccess(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.success,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomemainScreen()),
        );
      },
      title: 'SUCCESS',
      desc: 'Purchase completed successfully!',
      // titleTextStyle: GoogleFonts.nunitoSans(
      //     fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
      // descTextStyle: GoogleFonts.nunitoSans(
      //     fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutBloc(),
      child: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is ShippingMethodSelectedState) {
            homeDelivery = state.isHomedelivery;
          } else if (state is PaymentCardSelectedState) {
            selectedCard = state.index;
          } else if (state is OtherPaymentMethodSelectedState) {
            selectedPaymentMethod = state.method;
          } else if (state is PurchaseButtonPressedState) {
            showAlertsuccess(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7F7F7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                ),
              ),
              title: Text(
                "Checkout",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: 88,
                        height: 88,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              spacing: 8,
                              children: [
                                Text(
                                  "\$${price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  width: 1,
                                  height: 10,
                                ),
                                const Text(
                                  "Including taxes and duties",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Shipping method",
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.grey.shade200,
                        ),
                        child: Row(
                          children: [
                            toggleButton("Home delivery", homeDelivery, () {
                              context.read<CheckoutBloc>().add(
                                SelectShippingMethodEvent(isHomedelivery: true),
                              );
                              // setState(() {
                              //   homeDelivery = true;
                              // });
                            }),
                            toggleButton("Pick up in store", !homeDelivery, () {
                              context.read<CheckoutBloc>().add(
                                SelectShippingMethodEvent(
                                  isHomedelivery: false,
                                ),
                              );
                              // setState(() {
                              //   homeDelivery = false;
                              // });
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Select your payment method",
                    style: TextStyle(fontSize: 16),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(cards.length, (index) {
                        final isSelected = index == selectedCard;
                        return GestureDetector(
                          onTap: () {
                            context.read<CheckoutBloc>().add(
                              SelectPaymentCardEvent(index: index),
                            );
                            // setState(() => selectedCard = index);
                          },
                          child: Container(
                            width: 250,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  if (index == 0)
                                    Colors.green.shade800
                                  else
                                    Colors.teal.shade300,
                                  Colors.greenAccent,
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "VISA",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  cards[index]['number']!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  cards[index]['date']!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                if (isSelected)
                                  const Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "+ Add new",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<CheckoutBloc>().add(
                                SelectOtherPaymentMethodEvent(method: "GPay"),
                              );
                            },
                            child: paymentIcon(
                              "GPay",
                              selectedPaymentMethod == "GPay",
                              Icons.payments,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<CheckoutBloc>().add(
                                SelectOtherPaymentMethodEvent(method: "Apple"),
                              );
                            },
                            child: paymentIcon(
                              "Apple",
                              selectedPaymentMethod == "Apple",
                              Icons.phone_iphone,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<CheckoutBloc>().add(
                                SelectOtherPaymentMethodEvent(method: "PayPal"),
                              );
                            },
                            child: paymentIcon(
                              "PayPal",
                              selectedPaymentMethod == "PayPal",
                              Icons.account_balance_wallet,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Divider(thickness: 1),
                      priceRow("Subtotal (2 items)", price),
                      priceRow("Shipping cost", 0),
                      const Divider(thickness: 1),
                      priceRow("Total", price, isBold: true),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF03C27E),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  context.read<CheckoutBloc>().add(
                    PurchaseButtonPressedEvent(
                      name: name,
                      imageUrl: imageUrl,
                      price: price,
                    ),
                  );
                },
                child: const Text(
                  "Finalize Purchase",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

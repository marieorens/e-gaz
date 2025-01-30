import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:kkiapay_flutter_sdk/kkiapay_flutter_sdk.dart';
import 'package:egaz/pages_client/success_pay.dart';
import 'package:egaz/pages_client/failed_pay.dart';
import 'package:egaz/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

    void paymentCallback(Map<String, dynamic> response, BuildContext context) {
    switch (response['status']) {
      case PAYMENT_SUCCESS:
       Navigator.push(
                 context,
                   MaterialPageRoute(
                    builder: (context) =>  SuccessScreen(), 
                   ),
                    );
        break;
      case PAYMENT_CANCELLED:
        Navigator.push(
                 context,
                   MaterialPageRoute(
                    builder: (context) =>  FailureScreen(), 
                   ),
                    );
        break;
      default:
       
        break;
    }
  }

  void startPayment(BuildContext context, int amount) {
    final kkiapay = KKiaPay(
      amount: amount,
      countries: ["BJ", "CI", "SN", "TG"],
      phone: "",
      name: "",
      email: "",
      reason: 'Paiement de commande',
      sandbox: true,
      apikey: "0a9be610652111efbf02478c5adba4b8",
      callback: paymentCallback, 
      theme: "#222F5A",
      paymentMethods: ["momo", "card"],
    );

    

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => kkiapay),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        if (cart.items.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Mon Panier',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Votre panier est vide',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Mon Panier',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        'Vider le panier',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        'Voulez-vous vraiment vider votre panier ?',
                        style: GoogleFonts.poppins(),
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'Annuler',
                            style: GoogleFonts.poppins(),
                          ),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                        TextButton(
                          child: Text(
                            'Oui',
                            style: GoogleFonts.poppins(color: Colors.red),
                          ),
                          onPressed: () {
                            cart.clear();
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${cart.itemCount} élément${cart.itemCount > 1 ? 's' : ''}',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items.values.toList()[index];
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'ORYX',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${item.price} FCFA',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () => cart.updateQuantity(item.id, false),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Text(
                                            item.quantity.toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () => cart.updateQuantity(item.id, true),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  'Total: ${item.price * item.quantity} FCFA',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${cart.totalAmount} FCFA',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () => startPayment(context, cart.totalAmount),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Payer',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
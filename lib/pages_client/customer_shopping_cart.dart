import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kkiapay_flutter_sdk/kkiapay_flutter_sdk.dart';
import 'package:egaz/pages_client/success_pay.dart';
import 'package:egaz/pages_client/failed_pay.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int basePrice = 5200;
  List<int> quantities = [1, 2]; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
  void updateQuantity(int index, bool increment) {
    setState(() {
      if (increment) {
        quantities[index]++;
      } else if (quantities[index] > 0) {
        quantities[index]--;
      }
      _controller.forward(from: 0);
    });
  }

  
  int get totalPrice => quantities.fold(0, (sum, quantity) => sum + (basePrice * quantity));

  
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

  
  void startPayment(BuildContext context) {
    final kkiapay = KKiaPay(
      amount: totalPrice, 
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${quantities.fold(0, (sum, quantity) => sum + quantity)} éléments',
              style: GoogleFonts.poppins(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: quantities.length,
              itemBuilder: (context, index) {
                return CartItem(
                  quantity: quantities[index],
                  price: basePrice,
                  onIncrease: () => updateQuantity(index, true),
                  onDecrease: () => updateQuantity(index, false),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Text(
                          '${totalPrice.toString()} FCFA',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 5),
                OutlinedButton(
                  onPressed: () => startPayment(context), 
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
  }
}

class CartItem extends StatelessWidget {
  final int quantity;
  final int price;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItem({
    super.key,
    required this.quantity,
    required this.price,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
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
                  'Gaz oryx',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Taille: petite',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${price.toString()} FCFA',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: onDecrease,
                        ),
                        Text(
                          quantity.toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: onIncrease,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

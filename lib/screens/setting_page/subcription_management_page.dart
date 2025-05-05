import 'package:flutter/material.dart';

class SubscriptionManagementPage extends StatefulWidget {
  const SubscriptionManagementPage({super.key});

  @override
  State<SubscriptionManagementPage> createState() =>
      _SubscriptionManagementPageState();
}

class _SubscriptionManagementPageState
    extends State<SubscriptionManagementPage> {
  String _selectedPlan = "Yearly"; // Default selected plan
  String _currentPlan = "Free"; // Current plan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription Management"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentSubscriptionSection(),
            const SizedBox(height: 16),
            const Text("Become Premium",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildBenefitsList(),
            const SizedBox(height: 16),
            const Text("Choose your plan",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildPlanSelection(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showPaymentBottomSheet();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text(
                  "Upgrade to Premium",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentSubscriptionSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Current Plan",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          Text(
            _currentPlan, // Display the current plan
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsList() {
    final List<String> benefits = [
      "Access to 100+ soothing sounds and music",
      "500+ guided meditations",
      "Sleep tracking and analytics",
      "Personalized relaxation programs",
      "Priority customer support",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: benefits
          .map((benefit) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.teal),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        benefit,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildPlanSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPlanOption(
          title: "Monthly",
          price: "LKR 1,999 / month",
        ),
        _buildPlanOption(
          title: "Yearly",
          price: "LKR 22,999 / year",
        ),
      ],
    );
  }

  Widget _buildPlanOption({required String title, required String price}) {
    final bool isSelected = _selectedPlan == title;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPlan = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.teal),
            color: isSelected ? Colors.teal.shade100 : Colors.white,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSelected ? Colors.teal : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.teal : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Payment Details",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Card Number",
                  hintText: "Enter your card number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Expiration Date",
                  hintText: "MM/YY",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: "CVV",
                  hintText: "Enter CVV",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Cardholder Name",
                  hintText: "Enter cardholder name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle payment processing logic here
                  _processPayment();
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text(
                  "Complete Payment",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _processPayment() {
    // Simulate payment processing
    // In a real application, you would call your payment processing API here

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment Successful!')),
    );

    // Update the current plan based on the selected plan
    setState(() {
      _currentPlan = _selectedPlan; // Update the current plan
    });
  }
}

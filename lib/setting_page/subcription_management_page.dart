import 'package:flutter/material.dart';

class SubcriptionManagementPage extends StatefulWidget {
  const SubcriptionManagementPage({super.key});

  @override
  State<SubcriptionManagementPage> createState() =>
      _SubcriptionManagementPageState();
}

class _SubcriptionManagementPageState extends State<SubcriptionManagementPage> {
  String _selectedPlan = "Yearly";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subcription management"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentSubscriptionSection(),
            const SizedBox(
              height: 16,
            ),
            const Text("Become Premium",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 8,
            ),
            _buildBenefitsList(),
            const SizedBox(
              height: 16,
            ),
            const Text("Choose your plan",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildPlanSelection(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to payment or subscription confirmation page.........................
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Current Plan",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          Text(
            "Free",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
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
          price: "\$5.99 / month",
        ),
        _buildPlanOption(
          title: "Yearly",
          price: "\$69.99 / year",
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
              const SizedBox(
                height: 4,
              ),
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
}

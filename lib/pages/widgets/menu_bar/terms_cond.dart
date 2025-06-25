import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool _isAgreed = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: 
      Padding(padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to UpNext!',
              style: TextStyle(fontSize: 22,
              fontWeight: FontWeight.bold),),
              const SizedBox(height: 16),
              Text('Please read these Terms and Conditions carefully before using the UpNext app.',
              style: TextStyle(fontSize: 16),),
              SizedBox(height: 16),
              Text(
                '1. Acceptance of Terms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                const SizedBox(height: 8),
                const Text(
                  'By accessing or using the UpNext app, you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access the app.',
                ),
                const SizedBox(height: 16),
                const Text(
                  '2. Use of the App',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
              const Text(
                'You agree to use the app only for lawful purposes and in a way that does not infringe the rights of others.',
              ),
              const SizedBox(height: 16),
              const Text(
                '3. Intellectual Property',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'All content within the app is the property of UpNext or its licensors and is protected by copyright and intellectual property laws.',
              ),
              const SizedBox(height: 16),
              const Text(
                '4. Termination',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'We may terminate or suspend access to our app immediately, without prior notice or liability, for any reason whatsoever.',
              ),
              SizedBox(height: 32),
            ],
          ),
          
        ),
      ),
      
    );
    
  }
}
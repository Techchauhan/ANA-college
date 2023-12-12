import 'package:flutter/material.dart';



class Recruiter {
  final String companyName;
  final String logoUrl;
  final String description;

  Recruiter({
    required this.companyName,
    required this.logoUrl,
    required this.description,
  });
}



class PlacementScreen extends StatelessWidget {
  final List<Recruiter> recruiters = [
    Recruiter(
      companyName: 'Infosys',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo1.jpg',
      description: '',
    ),
    Recruiter(
      companyName: 'HP',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo2.jpg',
      description: '',
    ),Recruiter(
      companyName: 'Wipro',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo3.jpg',
      description: '',
    ),Recruiter(
      companyName: 'Google',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo4.jpg',
      description: '',
    ),Recruiter(
      companyName: 'Ford',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo5.jpg',
      description: '',
    ),Recruiter(
      companyName: 'UltraTech',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo6.jpg',
      description: '',
    ),Recruiter(
      companyName: 'HCL',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo7.jpg',
      description: '',
    ),Recruiter(
      companyName: 'HDFC Life',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo8.jpg',
      description: '',
    ),Recruiter(
      companyName: 'Ambuja Cement',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo9.jpg',
      description: '',
    ),Recruiter(
      companyName: 'ManKind',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo10.jpg',
      description: '',
    ),Recruiter(
      companyName: 'Airtel',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo11.jpg',
      description: '',
    ),Recruiter(
      companyName: 'Indusland Banks',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo12.jpg',
      description: '',
    ),Recruiter(
      companyName: 'IBM',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo12.png',
      description: '',
    ),Recruiter(
      companyName: 'Pizza Hut',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo13.png',
      description: '',
    ),Recruiter(
      companyName: 'Samsung',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo16.png',
      description: '',
    ),Recruiter(
      companyName: 'Yes Bank',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo24.png',
      description: '',
    ),Recruiter(
      companyName: 'Canon',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo30.png',
      description: '',
    ),Recruiter(
      companyName: 'Mahindra',
      logoUrl: 'https://www.anacollege.org/images/recruiter/logo40.png',
      description: '',
    ),
    // Add more recruiters as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Associated Recruiters'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: recruiters.length,
        itemBuilder: (BuildContext context, int index) {
          return RecruiterCard(recruiter: recruiters[index]);
        },
      ),
    );
  }
}

class RecruiterCard extends StatelessWidget {
  final Recruiter recruiter;

  RecruiterCard({required this.recruiter});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20,),
          Image.network(
            recruiter.logoUrl,
            height: 100.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              recruiter.companyName,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

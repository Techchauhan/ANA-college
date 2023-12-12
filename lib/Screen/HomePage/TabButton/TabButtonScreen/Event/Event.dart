import 'package:flutter/material.dart';

class Event {
  final String date;
  final String name;
  final String thumbnail;
  final String content;

  Event({
    required this.date,
    required this.name,
    required this.thumbnail,
    required this.content,
  });
}



class EventScreen extends StatelessWidget {
  final List<Event> events = [
    Event(
      date: 'November 30, 2023',
      name: 'National Conference on “Solar Energy For Sustainable Development',
      thumbnail: 'https://adminpanel.inventive.in/images/latest_news/5ea3ANA123coverimage.jpg',
      content: "   Ambition is the path to Success.. Persistence is the vehicle you Arrive in. Sharing some sweet moments of All India Seminar \n ANAGroupOfInstitutionsorganised National Conference on “Solar Energy For Sustainable Development”,Under the Aegis of Mechanical Engineering Division, IEI on 30th.November, 2023.It was an Honour to Listen &amp;amp; Learn from the eminent speakers: \n• Dr. PradeepChandra PantAdvisor SolarEnergy Society of IndiaEx Director MNRE\n• Mr. Abhilakh SinghAdvisor SolarEnergy Society of IndiaEx Director IREDA" ,
    ),
    Event(
      date: 'October 21, 2023',
      name: 'DANDIYA UTSAV 2023 at A.N.A Group Of Institutions',
      thumbnail: 'https://adminpanel.inventive.in/images/latest_news/9839ANA123coverimage.jpg',
      content: "Recollecting Glimpse of DANDIYA UTSAV 2023 at A.N.A Group Of Institutions, Bareilly. Let’s Spread Love &amp; Happiness Around!!A DAY FULL OF FUN, DANCE AND GOOD MEMORIES..",
    ),
    Event(
      date: 'March 4, 2023',
      name: 'Holi Carnival 2023',
      thumbnail: 'https://adminpanel.inventive.in/images/latest_news/9839ANA123coverimage.jpg',
      content: " Holi Festival 2023 Celebrate Holi Ke Rang A.N.A Ke Saang at your ANA Campus on 4th March 2023",
    ),
    Event(
      date: 'January 26, 2023',
      name: 'Basant Panchmi',
      thumbnail: 'https://adminpanel.inventive.in/images/latest_news/29deANA123IMG_20230126_113726.jpg',
      content: " Basant Panchmi Celebration 2023",
    ),
    // Add more events as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return EventCard(event: events[index]);
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            event.thumbnail,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.date,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  event.name,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  event.content,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HelpCenter extends StatefulWidget {
  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final List<Map<String, dynamic>> faq = [
  {
    'title': 'What is FotoIn?',
    'children': [
      {
        'title': 'FotoIn is a photography service that offers a wide range of photography services for personal and commercial needs, including graduation photos, pre-wedding, wedding events, birthdays, product photography, and more. FotoIn acts as a marketplace connecting professional and beginner photographers with users who need photography services.',
      },
    ],
  },
  {
    'title': 'What services does FotoIn offer?',
    'children': [
      {
        'title': 'FotoIn offers photography services for:\n- Graduation\n- Pre-wedding\n- Wedding events\n- Birthday parties\n- Product photography\n- Event photography\n- Family portraits\n- And more',
      },
    ],
  },
  {
    'title': 'How do I book FotoIn services?',
    'children': [
      {
        'title': 'You can book FotoIn services through our official mobile app or by contacting our customer service number. After that, you can choose a photographer that suits your needs and preferences.',
      },
    ],
  },
  {
    'title': 'What is included in the wedding photography package?',
    'children': [
      {
        'title': 'The wedding photography package usually includes:\n- Pre-wedding photo session\n- Documentation of the wedding day (from preparation to reception)\n- Exclusive photo album\n- High-resolution digital photos\n- Additional options like engagement photo sessions or wedding videos',
      },
    ],
  },
  {
    'title': 'Does FotoIn provide photo editing services?',
    'children': [
      {
        'title': 'Yes, all photos taken by photographers working with FotoIn will go through a professional editing process to ensure the best quality before being delivered to the client.',
      },
    ],
  },
  {
    'title': 'How long does it take to receive the photo results?',
    'children': [
      {
        'title': 'The photo processing time usually takes about 2-4 weeks, depending on the type and volume of services ordered.',
      },
    ],
  },
  {
    'title': 'Does FotoIn have its own photo studio?',
    'children': [
      {
        'title': 'Currently, FotoIn does not have its own photo studio. FotoIn functions as a marketplace connecting users with professional photographers who provide on-location photography services.',
      },
    ],
  },
  {
    'title': 'What if I want to do a photo shoot out of town?',
    'children': [
      {
        'title': 'FotoIn can accommodate out-of-town photo shoot requests with additional costs for transportation and accommodation for the photographer team included in the package. If you have other options, you can customize your request through our app.',
      },
    ],
  },
  {
    'title': 'Does FotoIn offer any discounts or special promotions?',
    'children': [
      {
        'title': 'FotoIn regularly offers discounts and special promotions. You can get the latest information by following our social media IG: @officialfotoin.',
      },
    ],
  },
  {
    'title': 'What is the cancellation policy?',
    'children': [
      {
        'title': 'Our cancellation policy states that cancellations made 7 days before the photo shoot date will incur a cancellation fee of 50% of the total cost. Cancellations made less than 7 days will not receive a refund.',
      },
    ],
  },
  {
    'title': 'Does FotoIn accept special requests or unique concepts for photo sessions?',
    'children': [
      {
        'title': 'Absolutely, FotoIn is very open to special requests and unique concepts. Our team will work with you and your chosen photographer to realize the ideas and concepts you want.',
      },
    ],
  },
];


    final List<Map<String, dynamic>> contact = [
        {
        'title': 'Email',
        'children': [
          {
            'title': ' officialfotoin@gmail.com',
          },
        ],
      },
      {
        'title': 'Whatsapp',
        'children': [
          {
            'title': '+62 821-6936-2588',
          },
        ],
      },
         {
        'title': 'Instagram',
        'children': [
          {
            'title': 'officialfotoin',
          },
        ],
      },
         {
        'title': 'Facebook',
        'children': [
          {
            'title': 'FotoIn Id',
          },
        ],
      },
  
  
  
  
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Help Center',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0.06,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Image.asset('assets/icons/arrow_back.png'),
        ),
        shadowColor: Color(0x14000000),
        toolbarHeight: 50,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: "FAQ"),
                Tab(text: "Contact Us"),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: faq.length,
                  itemBuilder: (context, index) {
                    final faqMethod = faq[index];
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      elevation: 4,
                      child: ExpansionTile(
                        title: Text(
                          faqMethod['title'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: faqMethod['children'] != null
                            ? faqMethod['children']
                                .map<Widget>((child) => ListTile(
                                      title: Text(
                                        child['title'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ))
                                .toList()
                            : [],
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: contact.length,
                  itemBuilder: (context, index) {
                    final contactMethod = contact[index];
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      elevation: 4,
                      child: ExpansionTile(
                        title: Text(
                          contactMethod['title'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: contactMethod['children'] != null
                            ? contactMethod['children']
                                .map<Widget>((child) => ListTile(
                                      title: Text(
                                        child['title'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ))
                                .toList()
                            : [],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.grey[800], fontSize: 16),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String locationMessage = "Click the button to see local news";
  List<Map<String, String>> localNewsArticles = [];
  List<Map<String, String>> worldNewsArticles = [
    {"title": "Global Summit", "content": "Highlights from the latest global summit."},
    {"title": "Economic Trends", "content": "An analysis of global economic trends."},
  ];
  List<Map<String, String>> sportsNewsArticles = [
    {"title": "Dodgers Win Championship", "content": "The Dodgers celebrate their championship victory."},
    {"title": "Shohei Ohtani Auction", "content": "Ohtani's 50-50 home run ball auctioned for 6 million."},
    {"title": "Excitement Over Ohtani's Win", "content": "Fans are ecstatic about Ohtani's successful season."},
  ];
  List<Map<String, String>> scienceNewsArticles = [
    {"title": "Space Discovery", "content": "New data from the latest space mission."},
    {"title": "Tech Innovations", "content": "Recent advancements in AI technology."},
  ];
  List<Map<String, String>> entertainmentNewsArticles = [
    {"title": "Movie Premiere", "content": "Reviews for the latest blockbuster."},
    {"title": "Celebrity Interview", "content": "An exclusive interview with a popular actor."},
  ];
  List<Map<String, String>> politicsNewsArticles = [
    {"title": "Election Results", "content": "Results from the latest election cycle."},
    {"title": "Trump vs. Harris: The 2024 Showdown", "content": "As the election approaches, Donald Trump and Kamala Harris engage in a heated debate over the future of America."},
    {"title": "Policy Changes", "content": "New policy changes and their impacts."},
  ];

  void _fetchNews() {
    setState(() {
      locationMessage = "Displaying local news";
      localNewsArticles = _fetchLocalNews();
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsCategoriesPage(
          localNews: localNewsArticles,
          worldNews: worldNewsArticles,
          sportsNews: sportsNewsArticles,
          scienceNews: scienceNewsArticles,
          entertainmentNews: entertainmentNewsArticles,
          politicsNews: politicsNewsArticles,
        ),
      ),
    );
  }

  List<Map<String, String>> _fetchLocalNews() {
    return [
      {"title": "Local Event Near You", "content": "A major event happening in your area."},
      {"title": "Weather Update", "content": "The weather in your region is sunny with clear skies."},
      {"title": "Community News", "content": "New community center opening soon nearby."},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchNews,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Show News Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text(
              locationMessage,
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Voice Command'),
                    content: Text('Voice command feature is not implemented yet.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.mic, color: Colors.white),
              label: Text(
                'Enter Voice Command',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Back',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 1) {
            if (Navigator.of(context).canPop()) {
              Navigator.pop(context);
            }
          }
        },
      ),
    );
  }
}

class NewsCategoriesPage extends StatelessWidget {
  final List<Map<String, String>> localNews;
  final List<Map<String, String>> worldNews;
  final List<Map<String, String>> sportsNews;
  final List<Map<String, String>> scienceNews;
  final List<Map<String, String>> entertainmentNews;
  final List<Map<String, String>> politicsNews;

  NewsCategoriesPage({
    required this.localNews,
    required this.worldNews,
    required this.sportsNews,
    required this.scienceNews,
    required this.entertainmentNews,
    required this.politicsNews,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Categories', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCategoryCard(context, 'Local News', localNews, Colors.blueAccent),
          _buildCategoryCard(context, 'World News', worldNews, Colors.greenAccent),
          _buildCategoryCard(context, 'Sports News', sportsNews, Colors.orangeAccent),
          _buildCategoryCard(context, 'Science News', scienceNews, Colors.purpleAccent),
          _buildCategoryCard(context, 'Entertainment News', entertainmentNews, Colors.pinkAccent),
          _buildCategoryCard(context, 'Politics News', politicsNews, Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, List<Map<String, String>> articles, Color color) {
    return Card(
      color: color.withOpacity(0.2),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color.withOpacity(0.7)),
        ),
        children: articles.map((article) {
          return ListTile(
            title: Text(article['title'] ?? ''),
            subtitle: Text(article['content'] ?? ''),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(article['title'] ?? ''),
                  content: Text(article['content'] ?? ''),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

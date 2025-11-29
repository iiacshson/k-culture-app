import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const KoreaApp());
}

class KoreaApp extends StatelessWidget {
  const KoreaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = const Color(0xFFE63946); // 약간 레드톤

    return MaterialApp(
      title: 'Korea Quiz & Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFDF7F7),
        cardTheme: const CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const QuizHomeScreen(),
      const DiscoverScreen(),
      const DrinkingGameScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: screens[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_bar_outlined),
            selectedIcon: Icon(Icons.local_bar),
            label: 'Games',
          ),
        ],
      ),
    );
  }
}

// ====================== Quiz Model ======================

enum QuizCategory {
  kFood,
  etiquette,
  kPopDrama,
  dailyLife,
  tradition,
}

extension QuizCategoryExt on QuizCategory {
  String get title {
    switch (this) {
      case QuizCategory.kFood:
        return 'K-Food';
      case QuizCategory.etiquette:
        return 'Korean Etiquette';
      case QuizCategory.kPopDrama:
        return 'K-POP & Drama';
      case QuizCategory.dailyLife:
        return 'Everyday Life';
      case QuizCategory.tradition:
        return 'Tradition';
    }
  }

  String get emoji {
    switch (this) {
      case QuizCategory.kFood:
        return '🍜';
      case QuizCategory.etiquette:
        return '🙏';
      case QuizCategory.kPopDrama:
        return '🎬';
      case QuizCategory.dailyLife:
        return '🚇';
      case QuizCategory.tradition:
        return '🏯';
    }
  }

  String get subtitle {
    switch (this) {
      case QuizCategory.kFood:
        return 'Korean food & drinks';
      case QuizCategory.etiquette:
        return 'Table manners & culture';
      case QuizCategory.kPopDrama:
        return 'Idols & drama stories';
      case QuizCategory.dailyLife:
        return 'Subway, payments, daily life';
      case QuizCategory.tradition:
        return 'Hanbok, hanok & holidays';
    }
  }

  Color get color {
    switch (this) {
      case QuizCategory.kFood:
        return const Color(0xFFFFC3A0);
      case QuizCategory.etiquette:
        return const Color(0xFFE0BBFF);
      case QuizCategory.kPopDrama:
        return const Color(0xFFFFA8C5);
      case QuizCategory.dailyLife:
        return const Color(0xFFA0E8FF);
      case QuizCategory.tradition:
        return const Color(0xFFB7E4C7);
    }
  }
}

class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final QuizCategory category;
  final String? explanation;

  Question({
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.category,
    this.explanation,
  });
}

// ====== 퀴즈 문제들 ======
final List<Question> allQuestions = [
  // K-Food
  Question(
    text:
    'Which Korean dish is made of fermented cabbage and is served as a side dish almost every day?',
    options: [
      'Bibimbap',
      'Kimchi',
      'Tteokbokki',
      'Samgyeopsal',
    ],
    correctIndex: 1,
    category: QuizCategory.kFood,
    explanation: "Kimchi (김치) is Korea's iconic fermented cabbage side dish.",
  ),
  Question(
    text: 'Samgyeopsal (삼겹살) is usually eaten with which of the following?',
    options: [
      'Rice only',
      'Bread and butter',
      'Lettuce wraps with side dishes',
      'Just salt and water',
    ],
    correctIndex: 2,
    category: QuizCategory.kFood,
    explanation:
    'Koreans usually wrap grilled pork belly in lettuce with sauce and side dishes.',
  ),
  Question(
    text: 'What is the spicy Korean rice cake dish that is popular as street food?',
    options: [
      'Tteokbokki',
      'Naengmyeon',
      'Sundubu-jjigae',
      'Japchae',
    ],
    correctIndex: 0,
    category: QuizCategory.kFood,
  ),
  Question(
    text:
    'Which of these is a cold noodle dish often eaten in summer in Korea?',
    options: [
      'Kimchi-jjigae',
      'Naengmyeon',
      'Budae-jjigae',
      'Dakgalbi',
    ],
    correctIndex: 1,
    category: QuizCategory.kFood,
  ),
  Question(
    text: 'What is "Chimaek" (치맥) in Korean food culture?',
    options: [
      'A type of soup',
      'Chicken and beer combo',
      'A dessert',
      'A breakfast meal',
    ],
    correctIndex: 1,
    category: QuizCategory.kFood,
    explanation: 'Chimaek is short for "chicken + maekju (beer)" - a beloved Korean combo.',
  ),
  Question(
    text: 'What is Bibimbap (비빔밥)?',
    options: [
      'Fried chicken',
      'Mixed rice with vegetables and sauce',
      'Grilled fish',
      'Spicy soup',
    ],
    correctIndex: 1,
    category: QuizCategory.kFood,
    explanation: 'Bibimbap means "mixed rice" - topped with vegetables, egg, and gochujang sauce.',
  ),
  Question(
    text: 'Which soup is traditionally eaten on birthdays in Korea?',
    options: [
      'Kimchi-jjigae',
      'Seaweed soup (Miyeokguk)',
      'Samgyetang',
      'Doenjang-jjigae',
    ],
    correctIndex: 1,
    category: QuizCategory.kFood,
    explanation: 'Miyeokguk (미역국) is eaten on birthdays to honor mothers who eat it after giving birth.',
  ),
  Question(
    text: 'What is the main ingredient of Sundubu-jjigae (순두부찌개)?',
    options: [
      'Beef',
      'Soft tofu',
      'Pork belly',
      'Chicken',
    ],
    correctIndex: 1,
    category: QuizCategory.kFood,
    explanation: 'Sundubu-jjigae is a spicy stew made with soft (uncurdled) tofu.',
  ),
  Question(
    text: 'What Korean food is known as "army stew" mixing Korean and American ingredients?',
    options: [
      'Galbi-jjim',
      'Budae-jjigae',
      'Doenjang-jjigae',
      'Gamjatang',
    ],
    correctIndex: 1,
    category: QuizCategory.kFood,
    explanation: 'Budae-jjigae originated after the Korean War, mixing spam, sausages with Korean ingredients.',
  ),
  Question(
    text: 'What is Soju (소주)?',
    options: [
      'Korean rice wine',
      'Korean distilled spirit (usually 16-20% alcohol)',
      'Korean beer',
      'Korean tea',
    ],
    correctIndex: 1,
    category: QuizCategory.kFood,
    explanation: 'Soju is Korea\'s most popular alcoholic drink, a clear distilled spirit.',
  ),
  Question(
    text: 'Which Korean dish consists of marinated beef short ribs?',
    options: [
      'Dakgalbi',
      'Galbi',
      'Bossam',
      'Jokbal',
    ],
    correctIndex: 1,
    category: QuizCategory.kFood,
    explanation: 'Galbi (갈비) refers to marinated and grilled beef or pork ribs.',
  ),
  Question(
    text: 'What is Kimbap (김밥)?',
    options: [
      'Fermented vegetables',
      'Seaweed rice rolls with fillings',
      'Spicy noodles',
      'Sweet rice cake',
    ],
    correctIndex: 1,
    category: QuizCategory.kFood,
    explanation: 'Kimbap is rice and various fillings rolled in dried seaweed - a popular snack and meal.',
  ),

  // Etiquette
  Question(
    text:
    'In Korea, how should you usually give or receive something from an older person to be polite?',
    options: [
      'With one hand, casually',
      'With both hands',
      'Throw it lightly',
      'Put it on the table and walk away',
    ],
    correctIndex: 1,
    category: QuizCategory.etiquette,
    explanation:
    'Using both hands shows respect, especially to older people in Korea.',
  ),
  Question(
    text:
    'When eating with older people in Korea, who should start eating first?',
    options: [
      'The youngest person',
      'Whoever is hungriest',
      'The oldest person',
      'Anyone, it doesn’t matter',
    ],
    correctIndex: 2,
    category: QuizCategory.etiquette,
  ),
  Question(
    text:
    'On the subway in Korea, what should you avoid doing in the priority seats?',
    options: [
      'Sleeping',
      'Listening to music',
      'Sitting if you are young and healthy',
      'Standing near the door',
    ],
    correctIndex: 2,
    category: QuizCategory.etiquette,
    explanation:
    'Priority seats are for the elderly, pregnant women, and disabled passengers.',
  ),
  Question(
    text:
    'When pouring alcohol for someone older in Korea, what is a polite gesture?',
    options: [
      'Pour with both hands and turn your body slightly',
      'Pour with one hand while using your phone',
      'Let them pour it themselves',
      'Refuse to pour at all',
    ],
    correctIndex: 0,
    category: QuizCategory.etiquette,
  ),
  Question(
    text: 'What should you do when drinking alcohol in front of elders in Korea?',
    options: [
      'Drink while making eye contact',
      'Turn your head away slightly while drinking',
      'Drink as fast as possible',
      'Leave the table to drink',
    ],
    correctIndex: 1,
    category: QuizCategory.etiquette,
    explanation: 'Turning away while drinking shows respect to elders in Korean culture.',
  ),
  Question(
    text: 'What does bowing (인사) represent in Korean culture?',
    options: [
      'Asking for money',
      'Respect and greeting',
      'Saying goodbye only',
      'Apologizing only',
    ],
    correctIndex: 1,
    category: QuizCategory.etiquette,
    explanation: 'Bowing is a sign of respect used for greetings, thanks, and apologies.',
  ),
  Question(
    text: 'Is it polite to tip at restaurants in Korea?',
    options: [
      'Yes, always 20%',
      'Yes, but only 10%',
      'No, tipping is not customary',
      'Only at expensive restaurants',
    ],
    correctIndex: 2,
    category: QuizCategory.etiquette,
    explanation: 'Tipping is not part of Korean culture and can sometimes be considered rude.',
  ),
  Question(
    text: 'What should you do when entering a Korean home?',
    options: [
      'Keep your shoes on',
      'Take off your shoes at the entrance',
      'Ask the host first',
      'Wear special indoor shoes you bring',
    ],
    correctIndex: 1,
    category: QuizCategory.etiquette,
    explanation: 'Removing shoes before entering a home is standard practice in Korea.',
  ),
  Question(
    text: 'How should you address someone older than you in Korea?',
    options: [
      'By their first name',
      'Using formal speech and appropriate titles',
      'By their nickname',
      'Just say "hey"',
    ],
    correctIndex: 1,
    category: QuizCategory.etiquette,
    explanation: 'Using formal language (존댓말) with elders shows respect.',
  ),
  Question(
    text: 'What is considered rude when using chopsticks in Korea?',
    options: [
      'Resting them on the bowl',
      'Sticking them upright in rice',
      'Using them to pick up food',
      'Holding them in your right hand',
    ],
    correctIndex: 1,
    category: QuizCategory.etiquette,
    explanation: 'Sticking chopsticks upright resembles funeral rituals and is considered very rude.',
  ),
  Question(
    text: 'When is it appropriate to start eating at a Korean meal?',
    options: [
      'Whenever you sit down',
      'After the eldest person takes the first bite',
      'After saying a prayer',
      'After everyone finishes ordering',
    ],
    correctIndex: 1,
    category: QuizCategory.etiquette,
    explanation: 'Waiting for the eldest to start eating first is a sign of respect.',
  ),

  // K-POP & Drama
  Question(
    text: 'Which of the following is a famous K-POP boy group?',
    options: [
      'BTS',
      'The Beatles',
      'One Direction',
      'Backstreet Boys',
    ],
    correctIndex: 0,
    category: QuizCategory.kPopDrama,
  ),
  Question(
    text: 'K-dramas are known for all of the following EXCEPT:',
    options: [
      '16-episode romantic stories',
      'Emotional OST (soundtracks)',
      'Very short 1-minute episodes only',
      'Beautiful filming locations',
    ],
    correctIndex: 2,
    category: QuizCategory.kPopDrama,
  ),
  Question(
    text:
    'Which platform is very popular for watching K-dramas legally with subtitles?',
    options: [
      'Netflix',
      'Only illegal streaming sites',
      'Microsoft Word',
      'Photoshop',
    ],
    correctIndex: 0,
    category: QuizCategory.kPopDrama,
  ),
  Question(
    text: 'What does "aegyo" (애교) mean in K-pop culture?',
    options: [
      'A dance move',
      'Acting cute or charming',
      'A type of song',
      'A fan club name',
    ],
    correctIndex: 1,
    category: QuizCategory.kPopDrama,
    explanation: 'Aegyo refers to a cute, childish way of acting often used by idols to charm fans.',
  ),
  Question(
    text: 'Which K-pop girl group is known for songs like "DDU-DU DDU-DU" and "Kill This Love"?',
    options: [
      'TWICE',
      'Red Velvet',
      'BLACKPINK',
      'ITZY',
    ],
    correctIndex: 2,
    category: QuizCategory.kPopDrama,
  ),
  Question(
    text: 'What is a "comeback" in K-pop?',
    options: [
      'When an idol returns from military service',
      'A new music release after a break',
      'A retirement announcement',
      'A concert tour',
    ],
    correctIndex: 1,
    category: QuizCategory.kPopDrama,
    explanation: 'In K-pop, "comeback" means releasing new music and promoting it on music shows.',
  ),
  Question(
    text: 'What is the name of BTS\'s official fan club?',
    options: [
      'BLINK',
      'ARMY',
      'ONCE',
      'EXO-L',
    ],
    correctIndex: 1,
    category: QuizCategory.kPopDrama,
  ),
  Question(
    text: 'Which Korean drama features a love story about a crash-landed South Korean heiress and a North Korean soldier?',
    options: [
      'Squid Game',
      'Crash Landing on You',
      'Goblin',
      'Itaewon Class',
    ],
    correctIndex: 1,
    category: QuizCategory.kPopDrama,
  ),
  Question(
    text: 'What does "OST" stand for in K-dramas?',
    options: [
      'Original Sound Track',
      'Only Singing Talent',
      'Official Song Title',
      'Online Streaming Time',
    ],
    correctIndex: 0,
    category: QuizCategory.kPopDrama,
    explanation: 'OST refers to the soundtrack music featured in Korean dramas.',
  ),
  Question(
    text: 'Which survival show produced the popular group Wanna One?',
    options: [
      'Show Me The Money',
      'Produce 101',
      'Kingdom',
      'I-Land',
    ],
    correctIndex: 1,
    category: QuizCategory.kPopDrama,
  ),
  Question(
    text: 'What is a "lightstick" in K-pop fan culture?',
    options: [
      'A flashlight app',
      'Official fan merchandise used at concerts',
      'A type of glow makeup',
      'A dancing prop',
    ],
    correctIndex: 1,
    category: QuizCategory.kPopDrama,
    explanation: 'Each K-pop group has uniquely designed lightsticks that fans wave at concerts.',
  ),
  Question(
    text: 'Which Netflix Korean series became a global phenomenon about a deadly children\'s game competition?',
    options: [
      'Kingdom',
      'All of Us Are Dead',
      'Squid Game',
      'Sweet Home',
    ],
    correctIndex: 2,
    category: QuizCategory.kPopDrama,
  ),

  // Everyday Life
  Question(
    text:
    'What is the most common way to pay in convenience stores in Korea?',
    options: [
      'Only cash',
      'Cash, credit card, or mobile payment',
      'Gold coins',
      'Checks',
    ],
    correctIndex: 1,
    category: QuizCategory.dailyLife,
  ),
  Question(
    text:
    'Which of these is TRUE about Korean convenience stores (편의점)?',
    options: [
      'They only sell snacks.',
      'You can heat food and eat it inside.',
      'They close at 9 PM.',
      'They do not sell drinks.',
    ],
    correctIndex: 1,
    category: QuizCategory.dailyLife,
  ),
  Question(
    text: 'T-Money card in Korea is mainly used for:',
    options: [
      'Online shopping only',
      'Subway, bus, and some stores',
      'Hotel booking only',
      'Paying taxes',
    ],
    correctIndex: 1,
    category: QuizCategory.dailyLife,
  ),
  Question(
    text: 'What color are most taxis in Seoul?',
    options: [
      'Yellow only',
      'Orange and silver',
      'Red',
      'Green',
    ],
    correctIndex: 1,
    category: QuizCategory.dailyLife,
    explanation: 'Regular taxis are orange, while deluxe taxis (모범택시) are black.',
  ),
  Question(
    text: 'What is "PC방" (PC bang)?',
    options: [
      'A phone store',
      'A gaming internet cafe',
      'A computer repair shop',
      'A music studio',
    ],
    correctIndex: 1,
    category: QuizCategory.dailyLife,
    explanation: 'PC bangs are internet gaming cafes popular for online gaming.',
  ),
  Question(
    text: 'What is "jjimjilbang" (찜질방)?',
    options: [
      'A restaurant',
      'A Korean spa and sauna',
      'A shopping mall',
      'A movie theater',
    ],
    correctIndex: 1,
    category: QuizCategory.dailyLife,
    explanation: 'Jjimjilbangs are public bathhouses with saunas where people relax and even sleep overnight.',
  ),
  Question(
    text: 'What does the number 4 represent in Korean culture?',
    options: [
      'Good luck',
      'Bad luck (associated with death)',
      'Wealth',
      'Love',
    ],
    correctIndex: 1,
    category: QuizCategory.dailyLife,
    explanation: 'The number 4 sounds like "death" in Korean, so many buildings skip the 4th floor.',
  ),
  Question(
    text: 'What is "배달" (baedal)?',
    options: [
      'A type of food',
      'Delivery service',
      'A greeting',
      'A holiday',
    ],
    correctIndex: 1,
    category: QuizCategory.dailyLife,
    explanation: 'Korea has one of the world\'s fastest and most convenient food delivery systems.',
  ),
  Question(
    text: 'What is special about Korean age (한국 나이)?',
    options: [
      'It\'s the same as international age',
      'You are 1 year old at birth and gain a year on New Year\'s',
      'You only count even years',
      'Age is calculated by the moon',
    ],
    correctIndex: 1,
    category: QuizCategory.dailyLife,
    explanation: 'Traditional Korean age counts you as 1 at birth (recently changed officially).',
  ),
  Question(
    text: 'What is "노래방" (noraebang)?',
    options: [
      'A dance club',
      'A karaoke room',
      'A concert hall',
      'A music school',
    ],
    correctIndex: 1,
    category: QuizCategory.dailyLife,
    explanation: 'Noraebangs are private karaoke rooms where groups sing together.',
  ),
  Question(
    text: 'What does the red and blue symbol (태극) on the Korean flag represent?',
    options: [
      'Fire and water',
      'Balance of opposite forces (yin and yang)',
      'North and South Korea',
      'Day and night',
    ],
    correctIndex: 1,
    category: QuizCategory.dailyLife,
    explanation: 'The Taegeuk symbol represents cosmic balance and harmony.',
  ),

  // Tradition
  Question(
    text: 'What is “hanbok (한복)”?',
    options: [
      'Traditional Korean clothing',
      'A Korean dessert',
      'A type of K-pop dance',
      'A traditional Korean house',
    ],
    correctIndex: 0,
    category: QuizCategory.tradition,
  ),
  Question(
    text:
    'What is the name of a traditional Korean house with wooden floors and tiled roofs?',
    options: [
      'Ramen',
      'Hanok',
      'Sushi',
      'Kimono',
    ],
    correctIndex: 1,
    category: QuizCategory.tradition,
  ),
  Question(
    text: 'Chuseok (추석) is often compared to which Western holiday?',
    options: [
      'Christmas',
      'Halloween',
      'Thanksgiving',
      "New Year's Eve",
    ],
    correctIndex: 2,
    category: QuizCategory.tradition,
  ),
  Question(
    text: 'What is Seollal (설날)?',
    options: [
      'Korean Thanksgiving',
      'Korean Lunar New Year',
      'Korean Independence Day',
      'Korean Christmas',
    ],
    correctIndex: 1,
    category: QuizCategory.tradition,
    explanation: 'Seollal is the Korean Lunar New Year, one of the most important holidays.',
  ),
  Question(
    text: 'What is "sebae" (세배)?',
    options: [
      'A traditional Korean dance',
      'A deep bow to elders on New Year',
      'A type of Korean food',
      'A Korean wedding ceremony',
    ],
    correctIndex: 1,
    category: QuizCategory.tradition,
    explanation: 'Sebae is a deep bow performed to elders on Seollal to show respect and receive blessings.',
  ),
  Question(
    text: 'What do Korean elders give children after sebae on Seollal?',
    options: [
      'Chocolate',
      'New clothes only',
      'Sebaetdon (New Year money)',
      'Rice cakes only',
    ],
    correctIndex: 2,
    category: QuizCategory.tradition,
    explanation: 'Children receive sebaetdon (세뱃돈), money in special envelopes, after performing sebae.',
  ),
  Question(
    text: 'What is "ondol" (온돌)?',
    options: [
      'A traditional Korean instrument',
      'Underfloor heating system',
      'A Korean martial art',
      'A type of Korean pottery',
    ],
    correctIndex: 1,
    category: QuizCategory.tradition,
    explanation: 'Ondol is the traditional Korean underfloor heating system used in hanok houses.',
  ),
  Question(
    text: 'What is Hangul Day (한글날) celebrating?',
    options: [
      'Korean independence',
      'The creation of the Korean alphabet',
      'The birthday of a famous king',
      'Korean harvest festival',
    ],
    correctIndex: 1,
    category: QuizCategory.tradition,
    explanation: 'Hangul Day celebrates the creation of the Korean alphabet by King Sejong in 1443.',
  ),
  Question(
    text: 'What is "pansori" (판소리)?',
    options: [
      'Traditional Korean narrative singing',
      'A Korean board game',
      'A type of Korean BBQ',
      'Korean calligraphy',
    ],
    correctIndex: 0,
    category: QuizCategory.tradition,
    explanation: 'Pansori is a traditional Korean musical storytelling performed by a singer and drummer.',
  ),
  Question(
    text: 'What is "samulnori" (사물놀이)?',
    options: [
      'A Korean card game',
      'Traditional percussion music with 4 instruments',
      'A Korean folk dance',
      'A type of Korean tea ceremony',
    ],
    correctIndex: 1,
    category: QuizCategory.tradition,
    explanation: 'Samulnori uses 4 traditional percussion instruments: kkwaenggwari, jing, janggu, and buk.',
  ),
  Question(
    text: 'What is "yutnori" (윷놀이)?',
    options: [
      'A Korean drinking game',
      'A traditional Korean board game played on holidays',
      'A type of Korean wrestling',
      'A Korean children\'s song',
    ],
    correctIndex: 1,
    category: QuizCategory.tradition,
    explanation: 'Yutnori is a traditional board game often played during Seollal and Chuseok.',
  ),
  Question(
    text: 'What is "jegichagi" (제기차기)?',
    options: [
      'Korean archery',
      'Kicking a shuttlecock-like object',
      'A Korean card game',
      'Traditional Korean wrestling',
    ],
    correctIndex: 1,
    category: QuizCategory.tradition,
    explanation: 'Jegichagi is a traditional game where players kick a jegi to keep it in the air.',
  ),
  Question(
    text: 'What is "ssireum" (씨름)?',
    options: [
      'Korean traditional wrestling',
      'Korean sword fighting',
      'Korean archery',
      'Korean horseback riding',
    ],
    correctIndex: 0,
    category: QuizCategory.tradition,
    explanation: 'Ssireum is traditional Korean wrestling where competitors try to throw each other down.',
  ),
  Question(
    text: 'What food is traditionally eaten during Chuseok?',
    options: [
      'Tteokguk (rice cake soup)',
      'Songpyeon (half-moon rice cakes)',
      'Jajangmyeon',
      'Samgyeopsal',
    ],
    correctIndex: 1,
    category: QuizCategory.tradition,
    explanation: 'Songpyeon are half-moon shaped rice cakes filled with sesame or beans, eaten during Chuseok.',
  ),
];

// ====================== Quiz Screens ======================

class QuizHomeScreen extends StatelessWidget {
  const QuizHomeScreen({super.key});

  void _startQuiz(BuildContext context, {QuizCategory? category}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizPlayScreen(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = QuizCategory.values;

    return Scaffold(
      body: Column(
        children: [
          // 상단 그라디언트 헤더
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Korea Culture Quiz',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Test your knowledge about K-food, K-POP,\nKorean etiquette, and daily life 🇰🇷',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _startQuiz(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFE63946),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                  ),
                  icon: const Icon(Icons.flash_on),
                  label: const Text(
                    'Start Random Quiz',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: const [
                Text(
                  'Pick a theme',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.lightbulb_outline,
                  size: 18,
                  color: Colors.orange,
                ),
                SizedBox(width: 4),
                Text(
                  'Short & fun quizzes',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: categories.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.05,
                ),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => _startQuiz(context, category: cat),
                    child: Container(
                      decoration: BoxDecoration(
                        color: cat.color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cat.emoji,
                            style: const TextStyle(fontSize: 26),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cat.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cat.subtitle,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 하단 배너 광고
          const AdBanner(),
        ],
      ),
    );
  }
}

class QuizPlayScreen extends StatefulWidget {
  final QuizCategory? category;
  const QuizPlayScreen({super.key, this.category});

  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  late List<Question> _questions;
  int _currentIndex = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedIndex;
  final Random _rand = Random();
  static const int _maxQuestions = 10;

  @override
  void initState() {
    super.initState();
    _prepareQuestions();
  }

  void _prepareQuestions() {
    List<Question> filtered = allQuestions;
    if (widget.category != null) {
      filtered =
          allQuestions.where((q) => q.category == widget.category).toList();
    }
    filtered.shuffle(_rand);
    if (filtered.length > _maxQuestions) {
      filtered = filtered.sublist(0, _maxQuestions);
    }
    _questions = filtered;
  }

  void _onOptionTap(int index) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedIndex = index;
      if (_questions[_currentIndex].correctIndex == index) {
        _score++;
      }
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      _goNext();
    });
  }

  void _goNext() {
    if (_currentIndex + 1 >= _questions.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              QuizResultScreen(score: _score, total: _questions.length),
        ),
      );
      return;
    }
    setState(() {
      _currentIndex++;
      _answered = false;
      _selectedIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentIndex];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == null
            ? 'Random Korea Quiz'
            : widget.category!.title),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LinearProgressIndicator(
              value: (_currentIndex + 1) / _questions.length,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Question ${_currentIndex + 1} / ${_questions.length}',
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Text(
                  q.text,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: q.options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final isSelected = _selectedIndex == index;
                final isCorrect = q.correctIndex == index;

                Color bg = Colors.white;
                Color border = Colors.grey.shade300;

                if (_answered) {
                  if (isCorrect) {
                    bg = const Color(0xFFDFF6DD);
                    border = const Color(0xFF2E7D32);
                  } else if (isSelected) {
                    bg = const Color(0xFFFFE0E0);
                    border = const Color(0xFFC62828);
                  }
                } else if (isSelected) {
                  bg = const Color(0xFFFFF3E0);
                  border = const Color(0xFFFFA726);
                }

                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => _onOptionTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: border),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            q.options[index],
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_answered && q.explanation != null)
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(
                  '💡 ${q.explanation}',
                  style: const TextStyle(fontSize: 12.5),
                ),
              ),
            ),
          const SizedBox(height: 8),
          const AdBanner(),
        ],
      ),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.total,
  });

  String _comment() {
    final r = score / total;
    if (r == 1) return 'Perfect! You\'re a true Korea expert! 🇰🇷';
    if (r >= 0.7) return 'Great job! You know a lot about Korea 😄';
    if (r >= 0.4) return 'Not bad. Try again and learn more about Korea!';
    return 'Good start! Play more and discover Korea 😉';
  }

  @override
  Widget build(BuildContext context) {
    final pct = ((score / total) * 100).round();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'Your Score',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            '$score / $total',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$pct%',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _comment(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const QuizHomeScreen()),
                      (route) => false,
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Play Again'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(46),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          const Spacer(),
          const AdBanner(),
        ],
      ),
    );
  }
}

// ====================== Discover (놀거리) Model ======================

class Place {
  final String name;
  final String area;
  final String category;
  final String shortDesc;
  final String detail;
  final List<String> tips;
  final List<String> tags;

  Place({
    required this.name,
    required this.area,
    required this.category,
    required this.shortDesc,
    required this.detail,
    required this.tips,
    required this.tags,
  });
}

// 예시 데이터
// 예시 데이터
final List<Place> places = [
  Place(
    name: 'Hongdae Night Street',
    area: 'Seoul',
    category: 'Nightlife',
    shortDesc: 'Live music, clubs, street performances, and youth culture.',
    detail:
    'Hongdae is one of the most vibrant areas in Seoul, famous for street performances, indie bands, clubs, and cute cafes. It is very popular among young locals and travelers. On weekend nights, the main streets are full of buskers and people.',
    tips: [
      'Best time: Friday & Saturday night.',
      'Watch street performances but keep your belongings safe.',
      'Many bars and clubs have no entrance fee before a certain time.',
    ],
    tags: ['Nightlife', 'Street', 'Music', 'Youth'],
  ),

  // ★ 성수동 추가
  Place(
    name: 'Seongsu-dong Cafes & Alleys',
    area: 'Seoul',
    category: 'Hip Area',
    shortDesc:
    'Trendy cafes, pop-up stores, and renovated factories loved by locals.',
    detail:
    'Seongsu-dong used to be an industrial area with shoe factories, but now it is one of the hottest neighborhoods in Seoul. Old factories have been turned into stylish cafes, bakeries, galleries, and pop-up shops. It is perfect for an afternoon cafe tour and photo walk.',
    tips: [
      'Weekdays are quieter; weekends can be very crowded.',
      'Many places are Instagram-friendly, but try to avoid blocking others when taking photos.',
      'Check pop-up events on social media before visiting.',
    ],
    tags: ['Cafes', 'Hip', 'Photo', 'Local'],
  ),

  // ★ 경복궁 추가
  Place(
    name: 'Gyeongbokgung Palace',
    area: 'Seoul',
    category: 'Palace',
    shortDesc:
    'The main royal palace of the Joseon Dynasty with beautiful traditional architecture.',
    detail:
    'Gyeongbokgung is one of the most important palaces in Korea. You can walk through large courtyards, wooden halls, and beautiful gates with mountain views in the background. Wearing hanbok (traditional clothing) gives you free entry, and there are special night openings on certain days.',
    tips: [
      'Check opening hours and possible night openings in advance.',
      'If you rent hanbok nearby, entrance is usually free.',
      'Try to visit earlier in the morning to avoid crowds and strong sun in summer.',
    ],
    tags: ['Palace', 'History', 'Photo', 'Hanbok'],
  ),

  Place(
    name: 'Gwangjang Market',
    area: 'Seoul',
    category: 'Food',
    shortDesc:
    'Traditional Korean market famous for street food like bindaetteok.',
    detail:
    'Gwangjang Market is one of the oldest traditional markets in Seoul. It is famous for mayak gimbap, bindaetteok (mung bean pancake), and yukhoe (Korean-style raw beef). It’s a great place to experience real Korean market vibes.',
    tips: [
      'Go hungry and try multiple foods.',
      'Bring some cash; some stalls may prefer it.',
      'Avoid peak lunch/dinner time if you hate crowds.',
    ],
    tags: ['Food', 'Market', 'Traditional'],
  ),

  Place(
    name: 'Bukchon Hanok Village',
    area: 'Seoul',
    category: 'Culture',
    shortDesc: 'Traditional Korean houses (hanok) in the middle of the city.',
    detail:
    'Bukchon Hanok Village is a beautiful area with traditional Korean houses. You can walk around small alleys, take photos, and visit small galleries and cafes. Some hanok offer hanbok rental or tea experiences.',
    tips: [
      'Be quiet: people actually live there.',
      'Wear comfortable shoes; there are many slopes.',
      'Morning visits are less crowded and better for photos.',
    ],
    tags: ['Culture', 'Traditional', 'Photo'],
  ),

  Place(
    name: 'Namsan Seoul Tower',
    area: 'Seoul',
    category: 'View',
    shortDesc: 'Famous tower with a panoramic night view of Seoul.',
    detail:
    'Namsan Tower (N Seoul Tower) offers a great night view of Seoul. A popular date spot with love locks and romantic atmosphere. You can go up by cable car or hiking.',
    tips: [
      'Sunset to night is the best time.',
      'Bring a jacket: it can be windy at the top.',
      'Avoid weekends if possible; it can be very crowded.',
    ],
    tags: ['View', 'Night', 'Date'],
  ),

  Place(
    name: 'Haeundae Beach',
    area: 'Busan',
    category: 'Beach',
    shortDesc: 'One of the most famous beaches in Korea, located in Busan.',
    detail:
    'Haeundae Beach is a long sandy beach with many hotels, cafes, and restaurants nearby. In summer it’s full of people, but even in other seasons, the sea view is beautiful.',
    tips: [
      'Check the weather before going.',
      'Visit nearby cafes with ocean view.',
      'In summer, prepare for big crowds.',
    ],
    tags: ['Beach', 'Busan', 'Relax'],
  ),

  Place(
    name: 'Gamcheon Culture Village',
    area: 'Busan',
    category: 'Culture',
    shortDesc: 'Colorful hillside village with art and murals.',
    detail:
    'Gamcheon Culture Village is a colorful village built on a hill, sometimes called “Korea’s Santorini.” There are murals, art shops, and beautiful viewpoints.',
    tips: [
      'Wear comfortable shoes; there are many stairs.',
      'Bring a camera for great photos.',
      'Follow the map to find all the photo spots.',
    ],
    tags: ['Photo', 'Art', 'Busan'],
  ),

  Place(
    name: 'Jeju Seongsan Ilchulbong',
    area: 'Jeju Island',
    category: 'Nature',
    shortDesc: 'UNESCO World Heritage site famous for sunrise view.',
    detail:
    'Seongsan Ilchulbong (Sunrise Peak) is a volcanic tuff cone on Jeju Island, very famous for its sunrise view. The hike is not too difficult, and the scenery is impressive.',
    tips: [
      'Go early for sunrise if the weather is good.',
      'Check bus or taxi schedules in advance.',
      'Bring water and comfortable shoes.',
    ],
    tags: ['Nature', 'Jeju', 'Hiking'],
  ),

  Place(
    name: 'Han River Park (Banpo, Yeouido, etc.)',
    area: 'Seoul',
    category: 'Relax',
    shortDesc: 'Popular place for picnic, chicken & beer by the river.',
    detail:
    'Han River parks are perfect for relaxing, riding a bike, or enjoying chicken & beer by the river. At Banpo, you can see the Rainbow Fountain show at the bridge.',
    tips: [
      'You can order food delivery directly to the park.',
      'Rent a bike if the weather is good.',
      'Bring a mat or buy one at nearby convenience stores.',
    ],
    tags: ['Relax', 'Picnic', 'View'],
  ),

  Place(
    name: 'Itaewon & Gyeongnidan-gil',
    area: 'Seoul',
    category: 'International',
    shortDesc: 'Multicultural area with diverse food, bars, and unique shops.',
    detail:
    'Itaewon is Seoul\'s most international neighborhood with restaurants from around the world, trendy bars, and diverse shops. Gyeongnidan-gil nearby offers cozy cafes and boutique stores in a quieter atmosphere.',
    tips: [
      'Great for finding international food you miss from home.',
      'Antique Furniture Street has unique vintage finds.',
      'Nightlife is vibrant on weekends.',
    ],
    tags: ['International', 'Food', 'Nightlife'],
  ),

  Place(
    name: 'Insadong',
    area: 'Seoul',
    category: 'Traditional',
    shortDesc: 'Traditional art, crafts, tea houses, and Korean souvenirs.',
    detail:
    'Insadong is the heart of Korean traditional culture in Seoul. The main street and alleys are filled with art galleries, antique shops, traditional tea houses, and souvenir stores selling hanbok accessories and Korean crafts.',
    tips: [
      'Visit Ssamziegil, a unique spiral shopping complex.',
      'Try traditional Korean tea at a tea house.',
      'Great place to buy authentic Korean souvenirs.',
    ],
    tags: ['Traditional', 'Shopping', 'Art'],
  ),

  Place(
    name: 'Myeongdong',
    area: 'Seoul',
    category: 'Shopping',
    shortDesc: 'Korea\'s biggest shopping district for cosmetics and fashion.',
    detail:
    'Myeongdong is the shopping mecca of Seoul, famous for Korean cosmetics brands, fashion, and street food. The area is always busy with tourists and locals alike, especially in the evenings.',
    tips: [
      'Many shops offer tax-free shopping for tourists.',
      'Try the famous street food like egg bread and tornado potato.',
      'Visit Myeongdong Cathedral, a beautiful historic church.',
    ],
    tags: ['Shopping', 'Cosmetics', 'Street Food'],
  ),

  Place(
    name: 'Dongdaemun Design Plaza (DDP)',
    area: 'Seoul',
    category: 'Architecture',
    shortDesc: 'Iconic futuristic building by Zaha Hadid, open 24 hours.',
    detail:
    'DDP is a landmark of Seoul designed by famous architect Zaha Hadid. The curved, futuristic building hosts exhibitions, fashion shows, and design markets. The LED Rose Garden at night is a popular photo spot.',
    tips: [
      'Visit at night to see the LED Rose Garden.',
      'Check for ongoing exhibitions and events.',
      'Dongdaemun shopping area nearby is open until late night.',
    ],
    tags: ['Architecture', 'Night', 'Photo'],
  ),

  Place(
    name: 'Jeonju Hanok Village',
    area: 'Jeonju',
    category: 'Traditional',
    shortDesc: 'Best preserved hanok village, famous for bibimbap.',
    detail:
    'Jeonju Hanok Village has over 700 traditional Korean houses and is the birthplace of bibimbap. Walk through beautiful alleys, try hanbok rental, and taste authentic Jeonju-style bibimbap and choco pie.',
    tips: [
      'Must try: Jeonju bibimbap and hand-made choco pie.',
      'Hanbok rental is popular here with many photo spots.',
      'Visit Gyeonggijeon Shrine for beautiful bamboo forest.',
    ],
    tags: ['Traditional', 'Food', 'Hanbok'],
  ),

  Place(
    name: 'Sokcho & Seoraksan',
    area: 'Gangwon',
    category: 'Nature',
    shortDesc: 'Coastal city with fresh seafood and stunning mountain views.',
    detail:
    'Sokcho is a beautiful coastal city near Seoraksan National Park. Enjoy fresh seafood at Sokcho Tourist Fish Market, take the cable car up Seoraksan for amazing views, and relax at Sokcho Beach.',
    tips: [
      'Take the Seoraksan cable car for easy mountain views.',
      'Try sundae (Korean blood sausage) at Abai Village.',
      'Best visited in autumn for fall foliage.',
    ],
    tags: ['Nature', 'Seafood', 'Mountain'],
  ),
];

// ====================== Discover Screens ======================

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 상단 헤더
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF84FAB0), Color(0xFF8FD3F4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Discover Korea',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Nightlife, food, traditional villages, beaches,\nperfect for your first Korea trip.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: places.length,
                itemBuilder: (context, index) {
                  final p = places[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlaceDetailScreen(place: p),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${p.area} · ${p.category}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              p.shortDesc,
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: -6,
                              children: p.tags
                                  .map(
                                    (t) => Chip(
                                  label: Text(
                                    t,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                                ),
                              )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const AdBanner(),
        ],
      ),
    );
  }
}

class PlaceDetailScreen extends StatelessWidget {
  final Place place;
  const PlaceDetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  place.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${place.area} · ${place.category}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  place.detail,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tips',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...place.tips.map(
                      (t) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• '),
                        Expanded(
                          child: Text(
                            t,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const AdBanner(),
        ],
      ),
    );
  }
}

// ====================== Drinking Games Model ======================

class DrinkingGame {
  final String name;
  final String koreanName;
  final String shortDesc;
  final String rules;
  final String players;
  final String difficulty;
  final List<String> tips;
  final List<String> tags;

  DrinkingGame({
    required this.name,
    required this.koreanName,
    required this.shortDesc,
    required this.rules,
    required this.players,
    required this.difficulty,
    required this.tips,
    required this.tags,
  });
}

final List<DrinkingGame> drinkingGames = [
  DrinkingGame(
    name: '3-6-9 Game',
    koreanName: '삼육구 게임',
    shortDesc:
    'Clap instead of saying numbers with 3, 6, or 9. Simple but gets fun (and fast).',
    rules:
    'Players sit in a circle. You count numbers one by one: 1, 2, 3, 4, 5, 6, ...\n'
        'Whenever the number has 3, 6, or 9, the player must CLAP instead of saying the number.\n'
        'Example: 1, 2, (clap), 4, 5, (clap), 7, 8, (clap), 10, 11, 12, 13 → clap.\n'
        'If someone says the number instead of clapping, or claps at the wrong time, they drink.',
    players: '3–10 people',
    difficulty: 'Easy',
    tips: [
      'Start slowly for foreigners, then speed up.',
      'You can add 6 and 9 only at first, then include 3 later to make it easier.',
    ],
    tags: ['Classic', 'Easy', 'Counting'],
  ),
  DrinkingGame(
    name: 'Baskin Robbins 31',
    koreanName: '바스킨라빈스 31',
    shortDesc:
    'Players say 1–3 numbers in order. Whoever says 31 drinks. Simple mind game.',
    rules:
    'Players take turns saying numbers in order, starting from 1.\n'
        'On your turn, you can say 1, 2, or 3 numbers in a row.\n'
        'Example: Player A: “1, 2” / Player B: “3, 4, 5” / Player C: “6” ...\n'
        'The player who ends up saying “31” loses and drinks.\n'
        'Strategy is to force the other player into bad positions near 28–31.',
    players: '2–6 people',
    difficulty: 'Medium',
    tips: [
      'If you can control the flow near 28–30, you can “target” someone.',
      'Good for 1:1 battle or “team vs team” style.',
    ],
    tags: ['Classic', 'Strategy', 'Counting'],
  ),
  DrinkingGame(
    name: 'Nunchi Game',
    koreanName: '눈치 게임',
    shortDesc:
    'Everyone shouts numbers in order without overlapping. If two people shout at the same time, they drink.',
    rules:
    'Players stand or sit together. The goal is to say numbers in order: 1, 2, 3, ...\n'
        'Anyone can say the next number at any time. BUT if two people say the same number at the same time, they lose and drink.\n'
        'If there is a long silence, you can tease someone to speak.',
    players: '3–10 people',
    difficulty: 'Easy',
    tips: [
      'Good icebreaker game with new people.',
      'You can set a goal number like “up to 20”, and whoever says the last number makes a rule.',
    ],
    tags: ['Party', 'Easy', 'Icebreaker'],
  ),
  DrinkingGame(
    name: 'King’s Game',
    koreanName: '왕게임',
    shortDesc:
    'One person becomes “King” and gives funny orders using numbers on sticks or paper.',
    rules:
    'Prepare sticks or small papers with numbers (1, 2, 3, 4...) and one “King” (왕) mark.\n'
        'Everyone picks one randomly and hides it.\n'
        'The person who got “King” shouts: “King gives an order!” and calls numbers like “No.2 and No.4 change seats!” or “No.1 drinks with No.3!”\n'
        'You can keep it light and fun, avoiding anything too uncomfortable.',
    players: '4–10 people',
    difficulty: 'Depends on rules',
    tips: [
      'Keep orders fun and harmless (e.g., make a toast, do a funny dance).',
      'Good with close friends, not recommended for work or serious settings.',
    ],
    tags: ['Party', 'Loud', 'Group'],
  ),
  DrinkingGame(
    name: 'Truth or Drink',
    koreanName: '진실 혹은 술',
    shortDesc:
    'Like “Truth or Dare”, but you choose either to answer honestly or drink.',
    rules:
    'Players sit in a circle.\n'
        'Take turns asking one person a personal or funny question.\n'
        'The player must choose: answer honestly OR take a drink.\n'
        'You can limit topics to keep it comfortable (e.g., “only travel stories” or “only work stories”).',
    players: '2–8 people',
    difficulty: 'Depends on questions',
    tips: [
      'Set boundaries first: what topics are NOT allowed.',
      'Good for close friends or couples, but be careful in mixed groups.',
    ],
    tags: ['Conversation', 'TMI', 'Close Friends'],
  ),
  DrinkingGame(
    name: 'Finger Game (Never Have I Ever)',
    koreanName: '손가락 게임 / 나는 ○○ 해본 적 없다',
    shortDesc:
    'Everyone puts up fingers. If you have done the thing, put one finger down and drink.',
    rules:
    'Everyone shows 5 or 10 fingers.\n'
        'Players take turns saying: “I have never ___ (e.g., traveled alone).”\n'
        'Anyone who HAS done it must fold one finger and take a sip.\n'
        'The first person to fold all fingers usually drinks more or loses.',
    players: '3–10 people',
    difficulty: 'Easy',
    tips: [
      'You can change the mood: from cute to spicy, depending on the group.',
      'Again, set a rule: no overly private or uncomfortable questions.',
    ],
    tags: ['Conversation', 'TMI', 'Party'],
  ),

  // ★ 요즘 아파트/집에서도 하기 좋은 조용한 게임들 추가

  DrinkingGame(
    name: 'Silent 007 Bang',
    koreanName: '조용한 007빵',
    shortDesc:
    'A quieter version of the classic 007 game, good for apartments or late-night.',
    rules:
    'Players sit in a circle and point at each other with their fingers.\n'
        'One person starts with “0”, the next says “0”, the next says “7” while pointing at someone. That person must quickly duck, and the people on both sides point and shout “Bang!”.\n'
        'In the “silent” version, players only move their hands and mouths (no loud shouting). Anyone who moves wrong, reacts late, or laughs drinks.',
    players: '4–10 people',
    difficulty: 'Medium',
    tips: [
      'Play with serious faces to make it funnier.',
      'Good when you want to play a game but not be too loud (e.g., in an apartment).',
    ],
    tags: ['Silent', 'Apartment', 'Classic'],
  ),
  DrinkingGame(
    name: 'Initial Consonant Game',
    koreanName: '초성 게임',
    shortDesc:
    'Pick Korean consonants and say words, dramas, or K-POP songs starting with them.',
    rules:
    'Choose a set of Korean consonants (for example, ㄱㅅ).\n'
        'Players take turns saying a word, drama title, or song title that matches the consonants.\n'
        'If someone cannot answer within a few seconds, repeats a word, or says something wrong, they drink.',
    players: '3–8 people',
    difficulty: 'Easy',
    tips: [
      'You can choose a theme like “K-POP only”, “food only”, or “drama titles only”.',
      'Make the time limit shorter as the game goes on to increase tension.',
    ],
    tags: ['Trend', 'Quiet', 'K-POP'],
  ),
  DrinkingGame(
    name: 'Phone Roulette',
    koreanName: '폰 룰렛',
    shortDesc:
    'Use a random wheel or roulette app to pick who drinks or gets a fun mission.',
    rules:
    'Everyone writes their name (or nickname) in a random-wheel app on a smartphone.\n'
        'Spin the wheel. The person selected must either drink or do a simple mission (make a toast, sing one line of a song, answer a question, etc.).\n'
        'You can change the missions to match the group mood — soft and funny for apartment gatherings.',
    players: '2–10 people',
    difficulty: 'Easy',
    tips: [
      'Great for small apartment parties using just one phone.',
      'Prepare a list of safe and funny missions in advance (no dangerous or uncomfortable dares).',
    ],
    tags: ['Phone', 'Apartment', 'Trend'],
  ),

  DrinkingGame(
    name: 'Image Game',
    koreanName: '이미지 게임',
    shortDesc:
    'Point at the person who best fits a description. Most votes drinks!',
    rules:
    'One person asks a question like: "Who would be most likely to become famous?" or "Who looks like they can\'t cook?"\n'
        'On the count of three, everyone points at the person they think fits best.\n'
        'The person who gets the most fingers pointed at them drinks.',
    players: '4–10 people',
    difficulty: 'Easy',
    tips: [
      'Keep questions fun and lighthearted.',
      'Avoid questions that could hurt feelings.',
      'Great for learning how friends see each other!',
    ],
    tags: ['Party', 'Fun', 'Group'],
  ),

  DrinkingGame(
    name: 'Soju Cap Game',
    koreanName: '소주 뚜껑 게임',
    shortDesc:
    'Twist the soju bottle cap tail and flick it off. The one who breaks it wins!',
    rules:
    'Open a soju bottle and twist the loose tail on the cap tightly.\n'
        'Players take turns flicking the twisted tail with their finger.\n'
        'The person who flicks it off (breaks it) wins — everyone else drinks!\n'
        'If you fail to break it, pass to the next person.',
    players: '2–6 people',
    difficulty: 'Easy',
    tips: [
      'Twist the cap tail tightly for best results.',
      'Classic Korean drinking game seen in many K-dramas!',
      'Some people guess the number under the cap too.',
    ],
    tags: ['Classic', 'Soju', 'Easy'],
  ),

  DrinkingGame(
    name: 'Up & Down Game',
    koreanName: '업다운 게임',
    shortDesc:
    'Guess a number between 1-50. "Up" or "Down" hints until someone gets it.',
    rules:
    'One person secretly picks a number between 1 and 50 (or 1-100).\n'
        'Other players take turns guessing. The picker says "Up" if the answer is higher, "Down" if lower.\n'
        'The person who guesses correctly makes everyone else drink, OR the person who guessed right before the correct answer drinks.',
    players: '3–10 people',
    difficulty: 'Easy',
    tips: [
      'You can change the rule: either the winner or the "almost winner" drinks.',
      'Speed up the game by reducing the number range.',
    ],
    tags: ['Classic', 'Easy', 'Quick'],
  ),

  DrinkingGame(
    name: 'Strawberry Game',
    koreanName: '딸기 게임',
    shortDesc:
    'Say "strawberry" in increasing syllables matching the beat. Miss and drink!',
    rules:
    'Players clap to a beat and take turns saying "strawberry" (딸기) with increasing syllables.\n'
        'Player 1: "Ddal-gi" (2 syllables)\n'
        'Player 2: "Ddal-gi ddal-gi" (4 syllables)\n'
        'Player 3: "Ddal-gi ddal-gi ddal-gi" (6 syllables)\n'
        'Continue until someone messes up the rhythm or syllables. They drink!',
    players: '3–8 people',
    difficulty: 'Medium',
    tips: [
      'Start slow and speed up gradually.',
      'You can use other words like "bbo-bbo" (kiss) for variety.',
      'Great for testing concentration after a few drinks!',
    ],
    tags: ['Rhythm', 'Fun', 'Classic'],
  ),
];


// ====================== Drinking Games Screens ======================

class DrinkingGameScreen extends StatelessWidget {
  const DrinkingGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 상단 헤더
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFBAB7E), Color(0xFFF7CE68)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Korean Drinking Games',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Learn fun party games Koreans play with soju & beer.\nPlease drink responsibly 🍻',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: drinkingGames.length,
                itemBuilder: (context, index) {
                  final g = drinkingGames[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DrinkingGameDetailScreen(game: g),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${g.name} (${g.koreanName})',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${g.players} · Difficulty: ${g.difficulty}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              g.shortDesc,
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: -6,
                              children: g.tags
                                  .map(
                                    (t) => Chip(
                                  label: Text(
                                    t,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                                ),
                              )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const AdBanner(),
        ],
      ),
    );
  }
}

class DrinkingGameDetailScreen extends StatelessWidget {
  final DrinkingGame game;
  const DrinkingGameDetailScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  '${game.name} (${game.koreanName})',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${game.players} · Difficulty: ${game.difficulty}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  game.rules,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tips',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...game.tips.map(
                      (t) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• '),
                        Expanded(
                          child: Text(
                            t,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '⚠️ Please drink responsibly.\nKnow your own limit and respect others.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          const AdBanner(),
        ],
      ),
    );
  }
}

class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      // 테스트 광고 ID 사용 (실제 배너 광고 단위 ID가 필요하면 여기서 변경하세요)
      // Android: ca-app-pub-3940256099942544/6300978111
      // iOS: ca-app-pub-3940256099942544/2934735716
      adUnitId: 'ca-app-pub-0035864962085153/7522104669', // Real AdMob banner
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const SizedBox(height: 52);
    }

    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
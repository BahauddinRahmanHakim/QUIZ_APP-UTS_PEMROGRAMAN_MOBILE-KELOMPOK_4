import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0; // Indeks pertanyaan saat ini
  int _score = 0; // Skor pengguna
  bool _quizCompleted = false; // Status apakah kuis telah selesai

  // Daftar pertanyaan dan jawaban
  final List<Map<String, Object>> _questions = [
    {
      'question': 'Apa kepanjangan dari HTML?',
      'answers': [
        {'text': 'Hypertext Markup Language', 'score': 10},
        {'text': 'Hypertext text Making Language', 'score': 0},
        {'text': 'Hypertext Modern Language', 'score': 0},
      ],
    },
    {
      'question': 'Dalam konsep OOP, apa itu enkapsulasi?',
      'answers': [
        {'text': 'Kemampuan untuk suatu objek mengambil bentuk', 'score': 0},
        {'text': 'Encapsulation adalah teknik yang menggabungkan beberapa objek menjadi satu tanpa aturan akses.', 'score': 0},
        {'text': 'Kemampuan untuk menyembunyikan detail internal objek dan menyediakan interface untuk berinteraksi dengannya', 'score': 10},
      ],
    },
    {
      'question': 'Apa elemen JavaScript yang merepresentasikan nilai TRUE atau FALSE?',
      'answers': [
        {'text': 'Boolean', 'score': 10},
        {'text': 'Event', 'score': 0},
        {'text': 'Condition', 'score': 0},
      ],
    },
    {
      'question': 'Dalam Python, Anda dapat menggunakan file yang sudah ada sebelumnya dengan ekstensi \'.py\' yang mengimplementasikan sekumpulan fungsi sekaligus. Apa nama file-file ini?',
      'answers': [
        {'text': 'Packages', 'score': 0},
        {'text': 'Operators', 'score': 0},
        {'text': 'Modules', 'score': 10},
      ],
    },
    {
      'question': 'Fungsi mana yang sering digunakan untuk menampilkan values dan print text?',
      'answers': [
        {'text': 'print()', 'score': 10},
        {'text': 'output()', 'score': 0},
        {'text': 'write()', 'score': 0},
      ],
    },
    {
      'question': 'Apa kepanjangan dari CSS?',
      'answers': [
        {'text': 'Centralized Style Sheet', 'score': 0},
        {'text': 'Cascading Style Sheet', 'score': 10},
        {'text': 'Computer Style Sheet', 'score': 0},
      ],
    },
    {
      'question': 'Operator mana yang dapat digunakan untuk membandingkan dua values?',
      'answers': [
        {'text': '==', 'score': 10},
        {'text': '=', 'score': 0},
        {'text': '<>', 'score': 0},
      ],
    },
    {
      'question': 'Keyword apa yang digunakan untuk mereturn value di dalam sebuah fungsi?',
      'answers': [
        {'text': 'get', 'score': 0},
        {'text': 'void', 'score': 0},
        {'text': 'return', 'score': 10},
      ],
    },
    {
      'question': 'Dari statement berikut mana yang digunakan untuk memilih salah satu dari sekian banyak code blocks untuk dieksekusi?',
      'answers': [
        {'text': 'switch', 'score': 10},
        {'text': 'break', 'score': 0},
        {'text': 'default', 'score': 0},
      ],
    },
    {
      'question': 'Dari Keyword berikut mana yang digunakan untuk membuat structure?',
      'answers': [
        {'text': 'structure', 'score': 0},
        {'text': 'struct', 'score': 10},
        {'text': 'str', 'score': 0},
      ],
    },
  ];

  // Fungsi untuk menangani jawaban pengguna
  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _quizCompleted = true;
      }
    });
  }

  // Fungsi untuk mereset kuis ke kondisi awal
  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gambar latar belakang
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Konten utama
          Column(
            children: [
              SizedBox(height: 50),
              if (!_quizCompleted) _buildProgressIndicator(),
              Expanded(
                child: Center(
                  child: _quizCompleted
                      ? _buildResultScreen()
                      : _buildQuizScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Membuat indikator progres
  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: LinearProgressIndicator(
        value: (_currentQuestionIndex + 1) / _questions.length,
        backgroundColor: Colors.white,
        color: Colors.blueAccent,
        minHeight: 8,
      ),
    );
  }

  // Membuat layar kuis
  Widget _buildQuizScreen() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (widget, animation) {
        return FadeTransition(opacity: animation, child: widget);
      },
      child: Column(
        key: ValueKey<int>(_currentQuestionIndex),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _questions[_currentQuestionIndex]['question'] as String,
              style: TextStyle(fontSize: 22, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          ...(_questions[_currentQuestionIndex]['answers']
                  as List<Map<String, Object>>)
              .map(
                (answer) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _answerQuestion(answer['score'] as int),
                    child: Text(
                      answer['text'] as String,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  // Membuat layar hasil kuis
  Widget _buildResultScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Kuis Selesai!',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Skor Anda: $_score',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          onPressed: _resetQuiz,
          child: Text('Coba Lagi', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}

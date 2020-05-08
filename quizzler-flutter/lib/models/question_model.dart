class QuestionModel {
  final String question;
  final String answer;
  final List<String> options;

  QuestionModel({
    this.question,
    this.answer,
    this.options,
  });

  // {
  //    "question": "Which is the tallest mountain in the world?",
  //    "answer": "Mt.Everest",
  //    "options": [
  //      "Mt.Everest",
  //      "K2",
  //      "Annapurna",
  //      "Dhaulagiri"
  //    ]
  //  }
  // What we're doing here is mapping each json keys into our object.
  // This is called deserialization.
  //
  // Here is a quick tool to generate these (https://app.quicktype.io/).
  factory QuestionModel.fromMap(Map<String, dynamic> questionMap) {
    return QuestionModel(
      question: questionMap['question'],
      answer: questionMap['answer'],
      // Here value of 'options' key is a List<dynamic>, and we're creating list of string from that.
      options: List<String>.from(questionMap['options'] as List),
    );
  }
}

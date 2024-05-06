import 'quiz_model.dart';

final levels = [
  QuizLevel(questions: [
    // Level 1 Questions
    Question(
        questionText:
            "What is the significance of the principle of explosion in formal logic?",
        options: [
          "It demonstrates the limitations of deductive reasoning.",
          "It establishes the decidability of formal systems.",
          " It allows for the derivation of any conclusion from a contradiction.",
          "It provides a method for resolving paradoxes."
        ],
        answerIndex: 2),
    Question(
        questionText:
            "Which logical fallacy occurs when a conclusion is drawn from premises that do not logically support it, but the conclusion is emotionally appealing?",
        options: [
          "Red Herring",
          "Appeal to Emotion",
          " False Cause",
          "Composition"
        ],
        answerIndex: 1),
    Question(
        questionText:
            "What is the distinction between soundness and completeness in formal logic?",
        options: [
          "oundness refers to the ability of a formal system to prove all true statements, while completeness refers to the absence of contradictions.",
          "Soundness refers to the absence of contradictions, while completeness refers to the ability of a formal system to prove all true statements.",
          "Soundness and completeness are synonymous terms in formal logic.",
          "None of the above"
        ],
        answerIndex: 1),
    Question(
        questionText:
            "Which of the following scenarios best exemplifies the application of formal logic?",
        options: [
          "Analyzing the chemical composition of a new compound",
          "Evaluating the effectiveness of a marketing campaign",
          "Designing a computer program to detect contradictions in legal documents",
          "Studying the behavior of subatomic particles"
        ],
        answerIndex: 2),
    Question(
        questionText:
            "How can formal logic be utilized in artificial intelligence (AI) systems?",
        options: [
          "To generate creative ideas for problem-solving",
          "To model human emotions and social interactions",
          "To reason and make decisions based on logical rules and constraints",
          "To analyze trends in financial markets"
        ],
        answerIndex: 2),
    Question(
        questionText: "In formal logic, what is the purpose of a truth table?",
        options: [
          "To represent the results of an experiment",
          "To show the relationship between premises and conclusions",
          "To evaluate the truth values of logical expressions",
          "To demonstrate the validity of a deductive argument"
        ],
        answerIndex: 2),
    Question(
        questionText:
            "Which aspect of formal logic is particularly relevant in the development of compilers and interpreters?",
        options: [
          "Modal logic",
          "Temporal logic",
          " Predicate logic",
          "Propositional logic"
        ],
        answerIndex: 3),
    Question(
        questionText: "How does formal logic contribute to software testing?",
        options: [
          "By designing user interfaces for software applications",
          " By generating test cases based on logical specifications and requirements",
          "By analyzing user feedback and reviews",
          "By optimizing database queries for performance"
        ],
        answerIndex: 1),
    Question(
        questionText:
            "In software engineering, what role does formal logic play in the verification of software correctness?",
        options: [
          "It helps in creating graphical user interfaces (GUIs) for software applications.",
          " It assists in optimizing code for better performance.",
          "It enables the formal specification of software requirements and properties.",
          " It facilitates the deployment of software on cloud platforms."
        ],
        answerIndex: 2),
    Question(
        questionText:
            "Which area of computer science heavily relies on formal logic to reason about the behavior of concurrent systems and protocols?",
        options: [
          "Cybersecurity",
          "Database management",
          "Distributed systems",
          "Mobile app development"
        ],
        answerIndex: 2),
  ]),
];

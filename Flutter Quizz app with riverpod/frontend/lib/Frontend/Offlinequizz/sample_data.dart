import 'quiz_model.dart';

final levels = [
  QuizLevel(questions: [
    // Level 1 Questions
    Question(
        questionText:
            "If it rains, then the ground is wet. Which of the following best represents the logical form of this statement?",
        options: ["P → Q", "Q → P", "P ∧ Q", "P ∨ Q"],
        answerIndex: 0),
    Question(
        questionText:
            "What is the negation of the statement- All birds can fly?",
        options: [
          "No birds can fly.",
          "Some birds cannot fly.",
          "All birds cannot fly.",
          "Some birds can fly."
        ],
        answerIndex: 1),
    Question(
        questionText:
            "Which of the following statements is logically equivalent to- If it is not raining, then I will not go outside.?",
        options: [
          "If I go outside, then it is raining.",
          "It is raining and I am going outside.",
          "It is not raining or I am not going outside.",
          "None of The above"
        ],
        answerIndex: 2),
    Question(
        questionText: "Which of the following is an example of modus ponens?",
        options: [
          "If P then Q. Not P. Therefore, not Q.",
          " If P then Q. P. Therefore, Q.",
          "If P then Q. Not Q. Therefore, not P.",
          " If P then Q. Q. Therefore, P."
        ],
        answerIndex: 1),
    Question(
        questionText: "Which of the following is an example of modus tollens?",
        options: [
          "If P then Q. P. Therefore, Q.",
          " If P then Q. Q. Therefore, P.",
          " If P then Q. Not P. Therefore, not Q.",
          "If P then Q. Not Q. Therefore, not P."
        ],
        answerIndex: 3),
    Question(
        questionText:
            "Which logical fallacy is present in the argument -All wealthy people are happy; John is not wealthy, therefore, John is not happy?",
        options: [
          "Affirming the consequent",
          "Denying the antecedent",
          "Ad hominem",
          "False dilemma"
        ],
        answerIndex: 1),
    Question(
        questionText:
            "What is the converse of the statement- All cats are mammals?",
        options: [
          "No cats are mammals.",
          "Some cats are not mammals.",
          "All mammals are cats.",
          "Some mammals are cats."
        ],
        answerIndex: 2),
    Question(
        questionText:
            "Which of the following illustrates a disjunctive syllogism?",
        options: [
          "Either P or Q. Not P. Therefore, Q.",
          "Either P or Q. P. Therefore, not Q.",
          "If P then Q. P. Therefore, Q.",
          "If P then Q. Not Q. Therefore, not P."
        ],
        answerIndex: 0),
    Question(
        questionText: "Which of the following statements is a tautology?",
        options: [
          " If it is sunny, then it is not raining.",
          "It is either raining or it is not raining.",
          " If it is raining, then the grass is green.",
          "None of the above"
        ],
        answerIndex: 1),
    Question(
        questionText:
            "Which of the following statements represents a contradiction?",
        options: [
          "The door can be open and closed at the same time.",
          "If the light is on, then the room is not dark.",
          "All roses are flowers, and some flowers are not roses.",
          " Water boils at 100°C at sea level."
        ],
        answerIndex: 0),
  ]),
  QuizLevel(questions: [
    // Level 2 Questions
    Question(
        questionText:
            "What is the inverse of the statement- If it rains, then the ground is wet?",
        options: [
          "If it does not rain, then the ground is not wet.",
          "If the ground is not wet, then it does not rain.",
          "If it rains, then the ground is not wet.",
          "If the ground is wet, then it rains."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "The biconditional statement - A book is interesting if and only if it is a bestseller is true. Which of the following must be true?",
        options: [
          "All interesting books are bestsellers.",
          "Some bestsellers are not interesting.",
          "All bestsellers are interesting.",
          "Both A and C are true."
        ],
        answerIndex: 3),
    Question(
        questionText: "Apply De Morgan’s laws to the statement ¬(P ∧ Q).",
        options: ["¬P ∧ ¬Q", "¬P ∨ ¬Q", "P ∨ Q", "P ∧ Q"],
        answerIndex: 1),
    Question(
        questionText:
            "Which statement correctly identifies a necessary condition?",
        options: [
          "Having wings is necessary to be a bird.",
          "Being a mammal is sufficient for having hair.",
          "To win the race, it is necessary to run fast.",
          "Drinking water is sufficient for quenching thirst."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "In predicate logic, what does the statement ∀x(P(x) → Q(x)) imply?",
        options: [
          "For all x, if x has property P, then x also has property Q.",
          "There exists an x such that P(x) and not Q(x).",
          " For some x, P(x) implies Q(x).",
          "If any x has property Q, then x has property P."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "Which example shows the fallacy of affirming the consequent?",
        options: [
          "If it is a dog, then it has four legs. It has four legs, therefore it is a dog.",
          "If it rains, the ground gets wet. The ground is not wet, so it did not rain.",
          "All men are mortal. Socrates is a man. Therefore, Socrates is mortal.",
          "None of the above."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "Which statement correctly applies existential introduction in predicate logic?",
        options: [
          "Since some birds can fly, there exists an animal that can fly.",
          "Because all humans can think, there exists a creature that can think.",
          "Given that all dogs bark, there exists a dog that does not bark.",
          "If some fruits are sweet, then all fruits are sweet."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "From observing that every swan in a sample of 100 swans is white, one might infer:",
        options: [
          "All swans are white.",
          "Some swans are not white.",
          "There exists a swan that is not white.",
          "Most swans are white."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "Which statement is equivalent to the negation of- The door is open and the light is on?",
        options: [
          "The door is not open or the light is not on.",
          "The door is closed and the light is off.",
          "The door is not open and the light is not on.",
          "The door is open or the light is on."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "Which statement best exemplifies the use of the exclusive or (XOR) logical operator?",
        options: [
          "You can have tea or coffee, but not both.",
          "If it is raining, then the ground is wet.",
          "All dogs are mammals, and all mammals are animals.",
          "The store is open if it is not a holiday."
        ],
        answerIndex: 0),
  ]),
  QuizLevel(questions: [
    // Level 3 Questions
    Question(
        questionText:
            "If all cats are mammals, and no mammals can fly, which of the following conclusions is logically valid?",
        options: [
          "Some cats can fly.",
          "No cats can fly.",
          "All cats can fly.",
          "Some mammals are not cats."
        ],
        answerIndex: 1),
    Question(
        questionText:
            "If there exists a cat that loves to swim, which of the following statements must be true?",
        options: [
          "All cats love to swim.",
          "No cats love to swim.",
          "Some cats love to swim.",
          "Swimming is loved by all mammals."
        ],
        answerIndex: 2),
    Question(
        questionText:
            "If Whiskers is a cat, then Whiskers dislikes water. Whiskers is a cat. Which of the following conclusions is logically valid?",
        options: [
          "Whiskers dislikes water.",
          "Whiskers likes water.",
          "Whiskers is not a cat.",
          "All cats like water."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "If every cat hates cucumbers and Tom is a cat, which of the following must be true?",
        options: [
          "Tom hates cucumbers.",
          "Tom loves cucumbers.",
          "Some cats like cucumbers.",
          "No conclusion can be drawn about Tom."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "If all cats are furry, then no non-furry animals are cats. Which of the following is the contrapositive and therefore logically equivalent?",
        options: [
          "If some animals are not furry, they are not cats.",
          "All non-furry animals are cats.",
          "If an animal is not a cat, it is not furry.",
          "If an animal is furry, it is a cat."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "Either Max is a cat that likes fish or Max is a cat that likes chicken. Max does not like chicken. Which conclusion follows?",
        options: [
          "Max likes fish.",
          "Max does not like fish.",
          "Max is not a cat.",
          "Max likes both fish and chicken."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "Muffin either plays with yarn or sleeps during the afternoon, but not both. If Muffin is playing with yarn, which of the following must be true?",
        options: [
          "Muffin does not sleep during the afternoon.",
          "Muffin sleeps during the afternoon.",
          "Muffin neither plays with yarn nor sleeps.",
          "Muffin plays with yarn and sleeps."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "Which of the following is the negation of- All cats are nocturnal?",
        options: [
          "No cats are nocturnal.",
          "Some cats are not nocturnal.",
          "All cats are diurnal.",
          "Some cats are nocturnal."
        ],
        answerIndex: 1),
    Question(
        questionText:
            "If a cat eats only fish, then it does not eat chicken. Fluffy eats only fish. Which of the following conclusions is logically valid?",
        options: [
          "Fluffy does not eat chicken.",
          "Fluffy eats chicken.",
          "Fluffy eats both fish and chicken.",
          "No conclusion can be drawn about Fluffy's diet."
        ],
        answerIndex: 0),
    Question(
        questionText:
            "A cat is happy if and only if it is purring. Ginger is purring. What can be concluded?",
        options: [
          " Ginger is happy.",
          "Ginger is not happy.",
          "Ginger is both happy and not happy.",
          "No conclusion can be drawn about Ginger's emotional state."
        ],
        answerIndex: 0),
  ]),
];

package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type Question struct {
	QuestionText string   `bson:"questionText"`
	Options      []string `bson:"options"`
	AnswerIndex  int      `bson:"answerIndex"`
}

var seedQuestions = []Question{
	{
		QuestionText: "Define a proposition in logic.",
		Options:      []string{"An inquiry", "A true/false statement", "A formula", "A theory"},
		AnswerIndex:  1,
	},
	{
		QuestionText: "Basic operators in logic?",
		Options:      []string{"+ - * /", "& % # @", "NOT, AND, OR, implies, bi-conditional", "= < >"},
		AnswerIndex:  2,
	},
	{
		QuestionText: "What does the AND operator signify in propositional logic?",
		Options:      []string{"A logical division, then it does not rain", "A logical subtraction", "A logical conjunction", "A logical multiplication"},
		AnswerIndex:  2,
	},
	{
		QuestionText: "OR operator in propositional logic?'",
		Options:      []string{"True if both false", "True if both true", "True if one is true", "False if both true"},
		AnswerIndex:  2,
	},
	{
		QuestionText: "'What is the role of the NOT operator in propositional logic?",
		Options:      []string{"To duplicate the truth value of a proposition", "To negate a proposition", "To confirm the truth value of a proposition", "To divide a proposition"},
		AnswerIndex:  1,
	},
	{
		QuestionText: "Explain the implication (→) operator in propositional logic.",
		Options:      []string{"True if both false", "False if both true", "False if first true, second false", "None above"},
		AnswerIndex:  2,
	},
	{
		QuestionText: "What is a bi-conditional operator in propositional logic?",
		Options:      []string{"Signifies a logical addition", "Signifies equivalence between two propositions", "Signifies a logical multiplication", "None of the above"},
		AnswerIndex:  1,
	},
	{
		QuestionText: "Propositional logic example?",
		Options:      []string{"Projectile trajectory", "Route planning with traffic", "Validating an argument", "None above"},
		AnswerIndex:  2,
	},
	{
		QuestionText: "In a truth table, what does a row with all 'true' values for the input propositions represent?",
		Options:      []string{"A tautology", "A contradiction", "An invalid argument", "A logical fallacy"},
		AnswerIndex:  0,
	},
	{
		QuestionText: "Choose the conclusion that logically follows: 'No animals are plants. All dogs are animals.'",
		Options:      []string{"No dogs are plants", "Some dogs are not plants", "All dogs are plants", "None of the above"},
		AnswerIndex:  0,
	},
}

func main() {
	clientOptions := options.Client().ApplyURI("mongodb://localhost:27017")
	client, err := mongo.Connect(context.Background(), clientOptions)
	if err != nil {
		log.Fatal(err)
	}
	defer client.Disconnect(context.Background())

	if len(os.Args) > 1 && os.Args[1] == "seed" {
		seedDB(client)
		return
	}

	http.HandleFunc("/questions", getQuestions(client))
	fmt.Println("Server is running on port 5000")
	log.Fatal(http.ListenAndServe(":5000", nil))
}

func getQuestions(client *mongo.Client) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodGet {
			http.Error(w, "Unsupported HTTP method", http.StatusMethodNotAllowed)
			return
		}

		collection := client.Database("myApp").Collection("questions")
		cursor, err := collection.Find(context.Background(), bson.D{})
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer cursor.Close(context.Background())

		var questions []Question
		if err := cursor.All(context.Background(), &questions); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(questions)
	}
}

func seedDB(client *mongo.Client) {
	collection := client.Database("myApp").Collection("questions")

	if _, err := collection.DeleteMany(context.Background(), bson.D{}); err != nil {
		log.Fatal("Error clearing questions collection:", err)
	}

	var documents []interface{}
	for _, q := range seedQuestions {
		documents = append(documents, q)
	}

	if _, err := collection.InsertMany(context.Background(), documents); err != nil {
		log.Fatal("Error seeding database:", err)
	}

	fmt.Println("Database seeded successfully!")
}

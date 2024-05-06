package main

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"golang.org/x/crypto/bcrypt"
)

type User struct {
	Username string `bson:"username"`
	Password string `bson:"password"`
}

type UserResponse struct {
	Username string `json:"username"`
}

type QuizResult struct {
	Username       string `json:"username"`
	CorrectAnswers int    `json:"correctAnswers"`
}

var client *mongo.Client

func main() {
	var err error
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	clientOptions := options.Client().ApplyURI("mongodb://localhost:27017/myQuizApp")
	client, err = mongo.Connect(ctx, clientOptions)
	if err != nil {
		log.Fatal(err)
	}
	defer client.Disconnect(ctx)

	http.HandleFunc("/register", registerHandler)
	http.HandleFunc("/login", loginHandler)
	http.HandleFunc("/submit-quiz-results", submitQuizResultsHandler)
	http.HandleFunc("/quiz-results", getQuizResultsHandler)

	log.Println("Starting server on port 5001...")
	if err := http.ListenAndServe(":5001", nil); err != nil {
		log.Fatal("Failed to start server:", err)
	}
}

func registerHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Only POST method is accepted", http.StatusMethodNotAllowed)
		return
	}

	var user User
	if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), 12)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	user.Password = string(hashedPassword)

	collection := client.Database("myQuizApp").Collection("users")
	_, err = collection.InsertOne(context.Background(), user)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	userResponse := UserResponse{Username: user.Username}
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(userResponse)
}

func loginHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Only POST method is accepted", http.StatusMethodNotAllowed)
		return
	}

	var creds struct {
		Username string `json:"username"`
		Password string `json:"password"`
	}
	if err := json.NewDecoder(r.Body).Decode(&creds); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	collection := client.Database("myQuizApp").Collection("users")
	var user User
	err := collection.FindOne(context.Background(), bson.M{"username": creds.Username}).Decode(&user)
	if err != nil {
		http.Error(w, "User not found", http.StatusNotFound)
		return
	}

	err = bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(creds.Password))
	if err != nil {
		http.Error(w, "Invalid credentials", http.StatusUnauthorized)
		return
	}

	userResponse := UserResponse{Username: user.Username}
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(userResponse)
}

func submitQuizResultsHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Only POST method is accepted", http.StatusMethodNotAllowed)
		return
	}

	var result QuizResult
	err := json.NewDecoder(r.Body).Decode(&result)
	if err != nil {
		http.Error(w, "Error decoding request body", http.StatusBadRequest)
		return
	}

	collection := client.Database("myQuizApp").Collection("quizResults")
	_, err = collection.InsertOne(context.Background(), result)
	if err != nil {
		http.Error(w, "Failed to store the quiz results", http.StatusInternalServerError)
		log.Printf("Failed to store result for user %s: %s\n", result.Username, err.Error())
		return
	}

	log.Printf("Successfully stored result for user %s: %d correct answers\n", result.Username, result.CorrectAnswers)

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"message": "Results submitted successfully"})
}

func getQuizResultsHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet {
		http.Error(w, "Only GET method is accepted", http.StatusMethodNotAllowed)
		return
	}

	collection := client.Database("myQuizApp").Collection("quizResults")
	cursor, err := collection.Find(context.Background(), bson.M{})
	if err != nil {
		http.Error(w, "Failed to fetch results", http.StatusInternalServerError)
		return
	}
	defer cursor.Close(context.Background())

	var results []QuizResult
	if err = cursor.All(context.Background(), &results); err != nil {
		http.Error(w, "Failed to parse results", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(results)
}

// Assuming sample_data.js is an array of question objects.
const mongoose = require('mongoose');
const Question = require('./question.js'); // Adjust the path as necessary
const sample_data = require('./samplequestions.js'); // Path to your sample_data.js

mongoose.connect('mongodb://localhost:27017/myApp', { useNewUrlParser: true, useUnifiedTopology: true })
.then(() => {
    console.log('Connected to MongoDB...');
    return Question.deleteMany({}); // Clear the collection if needed
})
.then(() => {
    console.log('Old Questions deleted');
    return Question.insertMany(sample_data); // Insert the sample data
})
.then(() => {
    console.log('Database seeded!'); // Confirm the data was inserted
    mongoose.connection.close();
})
.catch((err) => {
    console.error('Database seeding error:', err);
    mongoose.connection.close();
});

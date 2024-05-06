const bcrypt = require('bcryptjs');
const User = require('./usermodel'); // Adjust path as necessary

// Function to register a new user
async function registerUser(username, password) {
    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 12);

    // Create a new user instance
    const user = new User({
        username,
        password: hashedPassword,
    });

    // Save the user to the database
    await user.save();

    return user;
}

// Export the registerUser function for use in other files
module.exports = { registerUser };

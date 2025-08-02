const express = require('express');
const mongoose = require('mongoose');

// Routers
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

// INIT
const PORT = 3001;
const app = express();
require('dotenv').config();

const DB = process.env.MONGO_URI;

// Middleware
app.use(express.json()); 
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("MongoDB connected!");
  })
  .catch((err) => {
    console.error("Connection error:", err);
  });

// Server Listen
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`);
});
// server/routes/auth.js
const express = require('express');
const User = require('../models/user')
const bcryptjs = require('bcryptjs'); 
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth = require('../middlewears/auth');

authRouter.get('/users', (req,res) =>{
    res.json({name: "Parth"})
});

//signup
authRouter.post('/api/signup', async (req,res) => {
    try {
        console.log('--- Received POST /api/signup ---');
        const {name,email,password} = req.body; 

        console.log('Request Body:', req.body);

        const existingUser = await User.findOne({email});
        if(existingUser){
            console.log(`User with email ${email} already exists.`);
            return res.status(400).json({msg:'The user with the same email already exists.'});
        }

        const hashedPassword = await bcryptjs.hash(password,8);
        let user = new User({
            email,
            password: hashedPassword,
            name,
        });
        user = await user.save();
        console.log(`User ${name} created successfully.`);
        res.json(user);

    } catch(e) {
        console.error('Error in /api/signup:', e.message);
        res.status(500).json({error: e.message});
    }
});

 //sign in 
authRouter.post('/api/signin', async (req,res) => {
    console.log('--- Received POST /api/signin ---');
    try{
        const {email, password} = req.body;
        console.log('Request Body:', req.body);
        const user = await User.findOne({email});
        if(!user){
            console.log(`User with email ${email} not found.`);
            return res
                .status(400)
                .json({error: "User with this email does not exist."});
        }

        const isMatch = await bcryptjs.compare(password,user.password);
        if(!isMatch){
            console.log(`Incorrect password for user ${email}.`);
            return res
                .status(400)
                .json({error: "Incorrect password."});
        }

        const token = jwt.sign({id:user._id}, process.env.JWT_SECRET);
        console.log(`User ${email} signed in successfully.`);
        res.json({token, ...user._doc});
    }
    catch(e){
        console.error('Error in /api/signin:', e.message);
        res.status(500).json({error: e.message});
    }
});

//token validation

authRouter.post('/tokenIsValid', async (req,res) => {
    console.log('--- Received POST /tokenIsValid ---');
    try{
        const token = req.header('x-auth-token');
        if(!token) return res.json(false);
        const verified = jwt.verify(token, process.env.JWT_SECRET);
        if(!verified) return res.json(false);
        
        const user = await User.findById(verified.id);
        if(!user) return res.json(false);

        //weve checked wheter the user has a token, if its valid ornot and does it match a user
        //if itn does that all, we can say that the user is who they say they are
        console.log('Token is valid.');
        return res.json(true);
    }
    catch(e){
        console.error('Error in /tokenIsValid:', e.message);
        res.status(500).json({error: e.message});
    }
});

authRouter.get('/', auth, async (req,res) =>{
    console.log('--- Received GET / ---');
    const user = await User.findById(req.user);
    console.log('Found user data for token.');
    res.json({...user._doc,token: req.token});
});

module.exports = authRouter;
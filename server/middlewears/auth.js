// server/middlewears/auth.js
const jwt = require('jsonwebtoken');

const auth = async (req, res, next) =>{
    try{
        const token = req.header('x-auth-token');
        if(!token) return res.status(401).json({msg: "no token found, fialed auth"});

        const verified = jwt.verify(token,process.env.JWT_SECRET);
        if(!verified) return res.status(401).json({msg:"Token authentication failed,"});
        req.user = verified.id;
        req.token = token;

        next();
    }
    catch(err){
        res.status(500).json({err: err.message});
    }
}

module.exports = auth;
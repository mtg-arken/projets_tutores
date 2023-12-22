const express = require ('express')

const cookieParser = require('cookie-parser');
const cors = require("cors")
const app = express()

const createApp = () => {
  
  const corsOptions = {
    exposedHeaders: ["ApiKey", "Authorization"],
    allowedHeaders: [
      "Origin",
      "X-Requested-With",
      "Content-Type",
      "Accept",
      "Authorization",
      "ApiKey",
      "x-access-token",
      "Access-Control-Allow-Headers",
      "Access-Control-Allow-Origin",
    ],
    origin: "http://localhost:3000",
    methods: [
      "GET",
      "PUT",
      "POST",
      "DELETE",
      "HEAD",
      "OPTIONS",
      "PATCH",
      "PROPFIND",
      "PROPPATCH",
      "MKCOL",
      "COPY",
      "MOVE",
      "LOCK",
    ],
    optionsSuccessStatus: 204,
    preflightContinue: true,
    credentials: true,
  };
    app.set('etag', false)
    app.set('Cache-Control', 'no-store')
    app.set('Access-Control-Allow-Origin', '*')
    app.set('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,HEAD,OPTIONS,PATCH,PROPFIND,PROPPATCH,MKCOL,COPY,MOVE,LOCK')
    app.set('Access-Control-Allow-Headers', 'Origin, X-Requested-With,Content-Type,Accept,Authorization,ApiKey,x-access-token,Access-Control-Allow-Headers,Access-Control-Allow-Origin')

  app.use(express.json());
  app.use(express.urlencoded({ extended: true, limit: "10mb" }));
  app.use(cookieParser());
  app.use(cors(corsOptions));


  app.use((err, req, res, next) => {
    res.status(500).json(err);
  });



  /*
  app.all("*", (req, res) =>
    res.status(404).json({ statusCode: 404, success: false, data: `not found` })
  ); 
*/
  return app;
};

module.exports= createApp;

const createApp=require('./src/App.js')
const app = createApp();
const {createServer}=require('http')

const server = createServer(app);

require("./src/config/connectDB.js") ;


server.listen(process.env.PORT, () => {
  console.log(`app listening on port ${process.env.PORT}`);
});

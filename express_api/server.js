import bodyParser from 'body-parser';
import express from 'express';
import http from 'http';
import router from './config/router.js';

const app = express();
// middle ware for request body parsing
app.use(bodyParser.json());
// mapping routes after static files.
app.use(router);

const server = http.createServer(app);

export default server;

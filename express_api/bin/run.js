#!/usr/local/bin/node

import config from '../config/env.js';
import server from '../server.js';

const port = process.env.PORT || config.port;

server.listen(port, () => {
  console.log(`Server running on port: ${port}`);
});

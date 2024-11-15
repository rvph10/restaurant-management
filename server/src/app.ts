import express from 'express';
import cors from 'cors';
import { errorHandler } from './middleware/error-handler';
import { routes } from './api/routes';
import { setupSocket } from './sockets';

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api', routes);

// Error handling
app.use(errorHandler);

// Socket.io setup
setupSocket(app);

export { app };

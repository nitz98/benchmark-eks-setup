import BenchmarksController from '../app/controllers/benchmarks_controller.js';
import { Router } from 'express';

const benchmarksController = new BenchmarksController();

const mainRouter = new Router();

mainRouter.get('/api/benchmarks', benchmarksController.index);

export default mainRouter;

function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

/** Controller for Benchmarks */
class BenchmarksController {
  /**
   * index page handler
   * @param {object} req the request object
   * @param {object} res the response object
   */
  async index(_req, res) {
    let i;
    for(i = 0; i < 1000000; i++ ){}
    await sleep(20);
    res.status(200).send({ message: 'it works!' });
  }
};

export default BenchmarksController;

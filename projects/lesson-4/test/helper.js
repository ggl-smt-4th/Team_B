async function assertThrow(fn, ...args) {
  try {
    await fn.apply(this, args);
  } catch (err) {
    return;
  }

  throw new Error("should throw an error");
}

async function promisify(fn) {
  return new Promise((resolve, reject) =>
    fn((err, res) => {
      if (err) {
        reject(err);
      }
      resolve(res);
    })
  );
}

async function timeJump(seconds) {
  return promisify(cb =>
    web3.currentProvider.sendAsync(
      {
        jsonrpc: "2.0",
        method: "evm_increaseTime",
        params: [seconds],
        id: new Date().getTime()
      },
      cb
    )
  );
}

async function getBalance(account, at) {
  return promisify(cb => web3.eth.getBalance(account, at, cb));
}

module.exports = {
  assertThrow,
  timeJump,
  getBalance
};

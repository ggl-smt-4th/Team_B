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

async function getEvents(eventName) {
  return promisify(cb => eventName.get(cb));
}

async function getBlockNumber() {
  return promisify(cb => web3.eth.getBlockNumber(cb));
}

async function recordingTx(txFn, ...hooks) {
  let pre = {};
  let post = {};

  for (let i = 0; i < hooks.length; i++) {
    let hook = hooks[i];
    pre[hook.name] = await hook();
  }

  await txFn();

  for (let i = 0; i < hooks.length; i++) {
    let hook = hooks[i];
    post[hook.name] = await hook();
  }

  return {
    pre,
    post
  };
}

module.exports = {
  assertThrow,
  timeJump,
  getBalance,
  getEvents,
  getBlockNumber,
  recordingTx
};

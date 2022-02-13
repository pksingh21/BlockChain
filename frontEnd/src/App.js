import { useState } from "react";
import { ethers } from "ethers";
import ErrorMessage from "./ErrorMessage";
import TxList from "./TxList";
import AnotherApp from "./Another";

const mainToken = "0xc3379a1bFb1b8B959e7297bD343d6713BbA0926d";
const childToken = "0x0d8f8f8f8f8f8f8f8f8f8f8f8f8f8f8f8f8f8f8f8";

const startPayment = async ({ setError, setTxs, ether, addr }) => {
  try {
    if (!window.ethereum)
      throw new Error("Metamask extension not found. Please install it.");

    await window.ethereum.send("eth_requestAccounts");
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const { chainId } = await provider.getNetwork(); //get chain id
    let tokenAddr = mainToken;
    if(chainId == 4){
      tokenAddr = mainToken;
    }
    else if(chainId == 43113){
      tokenAddr = childToken;
    }
    else{
      throw new Error("You don't seem to be in the correct network, please choose a network from below");
    }
    const signer = provider.getSigner();
    ethers.utils.getAddress(addr);
    const gasPrice = provider.getGasPrice();
    const tx = await signer.sendTransaction({
      contract_address: tokenAddr,
      to: addr,
      value: ethers.utils.parseEther(ether),
    });
    console.log({ ether, addr });
    console.log("tx", tx);
    setTxs([tx]);
  } catch (err) {
    setError(err.message);
  }
};

export default function App() {
  const [error, setError] = useState();
  const [txs, setTxs] = useState([]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    const data = new FormData(e.target);
    setError();
    await startPayment({
      setError,
      setTxs,
      ether: data.get("ether"),
      addr: data.get("addr"),
    });
  };

  return (
    <>
      <form className="m-4" onSubmit={handleSubmit}>
        <div className="credit-card w-full lg:w-1/2 sm:w-auto shadow-lg mx-auto rounded-xl bg-white">
          <main className="mt-4 p-4">
            <h1 className="text-xl font-semibold text-gray-700 text-center">
              Bridge LNK Tokens
            </h1>
            <div className="">
              <div className="my-3">
                <input
                  type="text"
                  name="addr"
                  className="input input-bordered block w-full focus:ring focus:outline-none"
                  placeholder="Recipient Address"
                />
              </div>
              <div className="my-3">
                <input
                  name="ether"
                  type="text"
                  className="input input-bordered block w-full focus:ring focus:outline-none"
                  placeholder="enter Token ID"
                />
              </div>
            </div>
          </main>
          <footer className="p-4">
            <button
              type="submit"
              className="btn btn-primary submit-button focus:ring focus:outline-none w-full"
            >
              Bridge
            </button>
            <ErrorMessage message={error} />
            <TxList txs={txs} />
          </footer>
        </div>
      </form>
      <AnotherApp />
    </>
  );
}

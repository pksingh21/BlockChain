import { useState, useEffect } from "react";
import ErrorMessage from "./AnotherError";
import { Grid } from "@mui/material";

const networks = {
  rinkeby: {
    chainId: `0x${Number(4).toString(16)}`,
    chainName: "Rinkeby Test Network",
    nativeCurrency: {
      name: "Ethereum",
      symbol: "ETH",
      decimals: 18,
    },
    rpcUrls: ["https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161"],
    blockExplorerUrls: ["https://rinkeby.etherscan.io"],
  },
  avax: {
    chainId: `0x${Number(43113).toString(16)}`,
    chainName: "Avalanche Fuji Testnet",
    nativeCurrency: {
      name: "Avalanche",
      symbol: "AVAX",
      decimals: 9,
    },
    rpcUrls: ["https://api.avax-test.network/ext/bc/C/rpc"],
    blockExplorerUrls: ["https://testnet.snowtrace.io/"],
  },
};

const changeNetwork = async ({ networkName, setError }) => {
  try {
    if (!window.ethereum) throw new Error("No crypto wallet found");
    console.log(networks[networkName]);
    await window.ethereum.request({
      method: "wallet_addEthereumChain",
      params: [
        {
          ...networks[networkName],
        },
      ],
    });
  } catch (err) {
    setError(err.message);
  }
};

export default function App() {
  const [error, setError] = useState();

  const handleNetworkSwitch = async (networkName) => {
    setError();
    await changeNetwork({ networkName, setError });
  };

  const networkChanged = (chainId) => {
    console.log({ chainId });
  };

  useEffect(() => {
    window.ethereum.on("chainChanged", networkChanged);

    return () => {
      window.ethereum.removeListener("chainChanged", networkChanged);
    };
  }, []);

  return (
    <div
      className="credit-card w-full lg:w-1/2 sm:w-auto shadow-lg mx-auto rounded-xl bg-white"
      style={{ height: "140px" }}
    >
      <main className="mt-4 p-4" style={{ height: "140px" }}>
        <h1 className="text-xl font-semibold text-gray-700 text-center">
          Force MetaMask network (Currently not working )
        </h1>
        <Grid container style={{ height: "200px" }} spacing={"20px"}>
          <Grid item xs={12} sm={6}>
            <button
              onClick={() => handleNetworkSwitch("rinkeby")}
              className="mt-2 mb-2 btn btn-primary submit-button focus:ring focus:outline-none w-full"
              style={{ padding: "10px", height: "70px" }}
            >
              Switch to Ethereum Rinkeby Testnet
            </button>
          </Grid>
          <Grid item xs={12} sm={6}>
            <button
              onClick={() => handleNetworkSwitch("avax")}
              className="mt-2 mb-2 bg-error border-warning btn submit-button focus:ring focus:outline-none w-full"
              style={{ padding: "10px", height: "70px" }}
            >
              Switch to Avax Fuji Testnet
            </button>
          </Grid>
        </Grid>
        <ErrorMessage message={error} />
      </main>
    </div>
  );
}

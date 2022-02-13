import { StrictMode } from "react";
import ReactDOM from "react-dom";

import App from "./App";
import { MoralisProvider } from "react-moralis";
const rootElement = document.getElementById("root");
ReactDOM.render(
  <StrictMode>
    <MoralisProvider
      appId="myKeb4AnZkVAKADNca2ag53HBV7kgDVJT0ik0HMT"
      serverUrl="https://yjrlbidxbwto.usemoralis.com:2053/server"
    >
      <App />
    </MoralisProvider>
  </StrictMode>,
  rootElement
);

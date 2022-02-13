import React from "react";
import ReactDOM from "react-dom";
import { MoralisProvider } from "react-moralis";
import App from "./App";

ReactDOM.render(
  <MoralisProvider appId="qxJ1lNRB1dRoKwkMFFSZY9hYwBafSNjyeZc3tpZA" serverUrl="https://7sd7ck4mwfck.usemoralis.com:2053/server">
    <App />
  </MoralisProvider>,
  document.getElementById("root"),
);
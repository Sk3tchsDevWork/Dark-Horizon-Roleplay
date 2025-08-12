import "@mantine/core/styles.css";
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.tsx";
import { isEnvBrowser } from "./hooks/useNuiEvents.ts";
import { RecoilRoot } from "recoil";
import "./index.css";
import "./global.css";

let root: ReactDOM.Root | null = null;

const initializeRoot = () => {
  root = ReactDOM.createRoot(document.getElementById("root")!);
};

const loadApp = (type: string) => {
  if (!root) initializeRoot();
  root?.render(
    <React.StrictMode>
      <RecoilRoot>
        <App type={type} />
      </RecoilRoot>
    </React.StrictMode>
  );
};

window.addEventListener("message", (event) => {
  switch (event.data.message) {
    case "loadApp":
      loadApp("app");
      break;
    case "loadAdmin":
      loadApp("admin");
      break;
    case "close":
      if (root) {
        root.unmount();
        root = null;
      }
      break;
    default:
      break;
  }
});

// if (isEnvBrowser()) loadApp(); // load main app
if (isEnvBrowser()) loadApp("admin"); // load admin panel

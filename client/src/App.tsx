import { Route, Switch } from "react-router-dom";
import "./App.css";
import About from "./components/About";
import Home from "./components/Home";

function App() {
  return (
    <Switch>
      <Route path="/about" component={About} />
      <Route path="/" component={Home} />
      <Route path="*" component={() => "404"} />
    </Switch>
  );
}

export default App;

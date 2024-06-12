import { Route, Switch } from "react-router-dom";
import "./App.css";
import About from "./components/About";
import Home from "./components/Home";

function App() {
  return (
    <Switch>
      <Route exact path="/about" component={About} />
      <Route exact path="/" component={Home} />
      <Route path="*" component={() => "404"} />
    </Switch>
  );
}

export default App;

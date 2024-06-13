import { defineConfig, loadEnv } from "vite";
import react from "@vitejs/plugin-react-swc";

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  /**
   * @link = https://stackoverflow.com/questions/66389043/how-can-i-use-vite-env-variables-in-vite-config-js
   */
  process.env = { ...process.env, ...loadEnv(mode, process.cwd()) }; // load env variable from .env file

  return {
    plugins: [react()],
    base:
      process.env.NODE_ENV === "development"
        ? ""
        : process.env.VITE_CUSTOM_BASE_PATH,
  };
});

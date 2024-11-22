import { defineConfig } from "vite";
import php from "vite-plugin-php";

export default defineConfig({
  plugins: [php({ entry: ["**/*.php"] })],
  server: {
    // Configure the server to use your desired port
    port: 3007,
    // Enable hot module replacement
    hmr: true,
  },
});

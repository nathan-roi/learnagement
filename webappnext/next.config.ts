import type { NextConfig } from "next";
import type { Configuration as WebpackDevMiddleware } from "webpack-dev-middleware";

const nextConfig: NextConfig = {
  webpackDevMiddleware: (config: WebpackDevMiddleware) => {
    config.watchOptions = {
      poll: 1000, // Vérifie les changements toutes les secondes
      aggregateTimeout: 300, // Temps avant de commencer à recompiler
    }
    return config
  },
  
};

export default nextConfig;

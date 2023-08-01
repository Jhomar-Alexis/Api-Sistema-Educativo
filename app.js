// Importamos las dependencias con las que trabajaremos
import { join } from "desm";
import AutoLoad from "@fastify/autoload";
import MySQL from "@fastify/mysql";
import Helmet from "@fastify/helmet";
import Static from "@fastify/static";
import Cors from "@fastify/cors";
import UnderPressure from "@fastify/under-pressure";

export const options = {};

/**
 *
 * @param {import('fastify').FastifyInstance} fastify
 * @param {*} opts
 */

export default async function (fastify, opts) {
  fastify.register(MySQL, {
    promise: true,
    connectionString: process.env.DATABASE_URL,
  });

  fastify.register(UnderPressure, {
    maxEventLoopDelay: 1000,
    maxHeapUsedBytes: 1000000000,
    maxRssBytes: 1000000000,
    maxEventLoopUtilization: 0.98,
  });

  fastify.register(Cors, {
    origin: "*",
    methods: ["GET", "PUT", "POST", "DELETE", "OPTIONS"],
    allowedHeaders: [
      "Content-Type",
      "Authorization",
      "Accept",
      "X-Requested-With",
      "Access-Control-Allow-Origin",
    ],
    preflightContinue: false,
    optionsSuccessStatus: 204,
  });

  fastify.register(
    Helmet,
    // Example disables the `contentSecurityPolicy` middleware but keeps the rest.
    { contentSecurityPolicy: false }
  );

  fastify.register(Static, {
    root: join(import.meta.url, "public"),
    prefix: "/storage/", // opcional: por defecto '/'
  });

  // No toques las siguientes lineas

  // Esto carga todos los complementos definidos en plugins
  // estos deberían ser complementos de soporte que se reutilizan
  // a través de la aplicación
  fastify.register(AutoLoad, {
    dir: join(import.meta.url, "plugins"),
    options: Object.assign({}, opts),
  });

  // Esto carga todos los complementos definidos en las routes
  // define tus rutas en una de estas
  fastify.register(AutoLoad, {
    dir: join(import.meta.url, "routes"),
    options: Object.assign({ prefix: "api" }, opts),
  });
}

//este archivo configura y registra diferentes complementos y rutas en la instancia de Fastify,
//lo que permite crear un servidor web con características como comunicación con una base de
//datos MySQL, manejo de sobrecarga de recursos, configuración de cabeceras CORS y cabeceras de
//seguridad HTTP, y servir archivos estáticos. Además, utiliza el complemento AutoLoad para cargar
//automáticamente plugins y rutas definidos en las carpetas plugins y routes, respectivamente.

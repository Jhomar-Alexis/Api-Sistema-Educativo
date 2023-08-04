// Importamos las dependencias con las que trabajaremos

// Leer el archivo .env.
import dotenv from "dotenv";
dotenv.config();

// Requerir el framework.
import Fastify from "fastify";

// Requerir que la biblioteca salga del proceso de fastify, gracefully (if possible).
import closeWithGrace from "close-with-grace";

// Instanciar Fastify con alguna configuración.
const app = Fastify({
  logger: true,
});

// Registre su aplicación como un plugin normal.
import appService from "./app.js";
app.register(appService);

// el retraso es el número de milisegundos para que finalice el cierre.
const closeListeners = closeWithGrace(
  { delay: process.env.FASTIFY_CLOSE_GRACE_DELAY || 500 },
  async function ({ signal, err, manual }) {
    if (err) {
      app.log.error(err);
    }
    await app.close();
  }
);

app.addHook("onClose", async (instance, done) => {
  closeListeners.uninstall();
  done();
});

// Start listening.
// levantamos el servidor.
app.listen({ port: process.env.PORT || 3000 }, (err) => {
  if (err) {
    app.log.error(err);
    process.exit(1);
  }
});

// Este código configura y ejecuta un servidor web utilizando el framework Fastify.
// Primero, carga las variables de entorno desde un archivo .env, luego crea una
// instancia de Fastify y registra un módulo llamado appService que define las rutas
// y controladores de la aplicación. Finalmente, inicia el servidor Fastify para
// escuchar en el puerto especificado o en el puerto 3000 de forma predeterminada.
// Además, implementa un mecanismo de salida grácil para que el servidor se cierre de
// manera segura en caso de que se reciba una señal de terminación.

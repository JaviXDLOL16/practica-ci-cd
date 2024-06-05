# Imagen base
FROM node:14

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo package.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia todo el contenido local al directorio /app en el contenedor
COPY . .

# Expone el puerto 3000
EXPOSE 3000

# Comando por defecto al iniciar el contenedor
CMD ["node", "index.js"]

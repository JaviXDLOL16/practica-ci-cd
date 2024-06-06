const request = require("supertest");
const express = require("express");

const app = express();

app.get("/api/v1/welcome", (req, res) => {
  res.status(200).send("Ahora el test");
});

describe("GET /api/v1/welcome", () => {
  it("responds with Hello, World!", (done) => {
    request(app).get("/api/v1/welcome").expect("Ahora el test", done);
  });
});

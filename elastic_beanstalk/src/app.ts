import express, { Request, Response, Application } from "express";
import dotenv, { DotenvConfigOutput } from "dotenv";

export default class App {
  private readonly app: Application;
  private readonly env: DotenvConfigOutput;
  private readonly port: number;
  constructor() {
    this.app = express();
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));
    this.app.get("/", (req: Request, res: Response) => {
      res.send(`INFO: Success route called at ${this.port}`);
    });
    this.env = dotenv.config();
    this.port = Number(process.env.PORT);
  }

  public listen() {
    this.app.listen(this.port, () => {
      console.log(`Connected Server http://localhost:${this.port}`);
    });
  }
}

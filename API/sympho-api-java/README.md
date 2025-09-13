<div style="text-align: center;">

# ☕ Sympho Java + Springboot—API Server

Open source, free, secure, fast, and lightweight, Java + Springboot server app
for - [Sympho](https://github.com/hamzaelmarjani/sympho) project.

</div>

---

## Features

- **[Springboot](https://spring.io/projects/spring-boot) makes it easy to create stand-alone, production-grade Spring based Applications that you can "just run" using Java SDK**. ✅
- **Middleware guard** for authentication check before generating any speech. ✅
- **ElevenLabs.io** Asynchronously REST API integration, thanks to [WebClient](https://www.baeldung.com/spring-5-webclient). ✅
- **Lightweight** uses a few necessary Maven dependencies. ✅
- **Organized** folder structure, easy to understand. ✅
- **Dockerfile** to deploy your app with one command from your CLI, build a lightweight & very optimized docker image. ✅
- **JWT** integration to add one more security layer. ⏳
- **Database** integration to store the generations in the cloud. ⏳
- **Clouding Storage** integration to store the generated files in the cloud storing services like AWS S3, Google Cloud
  Storage, Azure Blob Storage, etc. ⏳

---

## Services

**Sympho** project comes with many AI Speech solutions, available until now:

- TTS: Text-to-Speech. ✅
- STT: Speech-to-Text API. ⏳
- TTD: Text-to-Dialogue API. ⏳
- TTV: Text-to-Voice API. ⏳
- TTM: Text-to-Music API. ⏳
- SFX: Sound Effects API. ⏳
- VC: Voice Changer API. ⏳
- AUI: Audio Isolation API. ⏳
- DUB: Dubbing API. ⏳

---

## Usage

1. Install [Java SDK v17+](https://www.oracle.com/java/technologies/downloads/).
2. Install [Maven v3.6.3+](https://maven.apache.org/install.html)
3. Install [Springboot CLI](https://docs.spring.io/spring-boot/installing.html#getting-started.installing.cli)
4. Get [ElevenLabs API key](https://elevenlabs.io/app/developers/api-keys), create a free account, and get your API key.
5. Set your **ElevenLabs API key** within the env variable `ELEVENLABS_API_KEY` on `elevenlabs.api_key` from the file `src/main/resources/application.properties`.
6. Handle the middleware guard authentication by checking the `Authorization` header, for real app and production, you should validate the received token, for now we use a fake token. Open the file `src/main/java/cc/hamzaelmarjani/sympho_api_java/middleware/AuthInterceptor.java` and handle this:

```
private boolean isValidToken(String token) {
        // TODO: Handle the user check using the received token depending your
        // TODO: situation. You can use JWT service or any mechanism you want.
        // TODO: for now we will use just this fake token.
        if (!token.equals("f77cc4dd-b796-42e7-9c93-c7a69a83ec34")) {
            return false;
        }

        return !token.trim().isEmpty(); // or false
    }
```

7. Run the app with: `mvn spring-boot:run`.

---

## Build & Deploy

- Build & Run: We use docker to build & Run the app locally.
  - Open the project folder on the terminal or command line.
  - Build the app with: `docker build -t sympho-api-java .`.
  - Set ElevenLabs API key within the variable `ELEVENLABS_API_KEY` on your environment variables, for example: `export ELEVENLABS_API_KEY=your-api-key-here`.
  - Run the app: `docker run -p 8080:8080 -e ELEVENLABS_API_KEY=$ELEVENLABS_API_KEY sympho-api-java`.
  - If the app runs successfully, you can make a POST request using Postman or any other tool, to: `http://localhost:8080/v1/generation/tts`.
- Deploy: Use docker to deploy the app on the cloud, you can use any cloud provider like AWS, Azure, GCP, DigitalOcean, etc. Most popular and recommended cloud providers:
  - [AWS - ECS](https://aws.amazon.com/ecs/)
  - [GCP - Cloud Run](https://cloud.google.com/run/docs/deploying)
  - [Azure - ACI](https://azure.microsoft.com/en-us/products/container-instances)
  - [DigitalOcean](https://www.digitalocean.com/solutions/docker-hosting)

---

## License

Licensed under either of:

- [MIT License](LICENSE-MIT)
- [Apache License, Version 2.0](LICENSE-APACHE)

at your option.

---

## Contributing

Contributions are welcome! Please feel free to:

- Open issues for bugs or feature requests
- Submit pull requests with improvements
- Improve documentation or examples
- Add tests or benchmarks

Before contributing, please ensure your code follows NestJS conventions and includes appropriate tests.

---

## 📬 Contact & Hire Me

🚀 Want to add more advanced features to this app? I’ve got you covered! You can hire me.

**Company or Startup?** I can work **full-time** or **part-time**, 👉 **Remote** or **On-site**.

💌 Reach me at: **hamzaelmarjani@gmail.com**

✨ Thank you!

---

## Support

If you like this project, consider supporting me on Patreon 💖

[![patreon](https://img.shields.io/badge/Support-Open_Source-black?style=for-the-badge&logo=Patreon&logoColor=white)](https://www.patreon.com/elmarjanihamza/gift)

---

❤️ Thanks for reading, Happy Coding 💻

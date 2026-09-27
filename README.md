# booking-backend

Spring Boot backend for the booking application — Phase 1 of a phased, resume-grade portfolio build. See the companion [`booking-frontend`](../frontend-repo) repo for the Angular UI, and the project roadmap doc for the full phase plan.

## Stack

- Java 17, Spring Boot 3.3.4
- Spring Web, Spring Data JPA, Spring Validation
- PostgreSQL (added in Phase 2)
- Lombok

## Run it

This project was hand-scaffolded to match a standard Spring Initializr layout (no Maven Wrapper committed yet). With Maven installed locally, or opened in an IDE with bundled Maven (IntelliJ, Eclipse/STS):

```
mvn spring-boot:run
```

Then check:

```
curl http://localhost:8080/api/health
```

## Status

- [x] Phase 1 — project scaffolded, health endpoint live
- [ ] Phase 2 — data model & PostgreSQL schema
- [ ] Phase 3 — core REST APIs
- [ ] Phase 5 — hardening (tagged `v1.0-stable`)
- [ ] Phase 6 — JWT auth & async processing

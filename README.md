# apex repository

Yet another repository pattern for apex

This repository hold a simple Repository pattern implementation for apex.
It allows to encapsulate all basic CRUD operations
It propose to 3 modes of interactions :

- With sharing as SYSTEM (No Object Permission, no FLS)
- Without sharing as SYSTEM (No Object Permission, no FLS)
- With sharing as USER (Object Permission and FLS)

It comes with a in memory implementation dedicated for unit tests
=> You can write pure unit test, not integrated to the DB

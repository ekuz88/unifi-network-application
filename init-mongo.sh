#!/bin/bash
set -e

mongosh --quiet --username "${MONGO_INITDB_ROOT_USERNAME}" --password "${MONGO_INITDB_ROOT_PASSWORD}" --authenticationDatabase admin <<EOF
use ${MONGO_AUTHSOURCE}
if (db.getUser("${MONGO_USER}") == null) {
  db.createUser({
    user: "${MONGO_USER}",
    pwd: "${MONGO_PASS}",
    roles: [
      { db: "${MONGO_DBNAME}", role: "dbOwner" },
      { db: "${MONGO_DBNAME}_stat", role: "dbOwner" },
      { db: "${MONGO_DBNAME}_audit", role: "dbOwner" }
    ]
  })
} else {
  print("User already exists, skipping")
}
EOF

.PHONY: update-schema

BACKEND_SCHEMA_DIR=../brunstadtv/backend/graph/schema
APP_SCHEMA_DIR=./lib/graphql/schema
copy-schema: SHELL:=/bin/bash
copy-schema:
	for f in $(shell ls ${BACKEND_SCHEMA_DIR}) ;\
		do cp ${BACKEND_SCHEMA_DIR}/$$f "${APP_SCHEMA_DIR}/$${f%.graphqls}.graphql" ;\
	done
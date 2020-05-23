
all: depcheck haskell

haskell: fetchtree/src/Schema.hs
	stack build --test --bench --no-run-tests --no-run-benchmarks

hlint:
	hlint .

DBDEPS=$(wildcard verify/* deploy/* revert/*)

.PHONY: schema
schema: fetchtree/src/Schema.hs

fetchtree/src/Schema.hs: $(DBDEPS)
	bash ./scripts/gen_schema.sh

testwatch:
	ghcid -T :main -c 'stack repl fetchtree:lib fetchtree:test:fetchtree-test' --restart="fetchtree/package.yaml" --restart="stack.yaml" --restart=verify $(foreach file, $(DBDEPS), "--restart=$(file)")

.PHONY: depcheck
depcheck: sqitch

.PHONY: sqitch
sqitch:
	bash -c "sqitch --help >& /dev/null || echo 'download sqitch first'"
.PHONY: depcheck
depcheck: ormolu sqitch squealgen

.PHONY: squealgen
squealgen:
	bash -c "which squealgen >& /dev/null || echo 'download squealgen first'"

.PHONY: ormolu
ormolu:
	bash -c "which ormolu >& /dev/null || echo 'download ormolu first'"

ifneq (,$(wildcard ./.env))
    include .env
    export
	
endif

## Dynamic variables
LOCALPUBLICIP := $(shell curl -s https://now-dns.com/ip)
FRITZBOXPUBLICIP := $(shell curl -s 'https://www.nslookup.io/api/v1/records' -X POST -H 'Accept: application/json, text/plain, */*' --data-raw '{"domain":"mxgqrjmxaixnoea1.myfritz.net","dnsServer":"google"}' | jq -r ".records.a.response.answer[0].record.ipv4")
NOW := $(shell date +"%Y-%m-%d %H:%M:%S")
TFDIR := "-chdir=tf"
TFVAR := -var=allowlisted-ip-01="$(LOCALPUBLICIP)" -var=fritzbox-ip="$(FRITZBOXPUBLICIP)"

# Inspired by https://github.com/rbogle/example_api_lambda_powertools/blob/main/Makefile

# this will list all the targets in this makefile by default or by make list
# putting a '## comment on a target line will add a description to output
.DEFAUL_GOAL := list
.PHONY: list

list: ## -- list all the targets in this file with a description
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' Makefile \
	| sed -n 's/^\(.*\): \(.*\)##\(.*\)/\1\3/p' 

## Targets
.PHONY: starthere
starthere: ## -- if you don't know what to do, use this
	@ echo "initializing terraform"
	@ terraform $(TFDIR) init; terraform $(TFDIR) refresh $(TFVAR)

.PHONY: deploy
deploy: ## -- terraform deploy of this stack
	@ echo "deploying on OCI the whole stack"
	@ echo terraform $(TFDIR) apply $(TFVAR)
	@ terraform $(TFDIR) apply $(TFVAR) -auto-approve

.PHONY: plan
plan: ## -- terraform plan of this stack
	@ echo "running plan for the whole stack"
	@ echo terraform $(TFDIR) plan $(TFVAR)
	@ terraform $(TFDIR) plan $(TFVAR)

.PHONY: destroy
destroy: ## -- terraform destroy of this stack
	@ echo "destroy the whole stack"
	@ terraform $(TFDIR) destroy $(TFVAR)

.PHONY: output
output: ## -- terraform output
	@ echo "print the terraform output"
	@ terraform $(TFDIR) output

.PHONY: showenv
showenv: ## -- show the values of all terraform env variables set here
	@ env | grep TF_VAR
	@ echo terraform dir $(TFDIR)
	@ echo terraform var $(TFVAR)

.PHONY: commit
commit: ## -- commit locally
	@ git add .; git commit -m "checkpoint commit as of $(NOW) from $(LOCALPUBLICIP)"

.PHONY: gitpush
gitpush: ## -- push to origin
	@ git add .; git push -u origin

.PHONY: recover
recover: ## -- target for running commands for recovery and troubleshooting
	@ terraform $(TFDIR) state push errored.tfstate
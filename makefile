S3_BUCKET_PROD=xjg.prod.tinysite
S3_URL_PROD=s3://${S3_BUCKET_PROD}
S3_BUCKET_TEST=xjg.test.tinysite
S3_URL_TEST=s3://${S3_BUCKET_TEST}
DISTRIBUTION_ID=E1BMZVRSIK56R2
DISTRIBUTION_ID_TEST=E3EKS3NGXNUNV7
CERT_DIR=`pwd`/certs
CERT_PREFIX=fileb://${CERT_DIR}
CERT_EMAIL=joaquim.q.gomez@gmail.com
DOMAIN=honeygoggles.com
ZONE_ID=Z03685642AKBD4WF919H5
CERT_ID=arn:aws:acm:us-east-1:479916576255:certificate/b8583976-b238-4606-ae9f-ff00b792c9f5

.PHONY: clean
clean:
	-rm -rf public/*
	-rm -rf ___ELDER___

# Initial deployment of infrastructure
# Ensure AWS creds are in env
.PHONY: tf-init
tf-init:
	cd tf && terraform init

.PHONY: init-prod
init-prod:
	$(MAKE) tf-init
	-cd tf && terraform workspace new prod
	cd tf && terraform workspace select prod
	cd tf && terraform apply -auto-approve -var-file=./env/prod.tfvars

.PHONY: init-test
init-test:
	$(MAKE) tf-init
	-cd tf && terraform workspace new test
	cd tf && terraform workspace select test
	cd tf && terraform apply -auto-approve -var-file=./env/test.tfvars

.PHONY: destroy-test
destroy-test:
	cd tf && terraform workspace select test
	cd tf && terraform destroy -auto-approve -var-file=./env/test.tfvars

# Deploy changes
.PHONY: build
build:
	$(MAKE) clean
	yarn run build

.PHONY: deploy-prod
deploy-prod:
	$(MAKE) build
	aws s3 sync --delete public ${S3_URL_PROD}
	aws cloudfront create-invalidation --distribution-id ${DISTRIBUTION_ID} --paths '/*' > /dev/null

.PHONY: deploy-test
deploy-test:
	$(MAKE) build
	aws s3 sync public ${S3_URL_TEST}
	aws cloudfront create-invalidation --distribution-id ${DISTRIBUTION_ID_TEST} --paths '/*' > /dev/null

# Setup up Certificate and deploy cert to ACM
# Certificate is for *.joaquimgomez.com and joaquimgomez.com
# When testing, site should use on x.joaquimgomez.com
# On live, site should use both joaquimgomez.com and www.joaquimgomez.com
.PHONY: refresh-cert
refresh-cert:
	$(MAKE) cert
	$(MAKE) upload-cert

.PHONY: cert
cert:
	certbot certonly --rsa-key-size 2048 --key-type rsa --non-interactive --agree-tos --dns-route53 -d *.${DOMAIN} -d ${DOMAIN} --email ${CERT_EMAIL} --work-dir ${CERT_DIR} --config-dir ${CERT_DIR} --logs-dir ${CERT_DIR}

.PHONY: upload-cert
upload-cert:
	aws acm import-certificate --certificate-arn '${CERT_ID}' --region us-east-1 --certificate-chain ${CERT_PREFIX}/live/${DOMAIN}/fullchain.pem --private-key ${CERT_PREFIX}/live/${DOMAIN}/privkey.pem --certificate ${CERT_PREFIX}/live/${DOMAIN}/cert.pem > /dev/null

# No longer required as using Route53 plugin for certbot
# .PHONY: set-acme-root
# set-acme-root:
# 	aws route53 change-resource-record-sets --hosted-zone-id ${ZONE_ID} --change-batch "`cat ./certs/acme_record_set-root.json`"

# .PHONY: set-acme-www
# set-acme-www:
# 	aws route53 change-resource-record-sets --hosted-zone-id ${ZONE_ID} --change-batch "`cat ./certs/acme_record_set-www.json`"

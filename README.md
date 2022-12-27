docker run -e PG_HOST=ip-10-0-1-77.ec2.internal -e PG_USER=vaultadmin -e PG_PASS=vaultadminvaultadmin -p 8080:8080 py-db-app


curl -sfL https://raw.githubusercontent.com/paulovigne/py-db-app/main/install_el.sh | sh -
ping:
	ansible localhost -i inventory.ini -m ping

upload_requirements:
	ansible-galaxy install -r requirements.yml

prepare:
	ansible-playbook playbook.yml -i inventory.ini --limit localhost -t setup --ask-become-pass

deploy:
	ansible-playbook playbook.yml -i inventory.ini --limit localhost -t redmine --ask-become-pass --vault-password-file .pass

local_postgres:
	docker run -d --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=redmine postgres

edit_vault:
	ansible-vault edit ./group_vars/webservers/vault.yml --vault-password-file .pass

encrypt_vault:
	ansible-vault encrypt ./group_vars/webservers/vault.yml --vault-password-file .pass
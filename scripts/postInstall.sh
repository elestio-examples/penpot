# set env vars
set -o allexport; source .env; set +o allexport;

echo "Creating user..."
sleep 120

docker-compose exec -T penpot-backend ./manage.py create-profile -e ${ADMIN_EMAIL} -p ${ADMIN_PASSWORD} -n Root
docker-compose exec -T penpot-backend ./manage.py update-profile -e ${ADMIN_EMAIL} -p ${ADMIN_PASSWORD} -n root
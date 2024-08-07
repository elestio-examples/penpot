# set env vars
set -o allexport; source .env; set +o allexport;

echo "Creating user..."
sleep 240s;

docker-compose exec -T penpot-backend ./manage.py create-profile -e ${ADMIN_EMAIL} -p ${ADMIN_PASSWORD} -n root
docker-compose exec -T penpot-backend ./manage.py update-profile -e ${ADMIN_EMAIL} -p ${ADMIN_PASSWORD} -n root
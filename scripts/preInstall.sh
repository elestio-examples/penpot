set env vars
set -o allexport; source .env; set +o allexport;

mkdir penpot_assets_data penpot_postgres_data

chmod -R 999:999 penpot_postgres_data
chown -R 1001:1001 penpot_assets_data

cat <<EOT > ./servers.json
{
    "Servers": {
        "1": {
            "Name": "local",
            "Group": "Servers",
            "Host": "172.17.0.1",
            "Port": 30263,
            "MaintenanceDB": "postgres",
            "SSLMode": "prefer",
            "Username": "penpot",
            "PassFile": "/pgpass"
        }
    }
}
EOT

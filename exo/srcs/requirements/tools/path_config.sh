echo "=== INCEPTION PATH CONFIGURATION ==="

printf "\nPath for mariadb database and wordpress files:"
printf "\nExemple : /home/rroussel/data\n"
read path

if [ ! -d "$path" ]; then
    echo "Invalid path."
    exit 1
fi

echo "$path" > srcs/requirements/tools/data_path.txt

cp srcs/requirements/tools/template_compose.yml srcs/docker-compose.yml
cat srcs/docker-compose.yml | sed "s+pathtodata+$path+g" > srcs/docker-compose.yml.tmp
mv srcs/docker-compose.yml.tmp srcs/docker-compose.yml

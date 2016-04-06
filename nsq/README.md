# Run nsq products

`sed -e "s/HOSTIP/$(docker-machine ip dev)/g" docker-compose.yml | compose --file - up`


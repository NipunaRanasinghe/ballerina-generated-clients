
rm -rf rpc_client
rm -rf rest_client

mkdir rpc_client
cd rpc_client
bal init rpc_client
bal openapi -i ../openapi.yaml --mode=client --client-methods=remote
bal build
cd ..

mkdir rest_client
cd rest_client
bal init rest_client
bal openapi -i ../openapi.yaml --mode=client --client-methods=resource
bal build
cd ..
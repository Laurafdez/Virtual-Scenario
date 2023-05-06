sudo ip link set dev eth1 mtu 1400


KID1=$(osm k8scluster-list)
KID=${KID1:357:36}
#KID=a1337fb3-21d9-4952-bf58-8265b750f4d0

echo $KID

OSM1=$(osm k8scluster-show --literal $KID | grep -A1 projects)
export OSMNS=${OSM1:25:36}

echo $OSMNS

osm repo-add helmchartrepo https://educaredes.github.io/nfv-lab --type helm-chart --description "Repo para la practica de OSM" 

#osm ns-create --ns_name helmchartrepo --nsd_name k8s_juju --vim_account <VIM_ACCOUNT> --config_file config.yaml --ssh_keys ${HOME}/.ssh/id_rsa.pub

cd pck
osm nfpkg-create accessknf_vnfd.tar.gz
osm nfpkg-create cpeknf_vnfd.tar.gz
osm nfpkg-list

osm nspkg-create renes_ns.tar.gz

osm nspkg-list
cd 
export NSID1=$(osm ns-create --ns_name renes1 --nsd_name renes --vim_account dummy_vim)
echo $NSID1
watch osm ns-list
osm ns-delete $NSID1

export NSID1=$(osm ns-create --ns_name renes1 --nsd_name renes --vim_account dummy_vim)
echo $NSID1
watch osm ns-list
kubectl -n $OSMNS get pods

VI=$(kubectl -n $OSMNS get pods)
B=$(grep helmchartrepo-cpechart <<< "$VI")
A=$(grep helmchartrepo-accesschart <<< "$VI")

ACCPOD=$(echo $A | cut -d ' ' -f1)
CPEPOD=$(echo $B | cut -d ' ' -f1)


export NSID2=$(osm ns-create --ns_name renes2 --nsd_name renes --vim_account dummy_vim)
echo $NSID2
watch osm ns-list
kubectl -n $OSMNS get pods

VI2=$(kubectl -n $OSMNS get pods)
B2=$(grep helmchartrepo-cpechart <<< "$VI")
A2=$(grep helmchartrepo-accesschart <<< "$VI")

ACCPOD2=$(echo $A2 | cut -d ' ' -f6)
CPEPOD2=$(echo $B2 | cut -d ' ' -f6)


cd shared
cd nfv-lab

./osm_renes1.sh
./osm_renes2.sh

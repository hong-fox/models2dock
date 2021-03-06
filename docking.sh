#! /bin/bash

#author: yanhong hong

liganddir=$PWD'/ligands'
receptordir=$PWD'/receptor'
resultdir=$PWD'/results'
logdir=$PWD'/log'

#docking parameters
num_modes=40
exhaustiveness=40
energy_range=10
cpu=7
process_num=2

if [ ! -d "$resultdir" ]; then
    mkdir ${resultdir}
fi

if [ ! -d "$logdir" ]; then
    mkdir ${logdir}
fi


#blind dock
for ligand in ${liganddir}/pdbqt/*.pdbqt
do
    for receptor in ${receptordir}/*/*.pdbqt
    do
        receptor_prefix=`basename $receptor .pdbqt`
        ligand_prefix=`basename $ligand .pdbqt`
        echo -e "smina -r "${receptor}" -l "${ligand}" --autobox_ligand "${receptor}" --cpu "${cpu}" --num_modes "${num_modes}" --exhaustiveness "${exhaustiveness}" --energy_range "${energy_range}"  -o  "${resultdir}/${receptor_prefix}_${ligand_prefix}.pdbqt" --log  "${logdir}/${receptor_prefix}_${ligand_prefix}.log
    done | xargs -n 1 -I {} -P ${process_num} bash -c '{}'
done


for result in ${resultdir}/*.pdbqt
do
    {
    result_prefix=`basename $result .pdbqt`
    mkdir ${resultdir}/${result_prefix}
    mv ${result} ${resultdir}/${result_prefix}
    vina_split --input ${resultdir}/${result_prefix}/*.pdbqt
    } &
done
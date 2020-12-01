#! /bin/bash

#this script use pdbfixer of openmm to fix the models generated by modeller

#author: yanhong hong

#path of pythonsh
pythonsh='/home/hyh/MGLTools-1.5.6/mgltools_x86_64Linux2_1.5.6/bin/pythonsh'
#path of the script
script='/home/hyh/project13_prepreceptoranddocking/prepare_receptor4.py'
process_num=8

rename 's/.B99990001//g' models/*.pdb
mkdir receptor

#fix by pdbfixer
for i in models/*.pdb
do
    dir=`basename $i .pdb`
    mkdir ${dir}
    cp $i ${dir}
    cd ${dir}
    echo -e ${dir}" \n "${dir}".pdb --add-residues --add-atoms none --verbose --output "${dir}"_fix.pdb"
    cd ..
done | xargs -n 2 -d'\n' -P ${process_num} bash -c 'cd $0;pdbfixer $1'

#add hydrogens
for i in models/*.pdb
do
    dir=`basename $i .pdb`
    cd ${dir}
    echo -e ${dir}" \n-h -ipdb "${dir}"_fix.pdb -opdb "${dir}"_addH.pdb"
    cd ..
done | xargs -n 2 -d'\n' -P ${process_num} bash -c 'cd $0; babel $1'

#use the script prepare_receptor4.py to prepare the receptor for smina.
for i in models/*.pdb
do
    dir=`basename $i .pdb`
    cd ${dir}
    echo -e ${dir}" \n"${pythonsh}" "${script}"\n-r "${dir}"_addH.pdb"
    cd ..
done | xargs -n 3 -d'\n' -P ${process_num} bash -c 'cd $0; $1 $2'

for i in models/*.pdb
do
    dir=`basename $i .pdb`
    echo -e ${dir}
done | xargs -n 1 -I {} -P ${process_num} bash -c 'mv {} receptor'
# Models2Dock

  This is an automated pipeline to fix models that generated by Modeller and use scripts to prepare the ligands and receptors for Smina. Note that the default setting of this pipeline is blind dock, if you want to specify a custom search space,please **modify the script** ` docking.sh`, also you should **change the directory settings** of scripts ` docking.sh`,` prepare_lig.sh` ,` fix_model.sh`.

  The pipeline:

 (1) fix the model using pdbfixer(fix_model.sh) and use openbabel to add hydrogens and use script prepare_receptor4.py to prepare the receptor.  -->  (2)prepare the ligands using the script prepare_lig.sh  -->  (3)start docking using script ` docking.sh`



## Dependences

```shell
Openbabel
pdbfixer
Smina
```

You can obtain these programs from:

http://openbabel.org/wiki/Main_Page

https://github.com/openmm/pdbfixer

https://github.com/mwojcikowski/smina



## Usage

Your work directory should look like this:

```shell
.
├── all.sh
├── docking.sh
├── fix_model.sh
├── ligands
│   ├── ligand1.mol2
|
├── models
│   ├── receptor1.pdb
│   ├── receptor2.pdb
│   ├── receptor3.pdb
│   ├── receptor4.pdb
│   ├── receptor5.pdb
│   ├── receptor6.pdb
│   ├── receptor7.pdb
│   ├── receptor8.pdb
│   ├── receptor9.pdb
│   ├── receptor10.pdb
│   ├── receptor11.pdb
│   ├── receptor12.pdb
│   ├── receptor13.pdb
│   └── receptor14.pdb
├── prepare_ligand4.py
├── prepare_lig.sh
├── prepare_receptor4.py
```



one command to run this pipeline:

```shell
bash all.sh
```


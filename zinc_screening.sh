################ Download
wget ZINC-downloader-3D-pdbqt.gz.wget
################ copy into same directory
cp */*/* ligands

################ gunzip
cd ligands 
for l in *.pdbqt.gz; do gzip -d "$l"; done

################ mv failed file

mkdir ../redownload_failed_file
mv *.pdbqt.gz ../redownload_failed_file

################ split into diffrents directories
for i in `seq 1 20`; do mkdir -p "folder$i"; find . -type f -maxdepth 1 | head -n 370 | xargs -i mv "{}" "folder$i"; done # n the first foldern ... to last foderm, a to z the number of files in each folders

################ Split pdbqt file into multiplr singles files
source ~/.bashrc
conda activate selo
for mol in *.pdbqt;
do 
vina_split --input "$mol"
rm "$mol"
done

################ Split
for i in `seq 1 10`; do mkdir -p "folder$i"; find . -type f -maxdepth 1 | head -n 10000 | xargs -i mv "{}" "folder$i"; done # n the first foldern ... to last foderm, a to z the number of files in each folders

################ delete specific string
perl -i -pe 's/REMARK  Name = //g' *

################ rename the file name according to the header
for file in *.pdbqt;
do mv "$file" "$(head -1 "$file")".pdbqt
done

################ Change the header
perl -i -pe 's/ZINC/REMARK  Name = ZINC/g' *


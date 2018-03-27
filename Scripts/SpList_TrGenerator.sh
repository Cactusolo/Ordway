#! /bin/bash
ml phyx
species_list=$1
Site_name=$(basename $species_list .txt)

#put all the data for match Opentree under one directory
mkdir Opentree_query

#staring from species list, then format it as query to Opentree
sed 's/_/ /g' $species_list >Opentree_query/${Site_name}_query_ottid

#using Opentree_pytoy to get ottids
echo "using Opentree_pytoy to get ottids"
python /ufrc/soltis/cactus/Dimension/Community_Opentree/opentree_pytoys/src/get_ottids_for_taxa.py Opentree_query/${Site_name}_query_ottid >Opentree_query/${Site_name}_species_names_ottids

#prepare a file just containing ottids for subsestting from the Opentree
awk -F '\t' '{print "ott"$2}' Opentree_query/${Site_name}_species_names_ottids > Opentree_query/${Site_name}_justids.ottids

#Step1: query opentree based on ottids using 
# all vascular plants on OTL: vas_opentree_9.1.tre
# ALLOTB_ottid.tre
# ALLOTB_sp_name.tre
# GBOTB_sp_name.tre
# GBOTB_ottid.tre
echo "query opentree based on ottids"
pxtrt -t /ufrc/soltis/cactus/Dimension/Community_Opentree/vas_opentree_9.1.tre -f Opentree_query/${Site_name}_justids.ottids >Opentree_query/${Site_name}_ottid.tre 2>Opentree_query/${Site_name}_miss_match.txt

#giving a summary how many names missed
Miss_match=$(wc -l Opentree_query/${Site_name}_miss_match.txt|cut -f1 -d' ')
echo -e "There are "$Miss_match" species names missed in Opentree\nPlease check file "Opentree_query/${Site_name}_miss_match.txt""

echo "getting ottid and tip labels for the subtree"
#Step2: getting ottid and tip labels for the subtree
python /ufrc/soltis/cactus/Dimension/Community_Opentree/opentree_pytoys/src/get_all_names_tre.py Opentree_query/${Site_name}_ottid.tre > Opentree_query/${Site_name}_ottree_node_tip_label

python /ufrc/soltis/cactus/Dimension/Community_Opentree/opentree_pytoys/src/get_name_for_ottids.py Opentree_query/${Site_name}_ottree_node_tip_label >Opentree_query/${Site_name}_ottree_node_tip_ottids

echo "Step3:converting ottids to species names for subtree"
#converting ottids to species names for subtree
python /ufrc/soltis/cactus/Dimension/Community_Opentree/opentree_pytoys/src/convert_ottids_names_tre.py Opentree_query/${Site_name}_ottid.tre Opentree_query/${Site_name}_ottree_node_tip_ottids >Opentree_query/${Site_name}_speciesname.tre

#Summerize total nomatch
cat Opentree_query/${Site_name}_query_ottid.nomatch.txt >${Site_name}_Total_nomatch.txt

for id in `cat Opentree_query/${Site_name}_miss_match.txt|cut -f1 -d' '|sed 's/ott//g'`
	do
		grep $id Opentree_query/${Site_name}_species_names_ottids >>${Site_name}_Total_nomatch.txt
done

wc -l ${Site_name}_Total_nomatch.txt

#do ott database query for no match
ml R

Rscript ./Script/ott_name_query.R

#for those miss matched ottids redirect to another file
#pxtrt -t ../Stephen_Brown_tree/ALLOTB_ottid.tre -f data_output/species_plot_justids.ottids >tree_deposit/species_plot_out.tre 2>miss_match_ott.txt
#some extra labels need to remove "mrcaott121ott1439d8s.tre"
#python ../opentree_pytoys/src/get_all_names_tre.py species_plot_out.tre|sed '/tre/d' > all_nodetip_label_on_tree
#python ../opentree_pytoys/src/get_name_for_ottids.py all_nodetip_label_on_tree >all_nodetip_label_ottids_tree
#python ../opentree_pytoys/src/convert_ottids_names_tre.py tree_deposit/species_plot_out.tre all_nodetip_label_ottids_tree >tree_deposit/species_plot_site_final.tre

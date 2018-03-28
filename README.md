# Ordway
Ordway site with __572__ species, __556__ species can be initially matched on Opentree (synthetic tree); Still **16** species miss match: 

Among them,

# 6 names have ottids, but cannot be found in the synthetic tree;   

_Note from Open tree:This taxon is in our taxonomy but not in our tree synthesis database. This can happen for a variety of reasons, but the most probable is that is has a taxon flag (e.g. incertae sedis) that causes it to be pruned from the synthetic tree. See the taxonomy browser for more information about this taxon._

Ceanothus microphyllus	877139 
Dactyloctenium aegyptium	752144 
Heterotheca subaxillaris	206813 
Imperata cylindrica	740074 
Sacciolepis striata	3956672
Serenoa repens  71637

# 5 can be added back in the opentree with ottid after ott, TPL, and tropicos reconsideration; 

Dolichandra unguis-cati	1001573 


Erigeron foliosus var. foliosus as (Erigeron foliosus)	696078 


Gnaphalium antillanum	569718


Zanthoxylum clava-herculis	3942437


Sideroxylon reclinatum subsp. rufotomentosum	as (Sideroxylon reclinatum)	1077723


# 2 are hybrids maybe deleted;

Quercus laevis x hemisphaerica #hybrid delete


Quercus laevis x incana #hybrid delete

# 3 remainin are not found in opentree, but accepted names in other database TPL, Tropics.
Heliopsis buphthalmoides	#not found in opentree, but accepted names in other database TPL, Tropics
Pluchea baccharis	#not found in opentree, but accepted names in other database TPL, Tropics
Verbesina heterophylla#query from Opentree API, best match is "Berberis heterophylla" (totally different family, maybe unreliable)



some of those issues appeared frequently, based on different species list I have tried. It would be great to fix them on OTL side:

* 1. if there is a "-" in species names (e.g., Dolichandra unguis-cati, Zanthoxylum clava-herculis), the script ("get_ottids_for_taxa.py") will fail to grap ottids, so will not present in the result tree.

Those two example names can be found in the Open tree, ottid1001573, and ottid3942437.

* 2. how to add those species in two categories below to the subtree:


  + Cat1: species do have ottid, but not present in the synthetic tree (those two add back in scripts not working on my side)

  + Cat2: species  not found in opentree, but accepted names in other database TPL, and Tropics.

* 3. what approach do you recommend to convert the ottids to species names, phyx or  "convert_ottids_names_tre.py"? The results obtained from both are required manual fixing or modification.
  + A. phyx can only replace ottid (old.name) on the tips labels to  species name (new.name), but those internal-node (mrcaott...) will be still left in the tree, right? So for the internal-labels either manually rename or remove.
  + B. "convert_ottids_names_tre.py" will rename every ottid with names, but usually the tree format (newick) is not valid in the resultant tree file (either "(", or ";" missing ).

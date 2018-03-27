#Opentree subsets
tree572 <- read.tree("./Basedata_Prep/Ordway_572_reduced_names.tre")

taxa <- tree572$tip.label
taxa <- gsub("^.*aceae_", "", taxa)

taxa1 <- taxa[1:200]
taxa2 <- taxa[201:400]
taxa3 <- taxa[401:572]

resolved_names1 <- tnrs_match_names(taxa1, context_name = "Land plants")
resolved_names2 <- tnrs_match_names(taxa2, context_name = "Land plants")
resolved_names3 <- tnrs_match_names(taxa3, context_name = "Land plants")
resolved_names <- rbind.data.frame(resolved_names1, resolved_names2, resolved_names3) %>% 
  na.omit()
resolved_names <- resolved_names[resolved_names$ott_id != "206813", ]
resolved_names <- resolved_names[resolved_names$ott_id != "877139", ]
resolved_names <- resolved_names[resolved_names$ott_id != "3956672", ]
resolved_names <- resolved_names[resolved_names$ott_id != "740074", ]
resolved_names <- resolved_names[resolved_names$ott_id != "752144", ]
resolved_names <- resolved_names[resolved_names$ott_id != "71637", ]
resolved_names <- resolved_names[resolved_names$ott_id != "6009890", ]

open_572_tree <- tol_induced_subtree(ott_ids = resolved_names$ott_id)
open_572_tree
#Get taxa lists for subsets

#Read in subset taxa names
subset100_list <- list.files("../Subset_analysis_files/100_taxon_subsets/", pattern=".fasta", full.names=TRUE)
subset200_list <- list.files("../Subset_analysis_files/200_taxon_subsets/Subsets/", pattern=".fasta", full.names=TRUE)
subset300_list <- list.files("../Subset_analysis_files/300_taxon_subsets/Subsets/", pattern=".fasta", full.names=TRUE)
subset400_list <- list.files("../Subset_analysis_files/400_taxon_subsets/Subsets/", pattern=".fasta", full.names=TRUE)
subset500_list <- list.files("../Subset_analysis_files/500_taxon_subsets/Subsets/", pattern=".fasta", full.names=TRUE)


#Write function to get names from fasta file
get_names_short <- function(file){
  names <- read.fasta(file) %>% 
    names()
  names <- gsub("#\\d+_", "", names)
  names <- gsub("^.*aceae_", "", names)
}

#Run function for each file for each subset
subset100_all_taxa <- lapply(subset100_list, get_names_short)
subset200_all_taxa <- lapply(subset200_list, get_names_short)
subset300_all_taxa <- lapply(subset300_list, get_names_short)
subset300_all_taxa <- lapply(subset300_all_taxa, as.data.frame, stringsAsFactors = FALSE)
subset400_all_taxa <- lapply(subset400_list, get_names_short)
subset400_all_taxa <- lapply(subset400_all_taxa, as.data.frame, stringsAsFactors = FALSE)
subset500_all_taxa <- lapply(subset500_list, get_names_short)
subset500_all_taxa <- lapply(subset500_all_taxa, as.data.frame, stringsAsFactors = FALSE)


#make dataframe for each list of names? like subset300_all_taxa

subset300_otts <- list()
for (i in 1:length(subset300_all_taxa)){
  subset300_otts[[i]] <- resolved_names$ott_id[which(tolower(subset300_all_taxa[[i]]$`X[[i]]`) %in% resolved_names$search_string)]
}
str(subset300_all_taxa)
subset400_otts <- list()
for (i in 1:length(subset400_all_taxa)){
  subset400_otts[[i]] <- resolved_names$ott_id[which(tolower(subset400_all_taxa[[i]]$`X[[i]]`) %in% resolved_names$search_string)]
}

subset500_otts <- list()
for (i in 1:length(subset500_all_taxa)){
  subset500_otts[[i]] <- resolved_names$ott_id[which(tolower(subset500_all_taxa[[i]]$`X[[i]]`) %in% resolved_names$search_string)]
}

#Make function to include plant names only
plant_tnrs <- function(names){
  resolved <- tnrs_match_names(names, context_name = "Land plants")
}


#Match subset names with tnrs
subset100_resolved <- mapply(tnrs_match_names, names = subset100_all_taxa, context_name = "Land plants")
subset100_resolved2 <- lapply(subset100_all_taxa, plant_tnrs)
subset100_resolved3 <- lapply(subset100_resolved2, na.omit)

subset200_resolved <- lapply(subset200_all_taxa, plant_tnrs)
subset200_resolved <- lapply(subset200_resolved, na.omit)

#Get open tree matching resolved subset names
opentree_100 <- list()
opentree_200 <- list()
opentree_300 <- list()
opentree_400 <- list()
opentree_500 <- list()

for (i in 1:length(subset100_resolved3)){
  subset100_resolved3[[i]] <- subset100_resolved3[[i]][subset100_resolved3[[i]]$ott_id != "6009890", ]
  subset100_resolved3[[i]] <- subset100_resolved3[[i]][subset100_resolved3[[i]]$ott_id != "71637", ]
  subset100_resolved3[[i]] <- subset100_resolved3[[i]][subset100_resolved3[[i]]$ott_id != "740074", ]
  subset100_resolved3[[i]] <- subset100_resolved3[[i]][subset100_resolved3[[i]]$ott_id != "752144", ]
  subset100_resolved3[[i]] <- subset100_resolved3[[i]][subset100_resolved3[[i]]$ott_id != "206813", ]
  subset100_resolved3[[i]] <- subset100_resolved3[[i]][subset100_resolved3[[i]]$ott_id != "3956672", ]
  subset100_resolved3[[i]] <- subset100_resolved3[[i]][subset100_resolved3[[i]]$ott_id != "877139", ]
  open_tree <- tol_induced_subtree(subset100_resolved3[[i]]$ott_id)
  opentree_100[[i]] <- open_tree
}
class(opentree_100) <- "multiPhylo"

for (i in 1:length(subset200_resolved)){
  subset200_resolved[[i]] <- subset200_resolved[[i]][subset200_resolved[[i]]$ott_id != "6009890", ]
  subset200_resolved[[i]] <- subset200_resolved[[i]][subset200_resolved[[i]]$ott_id != "71637", ]
  subset200_resolved[[i]] <- subset200_resolved[[i]][subset200_resolved[[i]]$ott_id != "740074", ]
  subset200_resolved[[i]] <- subset200_resolved[[i]][subset200_resolved[[i]]$ott_id != "752144", ]
  subset200_resolved[[i]] <- subset200_resolved[[i]][subset200_resolved[[i]]$ott_id != "206813", ]
  subset200_resolved[[i]] <- subset200_resolved[[i]][subset200_resolved[[i]]$ott_id != "3956672", ]
  subset200_resolved[[i]] <- subset200_resolved[[i]][subset200_resolved[[i]]$ott_id != "877139", ]
  open_tree <- tol_induced_subtree(subset200_resolved[[i]]$ott_id)
  opentree_200[[i]] <- open_tree
}
class(opentree_200) <- "multiPhylo"

for (i in 1:length(subset300_otts)){
  open_tree <- tol_induced_subtree(subset300_otts[[i]])
  opentree_300[[i]] <- open_tree
}
class(opentree_300) <- "multiPhylo"

for (i in 1:length(subset400_otts)){
  open_tree <- tol_induced_subtree(subset400_otts[[i]])
  opentree_400[[i]] <- open_tree
}
class(opentree_400) <- "multiPhylo"

for (i in 1:length(subset500_otts)){
  open_tree <- tol_induced_subtree(subset500_otts[[i]])
  opentree_500[[i]] <- open_tree
  }
class(opentree_500) <- "multiPhylo"

#Write trees to file
write_subset_trees <- function(tree, filename){
  write.tree(tree, filename)
}

#Set names for files to be written
names_of_100opentree <- gsub(".fasta", ".tre",subset100_list) 
names_of_100opentree <- gsub("../Subset_analysis_files/100_taxon_subsets", "./Subset_files/Random_subsets/Opentree/Trees_100", names_of_100opentree)

names_of_200opentree <- gsub(".fasta", ".tre",subset200_list) 
names_of_200opentree <- gsub("../Subset_analysis_files/200_taxon_subsets/Subsets", "./Subset_files/Random_subsets/Opentree/Trees_200", names_of_200opentree)

names_of_300opentree <- gsub(".fasta", ".tre",subset300_list) 
names_of_300opentree <- gsub("../Subset_analysis_files/300_taxon_subsets/Subsets", "./Subset_files/Random_subsets/Opentree/Trees_300", names_of_300opentree)

names_of_400opentree <- gsub(".fasta", ".tre",subset400_list) 
names_of_400opentree <- gsub("../Subset_analysis_files/400_taxon_subsets/Subsets", "./Subset_files/Random_subsets/Opentree/Trees_400", names_of_400opentree)

names_of_500opentree <- gsub(".fasta", ".tre",subset500_list) 
names_of_500opentree <- gsub("../Subset_analysis_files/500_taxon_subsets/Subsets", "./Subset_files/Random_subsets/Opentree/Trees_500", names_of_500opentree)

#Write trees
mapply(write_subset_trees, tree=opentree_100, filename=names_of_100opentree)
mapply(write_subset_trees, tree=opentree_200, filename=names_of_200opentree)
mapply(write_subset_trees, tree=opentree_300, filename=names_of_300opentree)
mapply(write_subset_trees, tree=opentree_400, filename=names_of_400opentree)
mapply(write_subset_trees, tree=opentree_500, filename=names_of_500opentree)

#Get pd calculation for opentrees
#Read community data 
comm_data <- read.csv("./Basedata_Prep/R_community_designations2.csv", stringsAsFactors = FALSE)

comm_data_ot <- comm_data
  
colnames(comm_data_ot) <- gsub(".*aceae_", "", colnames(comm_data))
comm_data_ot[1,] <- gsub(".*aceae_", "", comm_data_ot[1,])


#Calclate PD using picante
#to match lists of taxa in tree and comm files

#Need empty list before running function
PD_list <- list()
#Write function that trims taxa to match tree and comms
#Then calc pd indices
#Creates list of tables for each replicate within a subset
pd_calc_function_ot <- function(phylo) {
  matched <- match.phylo.comm(phylo, comm_data_ot)
  matchtree <- matched$phy
  matchcomm <- matched$comm 
  phydist <- cophenetic(matched$phy)
  ses_mpd_result <- ses.mpd(matchcomm, phydist, null.model="taxa.labels", abundance.weighted = FALSE, runs=99)
  ses_mntd_result <- ses.mntd(matchcomm, phydist, null.model="taxa.labels", runs=99)
  ses_pd_result <-ses.pd(matchcomm, matchtree, null.model="taxa.labels", runs=99)
  pd_result <- pd(matchcomm, matchtree, include.root = TRUE)
  PD_list[[i]] <- data.frame(pd_result, ses_pd_result, ses_mpd_result, ses_mntd_result)
}

#Apply function to replicates for each subset
for (i in 1:length(opentree_100)){
  opentree_100[[i]]$tip.label <- gsub("_ott.*", "", opentree_100[[i]]$tip.label)
  opentree_100[[i]] <- compute.brlen(opentree_100[[i]], 1)
}

for (i in 1:length(opentree_200)){
  opentree_200[[i]]$tip.label <- gsub("_ott.*", "", opentree_200[[i]]$tip.label)
  opentree_200[[i]] <- compute.brlen(opentree_200[[i]], 1)
}

for (i in 1:length(opentree_300)){
  opentree_300[[i]]$tip.label <- gsub("_ott.*", "", opentree_300[[i]]$tip.label)
  opentree_300[[i]] <- compute.brlen(opentree_300[[i]], 1)
}

for (i in 1:length(opentree_400)){
  opentree_400[[i]]$tip.label <- gsub("_ott.*", "", opentree_400[[i]]$tip.label)
  opentree_400[[i]] <- compute.brlen(opentree_400[[i]], 1)
}

for (i in 1:length(opentree_500)){
  opentree_500[[i]]$tip.label <- gsub("_ott.*", "", opentree_500[[i]]$tip.label)
  opentree_500[[i]] <- compute.brlen(opentree_500[[i]], 1)
}

opentree_pd_100 <- lapply(opentree_100, pd_calc_function_ot)
opentree_pd_200 <- lapply(opentree_200, pd_calc_function_ot)
opentree_pd_300 <- lapply(opentree_300, pd_calc_function_ot)
opentree_pd_400 <- lapply(opentree_400, pd_calc_function_ot)
opentree_pd_500 <- lapply(opentree_500, pd_calc_function_ot)

opentree_pd_100[[1]]

#Write files
names_of_100opentree_pd <- gsub(".tre$", ".csv", names_of_100opentree) 
names_of_100opentree_pd <- gsub("./Subset_files/Random_subsets/Opentree/Trees_100/", "./PD_files/R_calc_picante/Prune_vs_recon/Opentree_100/", names_of_100opentree_pd)

names_of_200opentree_pd <- gsub(".tre$", ".csv", names_of_200opentree) 
names_of_200opentree_pd <- gsub("./Subset_files/Random_subsets/Opentree/Trees_200/", "./PD_files/R_calc_picante/Prune_vs_recon/Opentree_200/", names_of_200opentree_pd)

names_of_300opentree_pd <- gsub(".tre$", ".csv", names_of_300opentree) 
names_of_300opentree_pd <- gsub("./Subset_files/Random_subsets/Opentree/Trees_300/", "./PD_files/R_calc_picante/Prune_vs_recon/Opentree_300/", names_of_300opentree_pd)

names_of_400opentree_pd <- gsub(".tre$", ".csv", names_of_400opentree) 
names_of_400opentree_pd <- gsub("./Subset_files/Random_subsets/Opentree/Trees_400/", "./PD_files/R_calc_picante/Prune_vs_recon/Opentree_400/", names_of_400opentree_pd)

names_of_500opentree_pd <- gsub(".tre$", ".csv", names_of_500opentree) 
names_of_500opentree_pd <- gsub("./Subset_files/Random_subsets/Opentree/Trees_500/", "./PD_files/R_calc_picante/Prune_vs_recon/Opentree_500/", names_of_500opentree_pd)

mapply(write_csv, pd_file = opentree_pd_100, filename = names_of_100opentree_pd)
mapply(write_csv, pd_file = opentree_pd_200, filename = names_of_200opentree_pd)
mapply(write_csv, pd_file = opentree_pd_300, filename = names_of_300opentree_pd)
mapply(write_csv, pd_file = opentree_pd_400, filename = names_of_400opentree_pd)
mapply(write_csv, pd_file = opentree_pd_500, filename = names_of_500opentree_pd)


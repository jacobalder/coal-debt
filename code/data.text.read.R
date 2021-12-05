################################################################################
# COAL DEBT SECURITIZATION
# Purpose: Text Analysis
# Learning:   https://data.library.virginia.edu/reading-pdf-files-into-r-for-text-mining/
# Data Sources: 
#               
#               
#               
#               
################################################################################
bill_path = file.path(my_dir,coal_debt,data_path,paste0("bills/securitization_current"))
setwd(bill_path)
bills.files = list.files(path = bill_path, pattern = "pdf", full.names = T)

# lexis_path = file.path(my_dir,coal_debt,data_path,paste0("LEXIS"))
# setwd(lexis_path)
# bills.files = list.files(path = lexis_path, pattern = "pdf", full.names = T)


# Corpus using library(tm)
corp <- Corpus(URISource(bills.files),
               readerControl = list(reader = readPDF))
bills.tdm <- TermDocumentMatrix(corp, control = 
                                     list(stopwords = TRUE,
                                          tolower = TRUE,
                                          stemming = T,
                                          removeNumbers = TRUE,
                                          bounds = list(global = c(3, Inf)))) 

inspect(bills.tdm[1:10,])
corp <- tm_map(corp, removePunctuation, ucp = TRUE)
findFreqTerms(bills.tdm, lowfreq = 100, highfreq = Inf)
ft <- findFreqTerms(bills.tdm, lowfreq = 100, highfreq = Inf)
ft.tdm <- as.matrix(bills.tdm[ft,])
sort(apply(ft.tdm, 1, sum), decreasing = TRUE)

findAssocs(bills.tdm, "secur", .85)
findAssocs(bills.tdm, "public", .85)

# Make a dendogram
bills.tdm.d = removeSparseTerms(sparse = .00185, bills.tdm)

# Create tdm matrix
bills.tdm.m <- as.matrix(bills.tdm.d)

# Create dist
bills.dist <- dist(bills.tdm.m)

# Create hc
hc <- hclust(bills.dist)

# Plot the dendrogram
plot(hc)

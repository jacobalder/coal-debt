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
p_load(Graphviz)

# Function for ease
text.read = function(bill_path,sparse_set){
  setwd(bill_path)
  bills.files = list.files(path = bill_path, pattern = "pdf", full.names = T)
  # Corpus using library(tm)
  corp <- Corpus(URISource(bills.files),
                 readerControl = list(reader = readPDF))
  bills.tdm <- TermDocumentMatrix(corp, control = 
                                       list(stopwords = TRUE,
                                            tolower = TRUE,
                                            stemming = T,
                                            removeNumbers = TRUE,
                                            bounds = list(global = c(4, Inf))))
  bills.tdm %>% weightBin() %>% inspect()
  bills.tdm %>% weightTfIdf(normalize=F) %>% inspect()
  bills.tdm %>% weightTfIdf(normalize=T) %>% inspect()
  bills.stop = c(setdiff(stopwords('english'),c("(a)","bond","secur")),
                 "the","state")
  
  # Print inspection to screen
  inspect(bills.tdm[1:10,])
  corp <- tm_map(corp, removePunctuation, ucp = TRUE)
  # corp <- tm_map(removeWords,bills.stop) 
  findFreqTerms(bills.tdm, lowfreq = 100, highfreq = Inf)
  ft <- findFreqTerms(bills.tdm, lowfreq = 100, highfreq = Inf)
  ft.tdm <- as.matrix(bills.tdm[ft,])
  sort(apply(ft.tdm, 1, sum), decreasing = TRUE)
  
  # Find Associations
  findAssocs(bills.tdm, "securit", .85)
  
  # Make a dendogram
  bills.tdm.d = removeSparseTerms(sparse = sparse_set, bills.tdm)
  
  # Create tdm matrix
  bills.tdm.m <- as.matrix(bills.tdm.d)
  
  # Create dist
  bills.dist <- dist(bills.tdm.m)
  
  # Create hc
  hc <- hclust(bills.dist)
  
  # Plot the dendrogram
  plot(hc)
  # plot(bills.tdm,term = ft, corThreshold = 0.1, weighting = T)
  return(hc)
}

# Start Analysis
securitization_enacted = file.path(bill_path,paste0("securitization_retirement_enacted"))
enacted = text.read(securitization_enacted,0.00085)
save(file.path(my_dir,coal_debt,fig_path,paste0("enacted")),enacted,"png")

securitization_pending = file.path(bill_path,paste0("securitization_retirement_pending"))
pending = text.read(securitization_pending,0.0000085)
save(file.path(my_dir,coal_debt,fig_path,paste0("pending")),pending,"png")


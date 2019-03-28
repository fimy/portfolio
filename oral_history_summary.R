# This uses R to display the top five topics of a collection of documents
# This is adapted from a tutorial published on The Programming Historian by Taylor Arnold
# and Lauren Tilton, found at https://programminghistorian.org/en/lessons/basic-text-processing-in-r#document-summarization-1

# To read my blog post about digital history techniques, go to
# https://history.utah.gov/a-distance-reading-of-immigration-in-carbon-county/

# Install packages
install.packages("tidyverse")
install.packages("tokenizers")

# Load installed packages
library(tidyverse)
library(tokenizers)

# Load corpus and metadata file
input_loc <- "/path/to/folder"
setwd(input_loc)
metadata <- read_csv("metadata.csv")
files <- dir(input_loc, full.names = TRUE)

# Access table of word frequencies
base_url <- "https://programminghistorian.org/assets/basic-text-processing-in-r"
wf <- read_csv(sprintf("%s/%s", base_url, "word_freqency.csv"))

# Process document summaries
text <- c()
for (f in files) {
  text <- c(text, paste(readLines(f), collapse = "\n"))
}

description <- c()
for (i in 1:length(words)) {
  tab <- table(words[[i]])
  tab <- data_frame(word = names(tab), count = as.numeric(tab))
  tab <- arrange(tab, desc(count))
  tab <- inner_join(tab, wf)
  tab <- filter(tab, frequency < 0.002)
  
  result <- c(metadata$Narrator[i], metadata$year[i], tab$word[1:5])
  description <- c(description, paste(result, collapse = "; "))
}

description

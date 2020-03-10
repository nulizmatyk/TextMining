#zaladowanie bibliotek
library(tm)

#zmiana katalogu roboczego
workDir <- "D:\\MO\\TextMinning"
setwd(workDir)

#definicja katalogów funkcjonalnych
inputDir <- ".\\data"
outputDir <- ".\\results"
scritsDir <- ".\\scripts"
workspacesDir <- ".\\workspaces"
dir.create(outputDir, showWarnings = TRUE)
dir.create(workspacesDir, showWarnings = TRUE)

#utworzenie korpusu dokumentu

corpusDir <- paste(inputDir,
   "\\",
   "Literatura - streszczenia - oryginał",
   sep = ""
   )

corpus <- VCorpus(
  DirSource(
    corpusDir,
    pattern = "*.txt",
    encoding = "UTF-8"
  ),
  readerControl = list(
    language ="pl_PL"
  )
)

#wstepne przetwarzanie
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, content_transformer(tolower))
stopListFile <- paste(inputDir,
                      "\\",
                      "stopwords_pl.txt",
                      sep = ""
)
stopList <- readLines(stopListFile, encoding = "UTF-8")
corpus <- tm_map(corpus, removeWords, stopList)


writeLines(as.character(corpus[[1]]))
writeLines(corpus[[1]]$content)



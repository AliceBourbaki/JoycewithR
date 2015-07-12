#Joyce with R : nuage de mots

# Etape 1 : Ouvrir R

# Etape 2 : Charger les librairies necessaires

library(tm)
library(SnowballC)
library(wordcloud)

# Etape 3 : Charger les donnees, situees sur PATH

setwd('PATH') 
texts  <-Corpus(DirSource("PATH"), readerControl = list(language="lat")) 

# Verifier que les donnes ont bel et bien ete chargees. 

summary(texts)

# Etape 4 : Nettoyer les donnees.

texts <- tm_map(texts, removeNumbers)
texts <- tm_map(texts, removePunctuation)
texts <- tm_map(texts , stripWhitespace)
texts <- tm_map(texts, content_transformer(tolower))
texts <- tm_map(texts, removeWords, stopwords("english"))
texts <- tm_map(texts, stemDocument, language = "english")

# Etape 5 : Créer une matrice.

TDM <- TermDocumentMatrix(texts)

# Etape 6 : Enlever les termes n'étant pas utiliser suffisament de fois.

TDM.common = removeSparseTerms(TDM, 0.1)

# Etape 8 : preparer pour le decompte des mots

TDM.dense <- as.matrix(TDM.common)

# Etape 9 : creer le nuage de mots

palette <- brewer.pal(9,"BuGn")[-(1:4)]
wordcloud(rownames(TDM.dense), rowSums(TDM.dense), min.freq = 1, color = palette)


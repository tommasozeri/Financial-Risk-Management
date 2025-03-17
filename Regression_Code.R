library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(nlme)
library(tibble)
library(purrr)
library(splines)

## Importazione dei dati e sistemazione dati

# gdp_uk_final <- read_excel("UK_GDP_Data.xls") %>%
  # select(-1, -2, -3, -4)
# gdp_uk_final <- as.data.frame(t(gdp_uk_final))
# rownames(gdp_uk_final) <- colnames(gdp_uk_final)
# colnames(gdp_uk_final) <- c("Values")
# gdp_uk_final <- rbind(gdp_uk_final, c(2559803000000))
# rownames(gdp_uk_final)[length(rownames(gdp_uk_final))] <- "2024"

#CAMBIARE FILE PATH


#CDS UK
cds_uk_final <- read_excel("CDSSPREADS.xlsx") %>%
  select(-2, -3, -5, -6, -7, -8)
cds_uk_final$Date <- as.Date(cds_uk_final$Date)
cds_uk_final <- cds_uk_final %>%
  column_to_rownames("Date")
colnames(cds_uk_final) <- c("Values")

#CDS TURKEY
cds_tky_final <- read_excel("CDSSPREADS.xlsx") %>%
  select(-3, -4, -5, -6, -7, -8)
cds_tky_final$Date <- as.Date(cds_tky_final$Date)
cds_tky_final <- cds_tky_final %>%
  column_to_rownames("Date")
colnames(cds_tky_final) <- c("Values")

#CDS ITALY
cds_it_final <- read_excel("CDSSPREADS.xlsx") %>%
  select(-2, -4, -5, -6, -7, -8)
cds_it_final$Date <- as.Date(cds_it_final$Date)
cds_it_final <- cds_it_final %>%
  column_to_rownames("Date")
colnames(cds_it_final) <- c("Values")

#CDS SPAIN
cds_sp_final <- read_excel("CDSSPREADS.xlsx") %>%
  select(-2, -3, -4, -6, -7, -8)
cds_sp_final$Date <- as.Date(cds_sp_final$Date)
cds_sp_final <- cds_sp_final %>%
  column_to_rownames("Date")
colnames(cds_sp_final) <- c("Values")

#CDS GREECE
cds_gk_final <- read_excel("CDSSPREADS.xlsx") %>%
  select(-2, -3, -4, -5, -6, -7)
cds_gk_final$Date <- as.Date(cds_gk_final$Date)
cds_gk_final <- cds_gk_final %>%
  column_to_rownames("Date")
colnames(cds_gk_final) <- c("Values")

#CDS FRANCE
cds_fr_final <- read_excel("CDSSPREADS.xlsx") %>%
  select(-2, -3, -4, -5, -7, -8)
cds_fr_final$Date <- as.Date(cds_fr_final$Date)
cds_fr_final <- cds_fr_final %>%
  column_to_rownames("Date")
colnames(cds_fr_final) <- c("Values")

#CDS GERMANY
cds_ge_final <- read_excel("CDSSPREADS.xlsx") %>%
  select(-2, -3, -4, -5, -6, -8)
cds_ge_final$Date <- as.Date(cds_ge_final$Date)
cds_ge_final <- cds_ge_final %>%
  column_to_rownames("Date")
colnames(cds_ge_final) <- c("Values")

#OIL FUTURES
oil_future <- read.csv("Oil Data/Future Petrolio Greggio WTI Dati Storici (1).csv") %>%
  select(-3, -4, -5, -6, -7)
oil_future$Data <- as.Date(oil_future$Data, format="%d.%m.%Y")
oil_future <- oil_future %>%
  column_to_rownames("Data")
colnames(oil_future) <- c("Values")

#EXCHANGE RATE EUR-GBP
eur_gbp <- read.csv("Exchange Rate Data/EUR_GBP Dati Storici.csv") %>% 
  select(-3, -4, -5, -6, -7)
eur_gbp$Data <- as.Date(eur_gbp$Data, format="%d.%m.%Y")
eur_gbp <- eur_gbp %>%
  column_to_rownames("Data")
colnames(eur_gbp) <- c("Values")

#GAS FUTURES
gas_future <- read.csv("Gas Data/Future Gas naturale Dati Storici.csv") %>%
  select(-3, -4, -5, -6, -7)
gas_future$Data <- as.Date(gas_future$Data, format="%d.%m.%Y")
gas_future <- gas_future %>%
  column_to_rownames("Data")
colnames(gas_future) <- c("Values")

#SPREAD UK-BUND
uk_spread <- read.csv("Spread Data/UK 10 Year vs Germany 10 Year Spread Dati Storici Rendimento Bond.csv") %>%
  select(-3, -4, -5, -6)
uk_spread$Data <- as.Date(uk_spread$Data, format="%d.%m.%Y")
uk_spread <- uk_spread %>%
  column_to_rownames("Data")
colnames(uk_spread) <- c("Values")

#SPREAD TURKEY-BUND
tky_spread <- read.csv("Spread Data/Turkey 10 Year vs Germany 10 Year Spread Dati Storici Rendimento Bond.csv") %>%
  select(-3, -4, -5, -6)
tky_spread$Data <- as.Date(tky_spread$Data, format="%d.%m.%Y")
tky_spread <- tky_spread %>%
  column_to_rownames("Data")
colnames(tky_spread) <- c("Values")

#SPREAD BTP-BUND
it_spread <- read.csv("Spread Data/Btp Italia 10 anni - Bond Germania 10 anni Dati Storici Rendimento Bond.csv") %>%
  select(-3, -4, -5, -6)
it_spread$Data <- as.Date(it_spread$Data, format="%d.%m.%Y")
it_spread <- it_spread %>%
  column_to_rownames("Data")
colnames(it_spread) <- c("Values")

#SPREAD SP-BUND
sp_spread <- read.csv("Spread Data/Spain 10 Year vs Germany 10 Year Spread Dati Storici Rendimento Bond.csv") %>%
  select(-3, -4, -5, -6)
sp_spread$Data <- as.Date(sp_spread$Data, format="%d.%m.%Y")
sp_spread <- sp_spread %>%
  column_to_rownames("Data")
colnames(sp_spread) <- c("Values")

#SPREAD GREECE-BUND
gk_spread <- read.csv("Spread Data/Greece 10 Year vs Germany 10 Year Spread Dati Storici Rendimento Bond.csv") %>%
  select(-3, -4, -5, -6)
gk_spread$Data <- as.Date(gk_spread$Data, format="%d.%m.%Y")
gk_spread <- gk_spread %>%
  column_to_rownames("Data")
colnames(gk_spread) <- c("Values")

#SPREAD FR-BUND
fr_spread <- read.csv("Spread Data/France 10 Year vs Germany 10 Year Spread Dati Storici Rendimento Bond.csv") %>%
  select(-3, -4, -5, -6)
fr_spread$Data <- as.Date(fr_spread$Data, format="%d.%m.%Y")
fr_spread <- fr_spread %>%
  column_to_rownames("Data")
colnames(fr_spread) <- c("Values")

#SPREAD US-BUND
ge_spread <- read.csv("Spread Data/US 10 Year vs Germany 10 Year Spread Dati Storici Rendimento Bond.csv") %>%
  select(-3, -4, -5, -6)
ge_spread$Data <- as.Date(ge_spread$Data, format="%d.%m.%Y")
ge_spread <- ge_spread %>%
  column_to_rownames("Data")
colnames(ge_spread) <- c("Values")

#CISS
CISS <- read.csv("Indicator Stress/ECB Data Portal_20250314123801.csv") %>%
  select(-2)
CISS$DATE <- as.Date(CISS$DATE, format="%Y-%m-%d")
CISS <- CISS %>%
  column_to_rownames("DATE")
colnames(CISS) <- c("Values")

#VIX
VIX <- read.csv("VIX/STOXX 50 Volatility VSTOXX EUR Historical Data.csv") %>%
  select(-3, -4, -5, -6, -7)
VIX$Date <- as.Date(VIX$Date, format="%m/%d/%Y")
VIX <- VIX %>%
  column_to_rownames("Date")
colnames(VIX) <- c("Values")


oil_future <- data.frame(Date = rownames(oil_future), Oil_Price = oil_future$Values, stringsAsFactors = FALSE)
gas_future <- data.frame(Date = rownames(gas_future), Gas_Price = gas_future$Values, stringsAsFactors = FALSE)
CISS <- data.frame(Date = rownames(CISS), CISS = CISS$Values, stringsAsFactors = FALSE)
VIX <- data.frame(Date = rownames(VIX), VIX = VIX$Values, stringsAsFactors = FALSE)

eur_gbp <- data.frame(Date = rownames(eur_gbp), EUR_GBP = eur_gbp$Values, stringsAsFactors = FALSE)
cds_uk_final <- data.frame(Date = rownames(cds_uk_final), CDS_Price = cds_uk_final$Values, stringsAsFactors = FALSE)
uk_spread <- data.frame(Date = rownames(uk_spread), Spread_UK = uk_spread$Values, stringsAsFactors = FALSE)

tky_spread <- data.frame(Date = rownames(tky_spread), Spread_TKY = tky_spread$Values, stringsAsFactors = FALSE)
cds_tky_final <- data.frame(Date = rownames(cds_tky_final), CDS_Price = cds_tky_final$Values, stringsAsFactors = FALSE)

it_spread <- data.frame(Date = rownames(it_spread), Spread_IT = it_spread$Values, stringsAsFactors = FALSE)
cds_it_final <- data.frame(Date = rownames(cds_it_final), CDS_Price = cds_it_final$Values, stringsAsFactors = FALSE)

sp_spread <- data.frame(Date = rownames(sp_spread), Spread_SP = sp_spread$Values, stringsAsFactors = FALSE)
cds_sp_final <- data.frame(Date = rownames(cds_sp_final), CDS_Price = cds_sp_final$Values, stringsAsFactors = FALSE)

gk_spread <- data.frame(Date = rownames(gk_spread), Spread_GK = gk_spread$Values, stringsAsFactors = FALSE)
cds_gk_final <- data.frame(Date = rownames(cds_gk_final), CDS_Price = cds_gk_final$Values, stringsAsFactors = FALSE)

fr_spread <- data.frame(Date = rownames(fr_spread), Spread_FR = fr_spread$Values, stringsAsFactors = FALSE)
cds_fr_final <- data.frame(Date = rownames(cds_fr_final), CDS_Price = cds_fr_final$Values, stringsAsFactors = FALSE)

ge_spread <- data.frame(Date = rownames(ge_spread), Spread_GE = ge_spread$Values, stringsAsFactors = FALSE)
cds_ge_final <- data.frame(Date = rownames(cds_ge_final), CDS_Price = cds_ge_final$Values, stringsAsFactors = FALSE)


# Unire tutti i dataset mantenendo solo le righe comuni
combined_data_UK <- reduce(list(cds_uk_final, oil_future, eur_gbp, gas_future, uk_spread, CISS, VIX), function(x, y) {
  merge(x, y, by = "Date", all = FALSE)
})

combined_data_TKY <- reduce(list(cds_tky_final, oil_future, gas_future, tky_spread, CISS), function(x, y) {
  merge(x, y, by = "Date", all = FALSE)
})

combined_data_IT <- reduce(list(cds_it_final, oil_future, gas_future, it_spread, CISS, VIX), function(x, y) {
  merge(x, y, by = "Date", all = FALSE)
})

combined_data_SP <- reduce(list(cds_sp_final, oil_future, gas_future, sp_spread, CISS, VIX), function(x, y) {
  merge(x, y, by = "Date", all = FALSE)
})

combined_data_GK <- reduce(list(cds_gk_final, oil_future, gas_future, gk_spread, CISS, VIX), function(x, y) {
  merge(x, y, by = "Date", all = FALSE)
})

combined_data_FR <- reduce(list(cds_fr_final, oil_future, gas_future, fr_spread, CISS, VIX), function(x, y) {
  merge(x, y, by = "Date", all = FALSE)
})

combined_data_GE <- reduce(list(cds_ge_final, oil_future, gas_future, ge_spread, CISS, VIX), function(x, y) {
  merge(x, y, by = "Date", all = FALSE)
})


# Assicurarsi che la colonna Date sia in formato data
combined_data_UK$Date <- as.Date(combined_data_UK$Date)
combined_data_UK <- combined_data_UK %>%
  mutate(
    Oil_Price = as.numeric(gsub(",", ".", Oil_Price)),
    EUR_GBP = as.numeric(gsub(",", ".", EUR_GBP)),
    CDS_Price = as.numeric(gsub(",", ".", CDS_Price)),
    Gas_Price = as.numeric(gsub(",", ".", Gas_Price)),
    Spread_UK = as.numeric(gsub(",", ".", Spread_UK)),
    CISS = as.numeric(gsub(",", ".", CISS)),
    VIX = as.numeric(gsub(",", ".", VIX))
  )

combined_data_TKY$Date <- as.Date(combined_data_TKY$Date)
combined_data_TKY <- combined_data_TKY %>%
  mutate(
    Oil_Price = as.numeric(gsub(",", ".", Oil_Price)),
    CDS_Price = as.numeric(gsub(",", ".", CDS_Price)),
    Gas_Price = as.numeric(gsub(",", ".", Gas_Price)),
    Spread_TKY = as.numeric(gsub(",", ".", gsub("\\.", "", Spread_TKY))), # Rimuove i punti e cambia la virgola in punto
    CISS = as.numeric(gsub(",", ".", CISS))
  )

combined_data_IT$Date <- as.Date(combined_data_IT$Date)
combined_data_IT <- combined_data_IT %>%
  mutate(
    Oil_Price = as.numeric(gsub(",", ".", Oil_Price)),
    CDS_Price = as.numeric(gsub(",", ".", CDS_Price)),
    Gas_Price = as.numeric(gsub(",", ".", Gas_Price)),
    Spread_IT = as.numeric(gsub(",", ".", Spread_IT)),
    CISS = as.numeric(gsub(",", ".", CISS)),
    VIX = as.numeric(gsub(",", ".", VIX))
  )

combined_data_SP$Date <- as.Date(combined_data_SP$Date)
combined_data_SP <- combined_data_SP %>%
  mutate(
    Oil_Price = as.numeric(gsub(",", ".", Oil_Price)),
    CDS_Price = as.numeric(gsub(",", ".", CDS_Price)),
    Gas_Price = as.numeric(gsub(",", ".", Gas_Price)),
    Spread_SP = as.numeric(gsub(",", ".", Spread_SP)),
    CISS = as.numeric(gsub(",", ".", CISS)),
    VIX = as.numeric(gsub(",", ".", VIX))
  )

combined_data_GK$Date <- as.Date(combined_data_GK$Date)
combined_data_GK <- combined_data_GK %>%
  mutate(
    Oil_Price = as.numeric(gsub(",", ".", Oil_Price)),
    CDS_Price = as.numeric(gsub(",", ".", CDS_Price)),
    Gas_Price = as.numeric(gsub(",", ".", Gas_Price)),
    Spread_GK = as.numeric(gsub(",", ".", Spread_GK)),
    CISS = as.numeric(gsub(",", ".", CISS)),
    VIX = as.numeric(gsub(",", ".", VIX))
  )

combined_data_FR$Date <- as.Date(combined_data_FR$Date)
combined_data_FR <- combined_data_FR %>%
  mutate(
    Oil_Price = as.numeric(gsub(",", ".", Oil_Price)),
    CDS_Price = as.numeric(gsub(",", ".", CDS_Price)),
    Gas_Price = as.numeric(gsub(",", ".", Gas_Price)),
    Spread_FR = as.numeric(gsub(",", ".", Spread_FR)),
    CISS = as.numeric(gsub(",", ".", CISS)),
    VIX = as.numeric(gsub(",", ".", VIX))
  )

combined_data_GE$Date <- as.Date(combined_data_GE$Date)
combined_data_GE <- combined_data_GE %>%
  mutate(
    Oil_Price = as.numeric(gsub(",", ".", Oil_Price)),
    CDS_Price = as.numeric(gsub(",", ".", CDS_Price)),
    Gas_Price = as.numeric(gsub(",", ".", Gas_Price)),
    Spread_GE = as.numeric(gsub(",", ".", Spread_GE)),
    CISS = as.numeric(gsub(",", ".", CISS)),
    VIX = as.numeric(gsub(",", ".", VIX))
  )

# Regressione Lineare UK
uk_lm_model <- lm(CDS_Price ~ bs(Oil_Price, knots=c(50, 75, 100)) + bs(EUR_GBP, degree = 3) + ns(Gas_Price, knots = c(2.5, 5.0, 7.5)) + bs(Spread_UK, knots = c(100, 150)) + bs(CISS, knots = c(0.2, 0.3, 0.4)) + log(VIX), data = combined_data_UK)
uk_summary_lm <- summary(uk_lm_model)
print(uk_summary_lm)

# Regressione Lineare TURKEY
tky_lm_model <- lm(CDS_Price ~ bs(Oil_Price, knots=c(50, 75, 100)) + ns(Gas_Price, knots = c(2.5, 5.0, 7.5)) + bs(Spread_TKY, knots = c(100, 150)) + bs(CISS, knots = c(0.2, 0.3, 0.4)), data = combined_data_TKY)
tky_summary_lm <- summary(tky_lm_model)
print(tky_summary_lm)

# Regressione Lineare IT
it_lm_model <- lm(CDS_Price ~ bs(Oil_Price, knots=c(50, 75, 100)) + ns(Gas_Price, knots = c(2.5, 5.0, 7.5)) + bs(Spread_IT, knots = c(100, 150)) + bs(CISS, knots = c(0.2, 0.3, 0.4)) + log(VIX), data = combined_data_IT)
it_summary_lm <- summary(it_lm_model)
print(it_summary_lm)

# Regressione Lineare SP
sp_lm_model <- lm(CDS_Price ~ bs(Oil_Price, knots=c(50, 75, 100)) + ns(Gas_Price, knots = c(2.5, 5.0, 7.5)) + bs(Spread_SP, knots = c(100, 150)) + bs(CISS, knots = c(0.2, 0.3, 0.4)) + log(VIX), data = combined_data_SP)
sp_summary_lm <- summary(sp_lm_model)
print(sp_summary_lm)

# Regressione Lineare GK
gk_lm_model <- lm(CDS_Price ~ bs(Oil_Price, knots=c(50, 75, 100)) + ns(Gas_Price, knots = c(2.5, 5.0, 7.5)) + bs(Spread_GK, knots = c(100, 150)) + bs(CISS, knots = c(0.2, 0.3, 0.4)) + log(VIX), data = combined_data_GK)
gk_summary_lm <- summary(gk_lm_model)
print(gk_summary_lm)

# Regressione Lineare FR
fr_lm_model <- lm(CDS_Price ~ bs(Oil_Price, knots=c(50, 75, 100)) + ns(Gas_Price, knots = c(2.5, 5.0, 7.5)) + bs(Spread_FR, knots = c(100, 150)) + bs(CISS, knots = c(0.2, 0.3, 0.4)) + log(VIX), data = combined_data_FR)
fr_summary_lm <- summary(fr_lm_model)
print(fr_summary_lm)

# Regressione Lineare GE
ge_lm_model <- lm(CDS_Price ~ bs(Oil_Price, knots=c(50, 75, 100)) + ns(Gas_Price, knots = c(2.5, 5.0, 7.5)) + bs(Spread_GE, knots = c(100, 150)) + bs(CISS, knots = c(0.2, 0.3, 0.4)) + log(VIX), data = combined_data_GE)
ge_summary_lm <- summary(ge_lm_model)
print(ge_summary_lm)


#Spiegazione di bs(EUR_GBP, degree = 3)
#Spline o Regressione Segmentata
#Anche se vuoi includere la variabile una sola volta, potresti considerare l'uso di una spline 
#o di una regressione segmentata, che consente di modellare non linearità e punti di flesso 
#senza introdurre esplicitamente potenze superiori della variabile:

# Regressione Non Lineare - esempio con un modello polinomiale
 #nls_model <- nls(CDS_Price ~ a * Oil_Price + b * EUR_GBP^2, data = combined_data, start = list(a = 1, b = 1))
# summary_nls <- summary(nls_model)
# print(summary_nls)


# Grafico scatter plot per CDS_Price vs Oil_Price
ggplot(combined_data, aes(x = Oil_Price, y = CDS_Price)) +
  geom_point() +
  labs(title = "Scatter Plot of CDS Price vs Oil Price",
       x = "Oil Price",
       y = "CDS Price") +
  theme_minimal()

# Grafico scatter plot per CDS_Price vs EUR_GBP
ggplot(combined_data, aes(x = EUR_GBP, y = CDS_Price)) +
  geom_point() +
  labs(title = "Scatter Plot of CDS Price vs EUR/GBP Exchange Rate",
       x = "EUR/GBP Exchange Rate",
       y = "CDS Price") +
  theme_minimal()

# Grafico scatter plot per CDS_Price vs Gas_Price
ggplot(combined_data, aes(x = Gas_Price, y = CDS_Price)) +
  geom_point() +
  labs(title = "Scatter Plot of CDS Price vs Gas Price",
       x = "Gas Price",
       y = "CDS Price") +
  theme_minimal()

# Grafico scatter plot per Spread vs CDS_Price
ggplot(combined_data, aes(x = Spread, y = CDS_Price)) +
  geom_point() +
  labs(title = "Scatter Plot of CDS Price vs Spreads",
       x = "Spread",
       y = "CDS Price") +
  theme_minimal()

# Grafico scatter plot per CISS vs CDS_Price
ggplot(combined_data, aes(x = CISS, y = CDS_Price)) +
  geom_point() +
  labs(title = "Scatter Plot of CDS Price vs CISS",
       x = "CISS",
       y = "CDS Price") +
  theme_minimal()

# Grafico scatter plot per VIX vs CDS_Price
ggplot(combined_data, aes(x = VIX, y = CDS_Price)) +
  geom_point() +
  labs(title = "Scatter Plot of CDS Price vs VIX",
       x = "VIX",
       y = "CDS Price") +
  theme_minimal()

#UK
prediction_df <- data.frame(
  Actual = combined_data_UK$CDS_Price,
  Predicted = fitted(uk_lm_model)
)

ggplot(prediction_df, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Observed Real Values vs Predictive",
       x = "Observed CDS Price",
       y = "Predictive CDS Price") +
  theme_minimal()

#TURKEY
prediction_df_1 <- data.frame(
  Actual = combined_data_TKY$CDS_Price,
  Predicted = fitted(tky_lm_model)
)

ggplot(prediction_df_1, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Observed Real Values vs Predictive",
       x = "Observed CDS Price",
       y = "Predictive CDS Price") +
  theme_minimal()

#ITALY
prediction_df_2 <- data.frame(
  Actual = combined_data_IT$CDS_Price,
  Predicted = fitted(it_lm_model)
)

ggplot(prediction_df_2, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Observed Real Values vs Predictive",
       x = "Observed CDS Price",
       y = "Predictive CDS Price") +
  theme_minimal()

#SPAIN
prediction_df_3 <- data.frame(
  Actual = combined_data_SP$CDS_Price,
  Predicted = fitted(sp_lm_model)
)

ggplot(prediction_df_3, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Observed Real Values vs Predictive",
       x = "Observed CDS Price",
       y = "Predictive CDS Price") +
  theme_minimal()

#GERMANY
prediction_df_4 <- data.frame(
  Actual = combined_data_GE$CDS_Price,
  Predicted = rep(NA, nrow(combined_data_GE))  
)

prediction_df_4$Predicted[!is.na(combined_data_GE$CDS_Price)] <- fitted(ge_lm_model)

ggplot(prediction_df_4, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Observed Real Values vs Predictive",
       x = "Observed CDS Price",
       y = "Predictive CDS Price") +
  theme_minimal()

#GREECE
combined_data_GK_clean <- na.omit(combined_data_GK)

gk_lm_model <- lm(CDS_Price ~ ., data = combined_data_GK_clean)

prediction_df_5 <- data.frame(
  Actual = combined_data_GK_clean$CDS_Price,
  Predicted = fitted(gk_lm_model)
)

ggplot(prediction_df_5, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Observed Real Values vs Predictive",
       x = "Observed CDS Price",
       y = "Predictive CDS Price") +
  theme_minimal()

#FRANCE
prediction_df_6 <- data.frame(
  Actual = combined_data_FR$CDS_Price,
  Predicted = fitted(fr_lm_model)
)

ggplot(prediction_df_6, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Observed Real Values vs Predictive",
       x = "Observed CDS Price",
       y = "Predictive CDS Price") +
  theme_minimal()
 
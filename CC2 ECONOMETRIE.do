*CC2 ECONOMETRIE   Amina Mahaman Lawan 262028 base6dta

*Nature des variables :
* Continues : Amount MPHover age 
* Discretes binaires : Female, Black, Hispanic, Outsate
*1 Statisques Descriptives
*VARIABLE CONTINUE Amount

*sum Amount, detail

* Statistiques descriptives permettant de caractériser la distribution (la moyenne, la médiane, l'écart-type, le minimum, le maximum) et repérer les valeurs extrêmes
sum Amount
sum Amount, detail
*VARIABLE CONTINUE MPHover
sum MPHover
sum MPHover, detail
*VARIABLE CONTINUE Age
sum age
sum age, detail
* VARIABLE DISCRETE
tab Female
tab Black
tab Hispanic
tab OutState

*2 REGRESSION SIMPLE - MODELE 1
regress Amount Age
*INTERPRETATION: année supplémentaire diminue le montant de la contravention en moyenne de 131 $ USD. Cet effet est statistiquement significatif aux seuils de 1 % et 5 % (p-value < 0,01 et < 0,05)
sum Amount Age
* Pour analyser l'ampleur de cet effet, il faut "contextualiser" l'effet de "131 USD". Par exemple, une CONTRATION "moyenne" coûte 17 $ 
* R2 : L'age du conducteur expplique 0,43 % de son prix (R² = 0,0043), le reste étant donc expliqué par d'autres facteurs non inclus dans la régression

*3 REGRESSION MULTIPLE MODELE 2

regress Amount Age MPHover
pwcorr Age MPHover, sig 
*INTERPRETATION : avec l'inclusion de la variable MPHover, le coefficient de la variable Age augmente et passe de -.29 à .028.

*Cette différence s'explique par le fait que dans la Régression 1, nous ne tenons pas compte du depassement de vitesse autorisée, alors que c'est une variable importante dans le montant de la contravention ( influence le  montant de ce dernier ). Les variables Age et MPHover sont negativement corrélées entre elles.le coefficient de la variable AREA était donc sousestimé dans la Régression 1. La Régression 2 compare les contravention "toutes choses égales par ailleurs", c'est-à-dire avec l'age du conducteur et le dépassement de vistesse autorisée, et fournit un résultat moins biaisé.

*4 MODELE 3
regress Amount Age MPHover Female Black Hispanic OutState
* Interprétation :
*AGE: Cet effet est n'est pas statistiquement significatif aux seuils de 1 %,5 %(p-value < 0,01 et < 0,05).

*MPHover: Chaque depassement de vitesse supplémentaire augmente le montant de la contravention de  7 $ USD en moyenne. Cet effet est statistiquement significatif aux seuils de 1 % et 5 % (p-value < 0,01 et < 0,05).

*Female: Le montant de la contravention baisse quand le conducteur est une femme de 3 $ USD en moyenne. Cet effet est statistiquement significatif aux seuils de 1 % et 5 % (p-value < 0,01 et < 0,05).

*Black: Cet effet est n'est pas statistiquement significatif aux seuils de 1 %,5 %(p-value < 0,01 et < 0,05).

*Hispanic: Le montant de la contravention augmente de 2,86 $ USD en moyenne quand le conducteur est Hispanique ou Latino-Americain. Cet effet est statistiquement significatif aux seuils de 1 % et 5 % (p-value < 0,01 et < 0,05).

*OutState: Le montant de la contravention augmente de 9.79 $ USD en moyenne quand le conducteur reside dans un autre ETAT. Cet effet est statistiquement significatif aux seuils de 1 % et 5 % (p-value < 0,01 et < 0,05)

*5. ANALYSE DE L'HETEROGEITE DU MODELE  avec la variable MPHover au carré (Modèle 2).
*MODELE 2 en ln
gen lnAmount=ln(Amount)
regress lnAmount Age MPHover
generate MPHover_squared = MPHover^2
regress lnAmount Age MPHover MPHover_squared

*effet d'une vitesse supplémentaire? de 1 miles = augmentation de 8.28%
di (_b[MPHover] +2*_b[MPHover_squared]*0)*100

* Effet de 20 miles? = 4,9%
di (_b[MPHover] +2*_b[MPHover_squared]*20)*100

* Efft de 50 miles ? = -0.16%
di (_b[MPHover] +2*_b[MPHover_squared]*50)*100

* Effet de 100 miles ? = -8.61%
di (_b[MPHover] +2*_b[MPHover_squared]*100)*100

* L'effet est negatif, mais croissant (car le coef estimé de la variable MPHover_squared est negatf et celui de la variable MPHover est positif).








** SPSS Script to convert AES subset from POR to SAV **.
** Execute in SPSS **.

IMPORT 
  FILE='filelocation/aes_subset/aes2010_subset.por'. 
DATASET NAME DataSet1 WINDOW=FRONT. 
 
SAVE OUTFILE='filelocation/aes_subset/aes2010_subset.sav' 
  /COMPRESSED.
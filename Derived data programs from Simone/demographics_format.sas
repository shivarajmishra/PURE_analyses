proc format ;
  value DFSTATv  0 = "lost"
                 1 = "clean"
                 2 = "dirty"
                 3 = "error"
                 4 = "CLEAN"
                 5 = "DIRTY"
                 6 = "ERROR" ;
  value ecostu   1 = "Sq Meters"
                 2 = "Sq Ft" ;
  value estate   1 = "Centred"
                 2 = "Non-centred"
                 3 = "Other" ;
  value eruralc  1 = "No"
                 2 = "Yes" ;
  value elatnscc 1 = "N"
                 2 = "S" ;
  value elongewcc 1 = "E"
                 2 = "W" ;
  value ecomconb    1 = "No"
                 2 = "Yes" ;
  value ecomcont    1 = "No"
                 2 = "Yes" ;
  value eppark    1 = "No"
                 2 = "Yes" ;                 
  value elatnspp 1 = "N"
                 2 = "S" ;
  value elonewpp 1 = "E"
                 2 = "W" ;
  value eprsch    1 = "No"
                 2 = "Yes" ;                 
  value elatnsps 1 = "N"
                 2 = "S" ;
  value elonewps 1 = "E"
                 2 = "W" ;
  value esecsch   1 = "No"
                 2 = "Yes" ;                 
  value elatnsss 1 = "N"
                 2 = "S" ;
  value elonewss 1 = "E"
                 2 = "W" ;
  value euniv   1 = "No"
                 2 = "Yes" ;                  
  value elatnsun 1 = "N"
                 2 = "S" ;
  value elonewun 1 = "E"
                 2 = "W" ;
  value epostoff   1 = "No"
                 2 = "Yes" ;                 
  value elatnspo 1 = "N"
                 2 = "S" ;
  value elonewpo 1 = "E"
                 2 = "W" ;
  value ebank   1 = "No"
                 2 = "Yes" ;                  
  value elatnsbk 1 = "N"
                 2 = "S" ;
  value elonewbk 1 = "E"
                 2 = "W" ;
  value egovb   1 = "No"
                 2 = "Yes" ;                 
  value elatnsgv 1 = "N"
                 2 = "S" ;
  value elonewgv 1 = "E"
                 2 = "W" ;
  value etrsta   1 = "No"
                 2 = "Yes" ;                  
  value elatnstr 1 = "N"
                 2 = "S" ;
  value elonewtr 1 = "E"
                 2 = "W" ;
  value elatnspl 1 = "N"
                 2 = "S" ;
  value elonewpl 1 = "E"
                 2 = "W" ;
  value epubh   1 = "No"
                 2 = "Yes" ;                 
  value elatnsph 1 = "N"
                 2 = "S" ;
  value elonewpubh 1 = "E"
                 2 = "W" ;
  value ehosp   1 = "No"
                 2 = "Yes" ;                    
  value ehosptyp 1 = "Private"
                 2 = "Public Sector" ;
  value elatnsho 1 = "N"
                 2 = "S" ;
  value elonewhosp 1 = "E"
                 2 = "W" ;
  value emedpub   1 = "No"
                 2 = "Yes" ;                 
  value elatnspub 1 = "N"
                 2 = "S" ;
  value elonewpub 1 = "E"
                 2 = "W" ;
  value emedpr   1 = "No"
                 2 = "Yes" ;                 
  value elatnspr 1 = "N"
                 2 = "S" ;
  value elonewpr 1 = "E"
                 2 = "W" ; 
  value   epolice   1 = "No"  /*chinthnaie added on March 05,2018*/
                 2 = "Yes" ;                                           
  value DFSCRNv  0 = "blank"
                 1 = "clean"
                 2 = "dirty"
                 3 = "error" ;

  format DFSTATUS DFSTATv. ;
  format ecostu   ecostu.  ;
  format estate   estate.  ;
  format eruralc  eruralc.   ;
  format elatnscc elatnscc.  ;
  format elongewcc elongewcc.  ;
  format ecomconb ecomconb.   ;
  format ecomcont ecomcont.   ;
  format eppark   eppark.   ;
  format elatnspp elatnspp.  ;
  format elonewpp elonewpp.  ;
  format eprsch   eprsch.   ;
  format elatnsps elatnsps.  ;
  format elonewps elonewps.  ;
  format esecsch  esecsch.   ;
  format elatnsss elatnsss.  ;
  format elonewss elonewss.  ;
  format euniv    euniv.   ;
  format elatnsun elatnsun.  ;
  format elonewun elonewun.  ;
  format epostoff epostoff.   ;
  format elatnspo elatnspo.  ;
  format elonewpo elonewpo.  ;
  format ebank    ebank.   ;
  format elatnsbk elatnsbk.  ;
  format elonewbk elonewbk.  ;
  format egovb    egovb.   ;
  format elatnsgv elatnsgv.  ;
  format elonewgv elonewgv.  ;
  format etrsta   etrsta.   ;
  format elatnstr elatnstr.  ;
  format elonewtr elonewtr.  ;
  format epolice  epolice.   ;
  format elatnspl elatnspl.  ;
  format elonewpl elonewpl.  ;
  format epubh    epubh.   ;
  format elatnsph elatnsph.  ;
  format elonewpubh elonewpubh.  ;
  format ehosp    ehosp.   ;
  format ehosptyp ehosptyp.  ;
  format elatnsho elatnsho.  ;
  format elonewhosp elonewhosp.  ;
  format emedpub  emedpub.   ;
  format elatnspub elatnspub.  ;
  format elonewpub elonewpub.  ;
  format emedpr   emedpr.   ;
  format elatnspr elatnspr.  ;
  format elonewpr elonewpr.  ;
  format DFSCREEN DFSCRNv. ;


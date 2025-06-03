proc format ;
  value DFSTATv  0 = "lost"
                 1 = "clean"
                 2 = "dirty"
                 3 = "error"
                 4 = "CLEAN"
                 5 = "DIRTY"
                 6 = "ERROR" ;
  value elatpdsns 1 = "N"
                 2 = "S" ;
  value elongpdsew 1 = "E"
                 2 = "W" ;
  value ecaptdif 0 = "Blank"
                 1 = "Checked" ;
  value eenaldif 0 = "Blank"
                 1 = "Checked" ;
  value eramidif 0 = "Blank"
                 1 = "Checked" ;
  value emetodif 0 = "Blank"
                 1 = "Checked" ;
  value eatendif 0 = "Blank"
                 1 = "Checked" ;
  value eamlodif 0 = "Blank"
                 1 = "Checked" ;
  value ehydrodif 0 = "Blank"
                 1 = "Checked" ;
  value efrusedif 0 = "Blank"
                 1 = "Checked" ;
  value esimvdif 0 = "Blank"
                 1 = "Checked" ;
  value eatorvdif 0 = "Blank"
                 1 = "Checked" ;
  value easpirdif 0 = "Blank"
                 1 = "Checked" ;
  value emetfdif 0 = "Blank"
                 1 = "Checked" ;
  value eglibdif 0 = "Blank"
                 1 = "Checked" ;
  value eglicdif 0 = "Blank"
                 1 = "Checked" ;
  value einsudif 0 = "Blank"
                 1 = "Checked" ;
  value eamoxdif 0 = "Blank"
                 1 = "Checked" ;
  value eisondif 0 = "Blank"
                 1 = "Checked" ;
  value eethadif 0 = "Blank"
                 1 = "Checked" ;
  value echlordif 0 = "Blank"
                 1 = "Checked" ;
  value evitcdif 0 = "Blank"
                 1 = "Checked" ;
  value eirondif 0 = "Blank"
                 1 = "Checked" ;
  value eparadif 0 = "Blank"
                 1 = "Checked" ;
  value DFSCRNv  0 = "blank"
                 1 = "clean"
                 2 = "dirty"
                 3 = "error" ;


  format DFSTATUS DFSTATv. ;
  format elatpdsns elatpdsns.  ;
  format elongpdsew elongpdsew.  ;
  format ecaptdif ecaptdif.  ;
  format eenaldif eenaldif.  ;
  format eramidif eramidif.  ;
  format emetodif emetodif.  ;
  format eatendif eatendif.  ;
  format eamlodif eamlodif.  ;
  format ehydrodif ehydrodif.  ;
  format efrusedif efrusedif.  ;
  format esimvdif esimvdif.  ;
  format eatorvdif eatorvdif.  ;
  format easpirdif easpirdif.  ;
  format emetfdif emetfdif.  ;
  format eglibdif eglibdif.  ;
  format eglicdif eglicdif.  ;
  format einsudif einsudif.  ;
  format eamoxdif eamoxdif.  ;
  format eisondif eisondif.  ;
  format eethadif eethadif.  ;
  format echlordif echlordif.  ;
  format evitcdif evitcdif.  ;
  format eirondif eirondif.  ;
  format eparadif eparadif.  ;
  format DFSCREEN DFSCRNv. ;

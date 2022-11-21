with SpielVariablen;

package body SchreibeGrenzen is
   
   procedure Städtegrenzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StädtegrenzeExtern : in StadtDatentypen.MaximaleStädteMitNullWert)
   is begin
      
      SpielVariablen.Grenzen (RasseExtern).Städtegrenze := StädtegrenzeExtern;
      
   end Städtegrenzen;
   
   
   
   procedure Einheitengrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitengrenzeExtern : in EinheitenDatentypen.MaximaleEinheiten)
   is begin
      
      SpielVariablen.Grenzen (RasseExtern).Einheitengrenze := EinheitengrenzeExtern;
      
   end Einheitengrenze;
   
   
   
   procedure Geldgrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldgrenzeExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      SpielVariablen.Grenzen (RasseExtern).Geldgrenze := GeldgrenzeExtern;
      
   end Geldgrenze;
   
   
   
   procedure Forschungsgrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungsgrenzeExtern : in ProduktionDatentypen.Lagermenge)
   is begin
      
      SpielVariablen.Grenzen (RasseExtern).Forschungsgrenze := ForschungsgrenzeExtern;
      
   end Forschungsgrenze;
   
   
   
   procedure Geldgewinngrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldgewinngrenzeExtern : in ProduktionDatentypen.Lagermenge)
   is begin
      
      SpielVariablen.Grenzen (RasseExtern).Geldgewinngrenze := GeldgewinngrenzeExtern;
      
   end Geldgewinngrenze;
   
   
   
   procedure Forschungsgewinngrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungsgewinngrenzeExtern : in ProduktionDatentypen.Lagermenge)
   is begin
      
      SpielVariablen.Grenzen (RasseExtern).ForschungGewinngrenze := ForschungsgewinngrenzeExtern;
      
   end Forschungsgewinngrenze;
   
   
   
   procedure Rassenrundengrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RassenrundengrenzeExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      SpielVariablen.Grenzen (RasseExtern).RassenRundengrenze := RassenrundengrenzeExtern;
      
   end Rassenrundengrenze;
   
   
   
   procedure GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EintragExtern : in SpielRecords.GrenzenRecord)
   is begin
      
      SpielVariablen.Grenzen (RasseExtern) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeGrenzen;

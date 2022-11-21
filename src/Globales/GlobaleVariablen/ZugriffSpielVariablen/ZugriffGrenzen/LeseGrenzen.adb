with SpielVariablen;

package body LeseGrenzen is

   function Städtegrenzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return SpielVariablen.Grenzen (RasseExtern).Städtegrenze;
      
   end Städtegrenzen;
   
   
   
   function Einheitengrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheiten
   is begin
      
      return SpielVariablen.Grenzen (RasseExtern).Einheitengrenze;
      
   end Einheitengrenze;
   
   
   
   function Geldgrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural
   is begin
      
      return SpielVariablen.Grenzen (RasseExtern).Geldgrenze;
      
   end Geldgrenze;
   
   
   
   function Forschungsgrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin
      
      return SpielVariablen.Grenzen (RasseExtern).Forschungsgrenze;
      
   end Forschungsgrenze;
   
   
   
   function Geldgewinngrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin
      
      return SpielVariablen.Grenzen (RasseExtern).Geldgewinngrenze;
      
   end Geldgewinngrenze;
   
   
   
   function Forschungsgewinngrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin
      
      return SpielVariablen.Grenzen (RasseExtern).ForschungGewinngrenze;
      
   end Forschungsgewinngrenze;
   
   
   
   function Rassenrundengrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural
   is begin
      
      return SpielVariablen.Grenzen (RasseExtern).RassenRundengrenze;
      
   end Rassenrundengrenze;
   
   
   
   function GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return SpielRecords.GrenzenRecord
   is begin
      
      return SpielVariablen.Grenzen (RasseExtern);
      
   end GanzerEintrag;

end LeseGrenzen;

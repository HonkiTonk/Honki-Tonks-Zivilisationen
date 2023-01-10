with SpielVariablen;

package body LeseGrenzen is

   function Städtegrenzen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return SpielVariablen.Grenzen (SpeziesExtern).Städtegrenze;
      
   end Städtegrenzen;
   
   
   
   function Einheitengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheiten
   is begin
      
      return SpielVariablen.Grenzen (SpeziesExtern).Einheitengrenze;
      
   end Einheitengrenze;
   
   
   
   function Geldgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural
   is begin
      
      return SpielVariablen.Grenzen (SpeziesExtern).Geldgrenze;
      
   end Geldgrenze;
   
   
   
   function Forschungsgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin
      
      return SpielVariablen.Grenzen (SpeziesExtern).Forschungsgrenze;
      
   end Forschungsgrenze;
   
   
   
   function Geldgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin
      
      return SpielVariablen.Grenzen (SpeziesExtern).Geldgewinngrenze;
      
   end Geldgewinngrenze;
   
   
   
   function Forschungsgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin
      
      return SpielVariablen.Grenzen (SpeziesExtern).ForschungGewinngrenze;
      
   end Forschungsgewinngrenze;
   
   
   
   function Speziesrundengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural
   is begin
      
      return SpielVariablen.Grenzen (SpeziesExtern).SpeziesRundengrenze;
      
   end Speziesrundengrenze;
   
   
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpielRecords.GrenzenRecord
   is begin
      
      return SpielVariablen.Grenzen (SpeziesExtern);
      
   end GanzerEintrag;

end LeseGrenzen;

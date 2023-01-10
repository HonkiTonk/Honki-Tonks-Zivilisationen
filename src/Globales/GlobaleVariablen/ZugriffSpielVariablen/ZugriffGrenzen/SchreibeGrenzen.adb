with SpielVariablen;

package body SchreibeGrenzen is
   
   procedure Städtegrenzen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StädtegrenzeExtern : in StadtDatentypen.MaximaleStädteMitNullWert)
   is begin
      
      SpielVariablen.Grenzen (SpeziesExtern).Städtegrenze := StädtegrenzeExtern;
      
   end Städtegrenzen;
   
   
   
   procedure Einheitengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EinheitengrenzeExtern : in EinheitenDatentypen.MaximaleEinheiten)
   is begin
      
      SpielVariablen.Grenzen (SpeziesExtern).Einheitengrenze := EinheitengrenzeExtern;
      
   end Einheitengrenze;
   
   
   
   procedure Geldgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GeldgrenzeExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      SpielVariablen.Grenzen (SpeziesExtern).Geldgrenze := GeldgrenzeExtern;
      
   end Geldgrenze;
   
   
   
   procedure Forschungsgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ForschungsgrenzeExtern : in ProduktionDatentypen.Lagermenge)
   is begin
      
      SpielVariablen.Grenzen (SpeziesExtern).Forschungsgrenze := ForschungsgrenzeExtern;
      
   end Forschungsgrenze;
   
   
   
   procedure Geldgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GeldgewinngrenzeExtern : in ProduktionDatentypen.Lagermenge)
   is begin
      
      SpielVariablen.Grenzen (SpeziesExtern).Geldgewinngrenze := GeldgewinngrenzeExtern;
      
   end Geldgewinngrenze;
   
   
   
   procedure Forschungsgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ForschungsgewinngrenzeExtern : in ProduktionDatentypen.Lagermenge)
   is begin
      
      SpielVariablen.Grenzen (SpeziesExtern).ForschungGewinngrenze := ForschungsgewinngrenzeExtern;
      
   end Forschungsgewinngrenze;
   
   
   
   procedure Speziesrundengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesrundengrenzeExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      SpielVariablen.Grenzen (SpeziesExtern).SpeziesRundengrenze := SpeziesrundengrenzeExtern;
      
   end Speziesrundengrenze;
   
   
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EintragExtern : in SpielRecords.GrenzenRecord)
   is begin
      
      SpielVariablen.Grenzen (SpeziesExtern) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeGrenzen;

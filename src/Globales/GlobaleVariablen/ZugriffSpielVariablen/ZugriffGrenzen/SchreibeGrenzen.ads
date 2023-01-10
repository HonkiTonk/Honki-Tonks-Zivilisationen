with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with ZahlenDatentypen;
with ProduktionDatentypen;
with SpielRecords;

package SchreibeGrenzen is
   pragma Elaborate_Body;

   procedure Städtegrenzen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StädtegrenzeExtern : in StadtDatentypen.MaximaleStädteMitNullWert);
   
   procedure Einheitengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EinheitengrenzeExtern : in EinheitenDatentypen.MaximaleEinheiten);
   
   procedure Geldgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GeldgrenzeExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure Forschungsgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ForschungsgrenzeExtern : in ProduktionDatentypen.Lagermenge);
   
   procedure Geldgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GeldgewinngrenzeExtern : in ProduktionDatentypen.Lagermenge);
   
   procedure Forschungsgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ForschungsgewinngrenzeExtern : in ProduktionDatentypen.Lagermenge);
   
   procedure Speziesrundengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesrundengrenzeExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EintragExtern : in SpielRecords.GrenzenRecord);

end SchreibeGrenzen;

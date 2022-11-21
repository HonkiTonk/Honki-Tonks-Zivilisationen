with RassenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with ZahlenDatentypen;
with ProduktionDatentypen;
with SpielRecords;

package SchreibeGrenzen is
   pragma Elaborate_Body;

   procedure Städtegrenzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StädtegrenzeExtern : in StadtDatentypen.MaximaleStädteMitNullWert);
   
   procedure Einheitengrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitengrenzeExtern : in EinheitenDatentypen.MaximaleEinheiten);
   
   procedure Geldgrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldgrenzeExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure Forschungsgrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungsgrenzeExtern : in ProduktionDatentypen.Lagermenge);
   
   procedure Geldgewinngrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldgewinngrenzeExtern : in ProduktionDatentypen.Lagermenge);
   
   procedure Forschungsgewinngrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungsgewinngrenzeExtern : in ProduktionDatentypen.Lagermenge);
   
   procedure Rassenrundengrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RassenrundengrenzeExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EintragExtern : in SpielRecords.GrenzenRecord);

end SchreibeGrenzen;

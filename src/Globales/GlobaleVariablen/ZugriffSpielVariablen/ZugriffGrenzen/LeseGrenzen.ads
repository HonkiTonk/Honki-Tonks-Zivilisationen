with RassenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with ZahlenDatentypen;
with ProduktionDatentypen;
with SpielRecords;

package LeseGrenzen is
   pragma Elaborate_Body;

   function Städtegrenzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert;

   function Einheitengrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheiten;

   function Geldgrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural;

   function Forschungsgrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge;

   function Geldgewinngrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge;

   function Forschungsgewinngrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge;

   function Rassenrundengrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural;

   function GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return SpielRecords.GrenzenRecord;

end LeseGrenzen;

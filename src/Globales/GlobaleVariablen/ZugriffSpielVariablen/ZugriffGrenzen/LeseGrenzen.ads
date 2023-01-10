with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with ZahlenDatentypen;
with ProduktionDatentypen;
with SpielRecords;

package LeseGrenzen is
   pragma Elaborate_Body;

   function Städtegrenzen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert;

   function Einheitengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheiten;

   function Geldgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural;

   function Forschungsgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge;

   function Geldgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge;

   function Forschungsgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge;

   function Speziesrundengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural;

   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpielRecords.GrenzenRecord;

end LeseGrenzen;

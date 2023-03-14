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
   pragma Inline (Städtegrenzen);

   function Einheitengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheiten;
   pragma Inline (Einheitengrenze);

   function Geldgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural;
   pragma Inline (Geldgrenze);

   function Forschungsgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge;
   pragma Inline (Forschungsgrenze);

   function Geldgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge;
   pragma Inline (Geldgewinngrenze);

   function Forschungsgewinngrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge;
   pragma Inline (Forschungsgewinngrenze);

   function Speziesrundengrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural;
   pragma Inline (Speziesrundengrenze);

   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpielRecords.GrenzenRecord;
   pragma Inline (GanzerEintrag);

end LeseGrenzen;

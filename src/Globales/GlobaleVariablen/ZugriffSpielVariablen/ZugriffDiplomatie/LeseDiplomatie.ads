with SpeziesDatentypen;
with DiplomatieDatentypen;
with SpielRecords;
with ZahlenDatentypen;

with LeseSpeziesbelegung;

package LeseDiplomatie is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type SpeziesDatentypen.Spezies_Enum;

   function AktuellerZustand
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return DiplomatieDatentypen.Status_Untereinander_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   pragma Inline (AktuellerZustand);
   
   function AktuelleSympathie
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return DiplomatieDatentypen.Meinung
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   pragma Inline (AktuelleSympathie);
   
   function ZeitSeitÄnderung
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   pragma Inline (ZeitSeitÄnderung);
   
   function GanzerEintrag
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpielRecords.DiplomatieRecord
     with
       Pre => (
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   pragma Inline (GanzerEintrag);

end LeseDiplomatie;

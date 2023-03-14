with SpeziesDatentypen;
with DiplomatieDatentypen;
with ZahlenDatentypen;
with SpielRecords;

private with Grenzpruefungen;

with LeseSpeziesbelegung;

package SchreibeDiplomatie is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type SpeziesDatentypen.Spezies_Enum;

   procedure AktuellerZustand
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ZustandExtern : in DiplomatieDatentypen.Status_Untereinander_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   pragma Inline (AktuellerZustand);
   
   procedure AktuelleSympathie
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SympathieExtern : in DiplomatieDatentypen.Meinung;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   
   procedure ZeitSeitÄnderung
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ÄnderungExtern : in ZahlenDatentypen.EigenesNatural;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   
   procedure Standardeinstellungen;
   pragma Inline (Standardeinstellungen);
   
   procedure GanzerEintrag
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EintragExtern : in SpielRecords.DiplomatieRecord)
     with
       Pre => (
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   pragma Inline (GanzerEintrag);
   
private
   
   function EigeneZahlPrüfen is new Grenzpruefungen.Standardprüfung (GanzeZahl => ZahlenDatentypen.EigenesNatural);
   
   function MeinungPrüfen is new Grenzpruefungen.Standardprüfung (GanzeZahl => DiplomatieDatentypen.Meinung);

end SchreibeDiplomatie;

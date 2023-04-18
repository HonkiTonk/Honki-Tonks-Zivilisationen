with SpeziesDatentypen;

private with RueckgabeDatentypen;
private with SpielDatentypen;
private with DiplomatieDatentypen;

with LeseSpeziesbelegung;

package DiplomatieLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure DiplomatieMöglich
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure DiplomatieRundenende
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private

   KontaktierteSpezies : SpeziesDatentypen.Spezies_Verwendet_Enum;

   AktionAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   Auswahl : Natural;

   -- Diese ganzen Schwierigkeitskonstanen mal in einger Datei zusammenfassen? äöü
   type SchwierigkeitsgradArray is array (SpielDatentypen.Schwierigkeitsgrad_Enum'Range) of DiplomatieDatentypen.MeinungPositive;
   SchwierigkeitsgradMeinungsverbesserung : constant SchwierigkeitsgradArray := (
                                                                                 SpielDatentypen.Schwierigkeitsgrad_Leicht_Enum => 4,
                                                                                 SpielDatentypen.Schwierigkeitsgrad_Mittel_Enum => 2,
                                                                                 SpielDatentypen.Schwierigkeitsgrad_Schwer_Enum => 1
                                                                                );

   procedure Speziesprüfungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure Diplomatie
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end DiplomatieLogik;

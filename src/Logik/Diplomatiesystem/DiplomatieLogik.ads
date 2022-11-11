with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with RueckgabeDatentypen;

package DiplomatieLogik is
   pragma Elaborate_Body;

   procedure DiplomatieMöglich
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   KontaktierteRasse : RassenDatentypen.Rassen_Verwendet_Enum;

   AktionAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   Auswahl : Natural;

   procedure Rassenprüfungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end DiplomatieLogik;

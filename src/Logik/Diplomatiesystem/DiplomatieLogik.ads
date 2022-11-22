with RassenDatentypen;

private with RueckgabeDatentypen;

with LeseRassenbelegung;

package DiplomatieLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure DiplomatieMöglich
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   KontaktierteRasse : RassenDatentypen.Rassen_Verwendet_Enum;

   AktionAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   Auswahl : Natural;

   procedure Rassenprüfungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end DiplomatieLogik;

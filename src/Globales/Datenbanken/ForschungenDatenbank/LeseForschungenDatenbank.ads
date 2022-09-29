pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with TastenbelegungDatentypen;
with AufgabenDatentypen;
with SystemDatentypen;

package LeseForschungenDatenbank is

   function Kosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungID)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function AnforderungForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungID;
      WelcheAnforderungExtern : in ForschungenDatentypen.Forschung_Anforderung_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function Verbesserungen
     (VerbesserungExtern : in TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function Wege
     (WegExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function Umgebung
     (AnfangEndeExtern : in SystemDatentypen.Anfang_Ende_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end LeseForschungenDatenbank;

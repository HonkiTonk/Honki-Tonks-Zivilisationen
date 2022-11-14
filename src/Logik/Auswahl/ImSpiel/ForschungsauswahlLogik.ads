with RassenDatentypen;
with SpielVariablen;

private with ForschungenDatentypen;
private with ForschungKonstanten;

package ForschungsauswahlLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Forschungserfolg
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure Anfangsauswahl
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   AktuelleAuswahl : ForschungenDatentypen.ForschungIDMitNullWert := ForschungKonstanten.LeerForschungsanforderung;
   WasErforschtWerdenSoll : ForschungenDatentypen.ForschungIDMitNullWert;
   AktuellesForschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;
   GewählteForschung : ForschungenDatentypen.ForschungIDMitNullWert;

   Auswahl : Positive;

   function Forschungsmöglichkeiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   function Forschungsauswahl
     return ForschungenDatentypen.ForschungIDMitNullWert;

end ForschungsauswahlLogik;

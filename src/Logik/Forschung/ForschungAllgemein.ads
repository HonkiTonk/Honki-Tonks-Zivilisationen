pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with ForschungenDatentypen;
with GlobaleVariablen;
with SonstigeVariablen;
with ForschungKonstanten;

package ForschungAllgemein is

   AktuelleAuswahl : ForschungenDatentypen.ForschungIDMitNullWert := ForschungKonstanten.LeerForschungAnforderung;

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure ForschungFortschritt;



   function ForschungAnforderungErfüllt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in ForschungenDatentypen.ForschungID)
      return Boolean
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

   function Beschreibung
     (IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

private

   WasErforschtWerdenSoll : ForschungenDatentypen.ForschungIDMitNullWert;
   AktuellesForschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;
   GewählteForschung : ForschungenDatentypen.ForschungIDMitNullWert;

   AktuelleForschung : Positive;

   BeschreibungText : Unbounded_Wide_Wide_String;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   procedure FortschrittMensch
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum);

   procedure FortschrittKI
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.KI_Spieler_Enum);



   function MausAuswahl
      return ForschungenDatentypen.ForschungIDMitNullWert;

   function AuswahlForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum);

   function ForschungAuswahlSFML
     return ForschungenDatentypen.ForschungIDMitNullWert;

end ForschungAllgemein;

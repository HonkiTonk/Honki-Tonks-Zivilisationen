pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with RassenDatentypen; use RassenDatentypen;
with GlobaleVariablen;
with SonstigeVariablen;
with ForschungKonstanten;

package ForschungAllgemein is

   AktuelleAuswahl : EinheitStadtDatentypen.ForschungIDMitNullWert := ForschungKonstanten.LeerForschungAnforderung;
   NeuerAufruf : Boolean := False;

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure ForschungFortschritt;



   function ForschungAnforderungErfüllt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in EinheitStadtDatentypen.ForschungID)
      return Boolean
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

   function Beschreibung
     (IDExtern : in EinheitStadtDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

private

   WasErforschtWerdenSoll : EinheitStadtDatentypen.ForschungIDMitNullWert;
   AktuellesForschungsprojekt : EinheitStadtDatentypen.ForschungIDMitNullWert;
   GewählteForschung : EinheitStadtDatentypen.ForschungIDMitNullWert;

   AktuelleForschung : Positive;

   BeschreibungText : Unbounded_Wide_Wide_String;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   procedure FortschrittMensch
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);

   procedure FortschrittKI
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_KI_Enum);



   function MausAuswahl
      return EinheitStadtDatentypen.ForschungIDMitNullWert;

   function AuswahlForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);

   function ForschungAuswahlSFML
     return EinheitStadtDatentypen.ForschungIDMitNullWert;

end ForschungAllgemein;

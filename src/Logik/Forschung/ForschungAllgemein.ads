pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Text;

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleVariablen;
with SystemKonstanten;

package ForschungAllgemein is

   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;
   Ende : EinheitStadtDatentypen.MinimimMaximumID;

   type AllgemeineAnzeigeTextRecord is record

      Text : Unbounded_Wide_Wide_String;
      Nummer : Natural;

   end record;

   type ForschungTextArray is array (EinheitStadtDatentypen.ForschungID'First .. EinheitStadtDatentypen.ForschungID'Last + 1) of AllgemeineAnzeigeTextRecord;
   ForschungText : ForschungTextArray;

   function Beschreibung
     (IDExtern : in EinheitStadtDatentypen.ForschungIDMitNullWert;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String;

   procedure Forschung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

   procedure ForschungFortschritt;



   function ForschungAnforderungErfüllt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in EinheitStadtDatentypen.ForschungID)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

private

   WasErforschtWerdenSoll : EinheitStadtDatentypen.ForschungIDMitNullWert;
   AktuellesForschungsprojekt : EinheitStadtDatentypen.ForschungIDMitNullWert;
   GewählteForschung : EinheitStadtDatentypen.ForschungIDMitNullWert;

   AktuelleForschung : Positive;
   WelcherForschungstext : Positive;

   Zeilenabstand : Float;

   BeschreibungText : Unbounded_Wide_Wide_String;

   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   StartPositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   TextPositionMaus : Sf.System.Vector2.sfVector2f;

   procedure FortschrittMensch
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure FortschrittKI
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure MausAuswahl;



   function AuswahlForschungNeu
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

   function ForschungAuswahlKonsole
     return EinheitStadtDatentypen.ForschungIDMitNullWert;

   function ForschungAuswahlSFML
     return EinheitStadtDatentypen.ForschungIDMitNullWert;

end ForschungAllgemein;

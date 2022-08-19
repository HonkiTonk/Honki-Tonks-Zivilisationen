pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;
private with Sf.Graphics.Rect;
private with Sf.Graphics.Color;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with ForschungenDatentypen;
private with ViewsSFML;

package ForschungAnzeigeSFML is

   procedure ForschungAnzeige
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AktuelleAuswahlExtern : in Natural)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   AktuelleAuswahl : ForschungenDatentypen.ForschungIDMitNullWert;
   AktuellesForschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;
   
   Forschungswert : ForschungenDatentypen.ForschungIDNichtMöglich;
      
   AktuelleTextbreite : Float;
      
   Text : Unbounded_Wide_Wide_String;
   
   TextPosition : Sf.System.Vector2.sfVector2f;
   
   Farbe : Sf.Graphics.Color.sfColor;
   
   type ViewflächenArray is array (ViewsSFML.ForschungsviewAccesse'Range) of Sf.System.Vector2.sfVector2f;
   Viewfläche : ViewflächenArray := (others => (5.00, 5.00));
   
   type AnzeigebereichArray is array (ViewflächenArray'Range) of Sf.Graphics.Rect.sfFloatRect;
   Anzeigebereich : constant AnzeigebereichArray := (
                                                     1 => (0.00, 0.10, 0.50, 0.80),
                                                     2 => (0.50, 0.10, 0.50, 0.40),
                                                     3 => (0.50, 0.50, 0.50, 0.40),
                                                     4 => (0.00, 0.90, 1.00, 0.10)
                                                    );
   
   procedure Auswahlmöglichkeiten
     (AuswahlExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      ViewnummerExtern : in Positive);
   
   procedure Beschreibung
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure Ermöglicht
     (ZusatztextExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ViewnummerExtern : in Positive)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum  
              );
   
   procedure Aktuell
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ViewnummerExtern : in Positive)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum  
              );
   
end ForschungAnzeigeSFML;

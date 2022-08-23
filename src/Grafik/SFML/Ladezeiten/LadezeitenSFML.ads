pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with RassenDatentypen;
with GrafikDatentypen;

private with LadezeitenDatentypen;
private with GrafikRecordKonstanten;

private with UmwandlungenAdaNachEigenes;

package LadezeitenSFML is
   
   -- Hier später passenden Contract einfügen. äöü
   procedure LadezeitenSFML
     (WelcheLadeanzeigeExtern : in GrafikDatentypen.Ladezeiten_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum);

private
   
   WelcheZeit : Positive;
   Überschrift : Positive;
   
   Textbreite : Float;
   
   Text : Unbounded_Wide_Wide_String;
         
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   
   
   function SpielweltErstellen
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  SpielweltErstellen'Result.x >= 0.00
                and
                  SpielweltErstellen'Result.y >= 0.00
               );
   
   function Rundenende
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Rundenende'Result.x >= 0.00
                and
                  Rundenende'Result.y >= 0.00
               );
   
   function SpeichernLaden
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  SpeichernLaden'Result.x >= 0.00
                and
                  SpeichernLaden'Result.y >= 0.00
               );
   
   function KIRechnet
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  KIRechnet'Result.x >= 0.00
                and
                  KIRechnet'Result.y >= 0.00
               );
   
   function ZahlAlsStringLadefortschritt is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => LadezeitenDatentypen.Ladefortschritt);

end LadezeitenSFML;

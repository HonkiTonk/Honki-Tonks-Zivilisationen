with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with GrafikDatentypen;
with SpeziesKonstanten;

private with GrafikRecordKonstanten;
private with SystemDatentypen;

with LeseSpeziesbelegung;

private with UmwandlungenAdaNachEigenes;

package LadezeitenGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type SpeziesDatentypen.Spezies_Enum;
   
   procedure Ladezeiten
     (WelcheLadeanzeigeExtern : in GrafikDatentypen.Ladezeiten_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
     with
       Pre => (
                 if SpeziesExtern /= SpeziesKonstanten.LeerSpezies then LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private
   
   WelcheZeit : Positive;
   Überschrift : Positive;
   
   Textbreite : Float;
   
   MaximalerLadefortschritt : constant Wide_Wide_String (1 .. 3) := "100";
   
   Text : Unbounded_Wide_Wide_String;
         
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   
   
   function SpielweltErstellen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),
         
       Post => (
                  SpielweltErstellen'Result.x >= 0.00
                and
                  SpielweltErstellen'Result.y >= 0.00
               );
   
   function Rundenende
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),
           
       Post => (
                  Rundenende'Result.x >= 0.00
                and
                  Rundenende'Result.y >= 0.00
               );
   
   function SpeichernLaden
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),
           
       Post => (
                  SpeichernLaden'Result.x >= 0.00
                and
                  SpeichernLaden'Result.y >= 0.00
               );
   
   function KIRechnet
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),
           
       Post => (
                  KIRechnet'Result.x >= 0.00
                and
                  KIRechnet'Result.y >= 0.00
               );
   
   function ZahlAlsStringLadefortschritt is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => SystemDatentypen.NullBisHundert);

end LadezeitenGrafik;

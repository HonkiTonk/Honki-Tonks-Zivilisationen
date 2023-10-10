with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with GrafikDatentypen;
with SpeziesKonstanten;

private with GrafikRecordKonstanten;
private with SystemDatentypen;

with LeseSpeziesbelegung;

private with UmwandlungenAdaEigenes;

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
   
   MaximalerLadefortschritt : constant Wide_Wide_String (1 .. 3) := "100";
   
   Text : Unbounded_Wide_Wide_String;
         
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   
   
   function SpielweltErstellen
     (MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 MaximaleTextbreiteExtern >= 0.00
              ),
           
       Post => (
                  SpielweltErstellen'Result >= 0.00
               );
   
   function Rundenende
     (MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 MaximaleTextbreiteExtern >= 0.00
              ),
           
       Post => (
                  Rundenende'Result >= 0.00
               );
   
   function SpeichernLaden
     (MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 MaximaleTextbreiteExtern >= 0.00
              ),
           
       Post => (
                  SpeichernLaden'Result >= 0.00
               );
   
   function KIRechnet
     (MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 MaximaleTextbreiteExtern >= 0.00
              ),
           
       Post => (
                  KIRechnet'Result >= 0.00
               );
   
   function ZahlAlsString is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => SystemDatentypen.NullBisHundert);

end LadezeitenGrafik;

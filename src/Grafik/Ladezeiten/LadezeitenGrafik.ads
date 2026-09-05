private with Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

private with UmwandlungssystemHTSEB;

with SpeziesDatentypen;
with GrafikDatentypen;
with SpeziesKonstanten;

private with GrafikRecordKonstanten;

with LeseSpeziesbelegung;

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
   use Ada.Strings.Wide_Wide_Unbounded;
   
   WelcheZeit : Positive;
   
   Text : Unbounded_Wide_Wide_String;
         
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   
   
   function Kartengenerator
     (MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 MaximaleTextbreiteExtern >= 0.00
              ),
           
       Post => (
                  Kartengenerator'Result >= 0.00
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
   
   function Spielstand
     (MaximaleTextbreiteExtern : in Float;
      SpielstandExtern : in GrafikDatentypen.Spielstand_Enum)
      return Float
     with
       Pre => (
                 MaximaleTextbreiteExtern >= 0.00
              ),
           
       Post => (
                  Spielstand'Result >= 0.00
               );
   
   function KI
     (MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 MaximaleTextbreiteExtern >= 0.00
              ),
           
       Post => (
                  KI'Result >= 0.00
               );
   
   function MaximalerLadefortschritt
     return Wide_Wide_String
     with
       Post => (
                  MaximalerLadefortschritt'Result'Length = 6
               );
   
   function ZahlAlsString is new UmwandlungssystemHTSEB.Kommazahlenstring (Kommazahl => Float);

end LadezeitenGrafik;

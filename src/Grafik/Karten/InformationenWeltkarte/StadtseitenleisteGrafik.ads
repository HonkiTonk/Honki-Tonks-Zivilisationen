with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;
with Sf.Graphics.Rect;
with Sf.System.Vector2;

with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with GrafikRecordKonstanten;
private with ProduktionDatentypen;
private with TextaccessVariablen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with UmwandlungenAdaNachEigenes;

package StadtseitenleisteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type Sf.Graphics.sfView_Ptr;
   
   procedure Stadtinformationen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
              );
   
   function Leer
     (AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect;
      ViewExtern : in Sf.Graphics.sfView_Ptr;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewExtern /= null
               and
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),
         
       Post => (
                  Leer'Result.x >= 0.00
                and
                  Leer'Result.y >= 0.00
               );
     
   procedure Stadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect;
      ViewExtern : in Sf.Graphics.sfView_Ptr)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 ViewExtern /= null
              );
   
private
   
   VolleInformation : Boolean;
   MausInformationen : Boolean;
   
   Nahrungsproduktion : ProduktionDatentypen.Stadtproduktion;
   
   Bauzeit : ProduktionDatentypen.Produktion;
   
   Textbreite : Float;
   Textskalierung : Float;
         
   Text : Unbounded_Wide_Wide_String;
   
   Bauprojekt : StadtRecords.BauprojektRecord;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Zwischenfläche : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;
   Mausposition : Sf.System.Vector2.sfVector2f;
      
   type FestzulegenderTextArray is array (TextaccessVariablen.StadtInformationenAccess'Range) of Unbounded_Wide_Wide_String;
   FestzulegenderText : FestzulegenderTextArray;
   
   procedure Stadtname
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function Nahrung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Nahrung'Result)'Length > 0 
               );
   
   function Kampfwerte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Kampfwerte'Result)'Length > 0 
               );

   function AktuellesBauprojekt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function ZahlAlsStringProduktion is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.Produktion);

end StadtseitenleisteGrafik;

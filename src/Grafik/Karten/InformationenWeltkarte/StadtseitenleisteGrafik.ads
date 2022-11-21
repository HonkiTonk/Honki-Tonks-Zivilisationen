with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;
with Sf.Graphics.Rect;

private with Sf.System.Vector2;

with RassenDatentypen;
with SpielVariablen;
with StadtRecords;

private with GrafikRecordKonstanten;
private with ProduktionDatentypen;
private with TextaccessVariablen;

with LeseGrenzen;

private with UmwandlungenAdaNachEigenes;

package StadtseitenleisteGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type Sf.Graphics.sfView_Ptr;
   
   procedure Stadtinformationen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
              );
   
   procedure Leer
     (AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect;
      ViewExtern : in Sf.Graphics.sfView_Ptr)
     with
       Pre => (
                 ViewExtern /= null
              );
     
   procedure Stadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect;
      ViewExtern : in Sf.Graphics.sfView_Ptr)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
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
   Textposition : Sf.System.Vector2.sfVector2f;
   Mausposition : Sf.System.Vector2.sfVector2f;
      
   type FestzulegenderTextArray is array (TextaccessVariablen.StadtInformationenAccess'Range) of Unbounded_Wide_Wide_String;
   FestzulegenderText : FestzulegenderTextArray;
   
   procedure Stadtname
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function Nahrung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Nahrung'Result)'Length > 0 
               );
   
   function Kampfwerte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Kampfwerte'Result)'Length > 0 
               );

   function AktuellesBauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function ZahlAlsStringProduktion is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.Produktion);

end StadtseitenleisteGrafik;

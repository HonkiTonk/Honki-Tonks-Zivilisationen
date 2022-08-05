pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with StadtRecords;

private with ProduktionDatentypen;
private with TextaccessVariablen;

private with UmwandlungenAdaNachEigenes;

package StadtInformationenSFML is
   
   procedure Stadtinformationen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
              );
   
   
     
   function Stadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AnzeigeAnfangenExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
              ),
   
       Post => (
                  Stadt'Result.y > 0.00
                and
                  Stadt'Result.x > 0.00
               );
   
private
   
   VolleInformation : Boolean;
   MausInformationen : Boolean;
   
   Stadtart : Positive;
   
   TextbreiteAktuell : Float;
   TextbreiteNeu : Float;
      
   Text : Unbounded_Wide_Wide_String;
   
   Bauprojekt : StadtRecords.BauprojektRecord;
   
   StartpunktText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   Viewfläche : Sf.System.Vector2.sfVector2f := StartpunktText;
   Textposition : Sf.System.Vector2.sfVector2f;
   TextpositionStadt : Sf.System.Vector2.sfVector2f;
   
   type FestzulegenderTextArray is array (TextaccessVariablen.StadtInformationenAccessArray'Range) of Unbounded_Wide_Wide_String;
   FestzulegenderText : FestzulegenderTextArray;
   
   procedure Debuginformationen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   

   function AktuellesBauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function ZahlAlsStringGesamtproduktionStadt is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.Stadtproduktion);

end StadtInformationenSFML;

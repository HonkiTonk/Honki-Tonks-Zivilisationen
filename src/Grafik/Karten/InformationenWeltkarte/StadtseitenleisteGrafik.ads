with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;
with Sf.System.Vector3;

with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;
with StadtGrafikRecords;

private with ProduktionDatentypen;
private with TextaccessVariablen;
private with TextArrays;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with UmwandlungenAdaEigenes;

package StadtseitenleisteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   procedure Stadtinformationen
     (StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtauswahlExtern.SpeziesNummer.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies)
              );
   
   
   
   function Stadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord;
      TextpositionsinformationenExtern : in Sf.System.Vector3.sfVector3f)
      return Sf.System.Vector3.sfVector3f
     with
       Pre => (
               --       LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               --     and
               --        LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               --      and
               --       StadtauswahlExtern.SpeziesNummer.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies)
                 TextpositionsinformationenExtern.x > 0.00
               and
                 TextpositionsinformationenExtern.y > 0.00
               and
                 TextpositionsinformationenExtern.z >= 0.00
              ),
         
       Post => (
                  Stadt'Result.x > 0.00
                and
                  Stadt'Result.y > 0.00
                and
                  Stadt'Result.z >= 0.00
               );
   
private
   
   VolleInformation : Boolean;
   MausInformationen : Boolean;
   
   Informationsgrenze : constant Positive := 2;
   
   Textbreite : Float;
   Textskalierung : Float;
         
   Text : Unbounded_Wide_Wide_String;
   
   Zwischenfläche : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;
   Mausposition : Sf.System.Vector2.sfVector2f;
      
   FestzulegenderText : TextArrays.AllgemeinesTextArray (TextaccessVariablen.StadtInformationenAccess'Range);
   
   procedure TextZeichnen;
   
   
   
   function Nahrung
     (ProduktionExtern : in ProduktionDatentypen.Stadtproduktion;
      VorhandenExtern : in ProduktionDatentypen.Stadtproduktion)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => Nahrung'Result)'Length > 0 
               );
   
   function Kampfwerte
     (StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtauswahlExtern.SpeziesNummer.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies)
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Kampfwerte'Result)'Length > 0 
               );

   function AktuellesBauprojekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      BauprojektExtern : in StadtRecords.BauprojektRecord;
      BauzeitExtern : in ProduktionDatentypen.Produktion)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function ZahlAlsString is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => ProduktionDatentypen.Produktion);

end StadtseitenleisteGrafik;

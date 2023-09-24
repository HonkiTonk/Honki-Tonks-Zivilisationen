with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;
with StadtGrafikRecords;
with GrafikRecords;

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
      TextpositionsinformationenExtern : in GrafikRecords.TextpositionLeerzeilenRecord;
      MaximaleTextbreiteExtern : in Float)
      return GrafikRecords.TextpositionLeerzeilenRecord
     with
       Pre => (
               --       LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               --     and
               --        LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               --      and
               --       StadtauswahlExtern.SpeziesNummer.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies)
                 TextpositionsinformationenExtern.Textpositionsinformationen.x > 0.00
               and
                 TextpositionsinformationenExtern.Textpositionsinformationen.y > 0.00
               and
                 TextpositionsinformationenExtern.Textpositionsinformationen.z > 0.00
              ),
         
       Post => (
                  Stadt'Result.Textpositionsinformationen.x > 0.00
                and
                  Stadt'Result.Textpositionsinformationen.y > 0.00
                and
                  Stadt'Result.Textpositionsinformationen.z > 0.00
               );
   
private
      
   Leerzeilen : Natural;
   
   Textbreite : Float;
         
   Zwischenspeicher : Unbounded_Wide_Wide_String;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   Skalierung : Sf.System.Vector2.sfVector2f;
      
   AnzuzeigenderText : TextArrays.AllgemeinesTextArray (TextaccessVariablen.StadtInformationenAccess'Range);
   
   
   
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

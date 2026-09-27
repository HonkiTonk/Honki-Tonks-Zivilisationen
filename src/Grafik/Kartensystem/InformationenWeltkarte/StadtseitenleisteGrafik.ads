private with Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

private with ArraysHTSEB;

with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;
with StadtGrafikRecords;

private with ProduktionDatentypen;
private with TextaccessVariablen;
private with GrafikRecordKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with UmwandlungssystemHTSEB;

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
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
               --       LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               --     and
               --        LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               --      and
               --       StadtauswahlExtern.SpeziesNummer.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies)
                 TextpositionExtern.x > 0.00
               and
                 TextpositionExtern.y > 0.00
              ),
         
       Post => (
                  Stadt'Result > 0.00
               );
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Leerzeilen : Natural;
         
   Zwischenspeicher : Unbounded_Wide_Wide_String;
      
   YTextposition : Float;
   YTextpositionZwei : Float;
      
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   
   AnzuzeigenderText : ArraysHTSEB.AllgemeinesTextArray (TextaccessVariablen.StadtInformationenAccess'Range);
   
   
   
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BauprojektExtern : in StadtRecords.BauprojektRecord;
      BauzeitExtern : in ProduktionDatentypen.Produktion)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Stadtanzeige
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtauswahlExtern.SpeziesNummer.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies)
               and
                 TextpositionExtern.x > 0.00
               and
                 TextpositionExtern.y > 0.00
              ),
         
       Post => (
                  Stadtanzeige'Result > 0.00
               );
   
   
   
   function ZahlAlsString is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => ProduktionDatentypen.Produktion);

end StadtseitenleisteGrafik;

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

with SpeziesDatentypen;
with KartenDatentypen;
with KartenRecords;
with GrafikRecords;

private with TextaccessVariablen;
private with ProduktionDatentypen;
private with ForschungenDatentypen;
private with ZahlenDatentypen;
private with TextArrays;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

private with UmwandlungenAdaEigenes;

package WichtigesSeitenleisteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function WichtigesInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      LeerzeilenExtern : in Natural;
      MaximaleTextbreiteExtern : in Float)
      return GrafikRecords.YTextpositionLeerzeilenRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 TextpositionExtern.x > 0.00
               and
                 TextpositionExtern.y > 0.00
              ),
         
       Post => (
                  WichtigesInformationen'Result.YPosition > 0.00
               );
   
private
   
   Forschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;
   
   Forschungszeit : ProduktionDatentypen.Lagermenge;
   
   Geldzuwachs : ProduktionDatentypen.Produktion;
   
   AktuelleRundenanzahl : ZahlenDatentypen.EigenesPositive;
   
   Rundengrenze : ZahlenDatentypen.EigenesNatural;
   
   Leerzeilen : Natural;
      
   YTextposition : Float;
   
   AnzuzeigenderText : TextArrays.AllgemeinesTextArray (TextaccessVariablen.KarteWichtigesAccess'Range);
   
   
         
   function Koordinaten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function Rundenanzahl
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Rundenanzahl'Result)'Length > 0 
               );
   
   function Geld
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   function Forschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   function ZahlAlsStringKostenLager is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => ProduktionDatentypen.Produktion);
   
   function ZahlAlsStringEbeneVorhanden is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => KartenDatentypen.EbeneVorhanden);
   
   function ZahlAlsStringPositive is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => Natural);

end WichtigesSeitenleisteGrafik;

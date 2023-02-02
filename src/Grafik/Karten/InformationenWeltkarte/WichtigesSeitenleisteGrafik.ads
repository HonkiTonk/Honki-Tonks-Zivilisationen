with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with KartenDatentypen;
with KartenRecords;

private with TextaccessVariablen;
private with ProduktionDatentypen;
private with GrafikRecordKonstanten;
private with ForschungenDatentypen;
private with ZahlenDatentypen;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

private with UmwandlungenAdaNachEigenes;

package WichtigesSeitenleisteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   procedure WichtigesInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
private
   
   Geldzuwachs : ProduktionDatentypen.Produktion;
   Forschungszeit : ProduktionDatentypen.Lagermenge;
   
   Forschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;
   
   AktuelleRundenanzahl : ZahlenDatentypen.EigenesPositive;
   
   Rundengrenze : ZahlenDatentypen.EigenesNatural;
   
   Textbreite : Float;
      
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type FestzulegenderTextArray is array (TextaccessVariablen.KarteWichtigesAccess'Range) of Unbounded_Wide_Wide_String;
   FestzulegenderText : FestzulegenderTextArray;

   
   
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
   
   function ZahlAlsStringKostenLager is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.Produktion);
   
   function ZahlAlsStringEbeneVorhanden is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.EbeneVorhanden);
   
   function ZahlAlsStringPositive is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Natural);

end WichtigesSeitenleisteGrafik;

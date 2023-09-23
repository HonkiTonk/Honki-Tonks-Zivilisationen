with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector3;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with KartenDatentypen;
with KartenRecords;

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
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Sf.System.Vector3.sfVector3f
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),
         
       Post => (
                  WichtigesInformationen'Result.x > 0.00
                and
                  WichtigesInformationen'Result.y > 0.00
                and
                  WichtigesInformationen'Result.z > 0.00
               );
   
private
   
   Geldzuwachs : ProduktionDatentypen.Produktion;
   Forschungszeit : ProduktionDatentypen.Lagermenge;
   
   Forschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;
   
   AktuelleRundenanzahl : ZahlenDatentypen.EigenesPositive;
   
   Rundengrenze : ZahlenDatentypen.EigenesNatural;
   
   Textbreite : Float;
      
   Textposition : Sf.System.Vector2.sfVector2f;
   
   FestzulegenderText : TextArrays.AllgemeinesTextArray (TextaccessVariablen.KarteWichtigesAccess'Range);

   
   
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

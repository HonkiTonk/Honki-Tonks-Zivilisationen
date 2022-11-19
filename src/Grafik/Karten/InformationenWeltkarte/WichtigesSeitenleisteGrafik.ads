with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with RassenDatentypen;
with KartenDatentypen; 
with SpielVariablen;
with KartenRecords;

private with TextaccessVariablen;
private with ProduktionDatentypen;
private with GrafikRecordKonstanten;
private with ForschungenDatentypen;

with LeseWeltkarteneinstellungen;

private with UmwandlungenAdaNachEigenes;

package WichtigesSeitenleisteGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   procedure WichtigesInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ViewbereichExtern : in Positive)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
private
   
   Geldzuwachs : ProduktionDatentypen.Produktion;
   Forschungszeit : ProduktionDatentypen.Lagermenge;
   
   Forschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;
   
   Textbreite : Float;
      
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type FestzulegenderTextArray is array (TextaccessVariablen.KarteWichtigesAccess'Range) of Unbounded_Wide_Wide_String;
   FestzulegenderText : FestzulegenderTextArray;

   
   
   function Rundenanzahl
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Rundenanzahl'Result)'Length > 0 
               );
   
   function Geld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   function Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   function ZahlAlsStringKostenLager is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.Produktion);
   
   function ZahlAlsStringEbeneVorhanden is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.EbeneVorhanden);
   
   function ZahlAlsStringPositive is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Natural);

end WichtigesSeitenleisteGrafik;

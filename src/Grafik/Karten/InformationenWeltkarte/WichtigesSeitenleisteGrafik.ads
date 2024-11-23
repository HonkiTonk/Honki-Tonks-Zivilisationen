private with Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

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

private with UmwandlungssystemHTB3;

package WichtigesSeitenleisteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   function WichtigesInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 TextpositionExtern.x > 0.00
               and
                 TextpositionExtern.y > 0.00
              ),
         
       Post => (
                  WichtigesInformationen'Result > 0.00
               );
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Forschungsprojekt : ForschungenDatentypen.ForschungID;
   
   Forschungszeit : ProduktionDatentypen.Lagermenge;
   
   Geldzuwachs : ProduktionDatentypen.Produktion;
   
   AktuelleRundenanzahl : ZahlenDatentypen.EigenesPositive;
   
   Rundengrenze : ZahlenDatentypen.EigenesNatural;
   
   Leerzeilen : Natural;
      
   YTextposition : Float;
   
   AnzuzeigenderText : TextArrays.AllgemeinesTextArray (TextaccessVariablen.KarteWichtigesAccess'Range);
   
   
         
   function Koordinaten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function Rundenanzahl
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Rundenanzahl'Result)'Length > 0 
               );
   
   function Geld
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   function Forschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   function ZahlAlsStringKostenLager is new UmwandlungssystemHTB3.Zahlenstring (GanzeZahl => ProduktionDatentypen.Produktion);
   
   function ZahlAlsStringEbeneVorhanden is new UmwandlungssystemHTB3.Zahlenstring (GanzeZahl => KartenDatentypen.EbeneVorhanden);
   
   function ZahlAlsStringPositive is new UmwandlungssystemHTB3.Zahlenstring (GanzeZahl => Natural);

end WichtigesSeitenleisteGrafik;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtGrafikRecords;
with EinheitenGrafikRecords;
with StadtKonstanten;
with KartenDatentypen;
with GrafikDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package KartenaufteilungGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.Einheitenbereich;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   procedure Weltkarte
     (EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord)
     with
       Pre => (
                 EinheitenauswahlExtern.SpeziesNummer.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenauswahlExtern.Koordinaten.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 EinheitenauswahlExtern.Koordinaten.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure Stadtkarte
     (StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord;
      AnzeigeExtern : in GrafikDatentypen.Stadt_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 StadtauswahlExtern.SpeziesNummer.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies)
               and
                 StadtauswahlExtern.Koordinaten.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 StadtauswahlExtern.Koordinaten.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
   
   RechtsLinksBefehlsanzeige : Boolean;
   
   Position : Sf.System.Vector2.sfVector2f;
   Viewgröße : Sf.System.Vector2.sfVector2f;

end KartenaufteilungGrafik;

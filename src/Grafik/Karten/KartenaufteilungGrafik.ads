private with Sf.System.Vector2;

with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtGrafikRecords;
with EinheitenGrafikRecords;
with StadtKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KartenaufteilungGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   procedure Weltkarte
     (EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord)
     with
       Pre => (
                 EinheitenauswahlExtern.SpeziesNummer.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure Stadtkarte
     (StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 StadtauswahlExtern.SpeziesNummer.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies)
              );
   
private
   
   RechtsLinksBefehlsanzeige : Boolean;
   
   Position : Sf.System.Vector2.sfVector2f;
   Viewgröße : Sf.System.Vector2.sfVector2f;

end KartenaufteilungGrafik;

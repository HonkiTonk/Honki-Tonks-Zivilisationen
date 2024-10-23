with Sf.System.Vector2;

with SpeziesDatentypen;
with KartenDatentypen;
with KartenRecords;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package UmwandlungenGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   function KoordinatenKartenposition
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              ),
         
       Post => (
                  KoordinatenKartenposition'Result.x >= -1.00
                and
                  KoordinatenKartenposition'Result.y >= -1.00
               );
   
private
   
   Sichtbereich : KartenRecords.KartenfeldumgebungPositivRecord;
   
   Feldposition : Sf.System.Vector2.sfVector2f;
   Kartenfeldfläche : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   CursorKoordinatenAlt : KartenRecords.KartenfeldNaturalRecord;

end UmwandlungenGrafik;

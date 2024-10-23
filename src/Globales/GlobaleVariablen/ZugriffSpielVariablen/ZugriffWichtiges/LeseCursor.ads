with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package LeseCursor is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   function KoordinatenAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KoordinatenAktuell'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  KoordinatenAktuell'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );
   pragma Inline (KoordinatenAktuell);
   
   function EbeneAktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenDatentypen.Ebene
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (EbeneAktuell);

   function KoordinatenAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KoordinatenAlt'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  KoordinatenAlt'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );
   pragma Inline (KoordinatenAlt);
   
   function SenkrechteAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenDatentypen.SenkrechtePositiv
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  SenkrechteAlt'Result <= LeseWeltkarteneinstellungen.Senkrechte
               );
   pragma Inline (SenkrechteAlt);
   
   function WaagerechteAlt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenDatentypen.WaagerechtePositiv
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  WaagerechteAlt'Result <= LeseWeltkarteneinstellungen.Waagerechte
               );
   pragma Inline (WaagerechteAlt);
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.ZeigerRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  GanzerEintrag'Result.KoordinatenAktuell.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  GanzerEintrag'Result.KoordinatenAktuell.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
                and
                  GanzerEintrag'Result.KoordinatenAlt.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  GanzerEintrag'Result.KoordinatenAlt.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );
   pragma Inline (GanzerEintrag);

end LeseCursor;

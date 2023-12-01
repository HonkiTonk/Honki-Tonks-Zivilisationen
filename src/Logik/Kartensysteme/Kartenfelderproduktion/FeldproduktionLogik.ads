with ProduktionDatentypen;
with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;

private with KartengrundDatentypen;

with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package FeldproduktionLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function Feldproduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Feldproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
private
   
   Basisgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
   
   Gesamtwert : ProduktionDatentypen.Feldproduktion;

end FeldproduktionLogik;

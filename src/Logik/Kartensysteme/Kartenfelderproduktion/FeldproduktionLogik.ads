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
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   function Feldproduktion
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Feldproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
   
   Basisgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
   
   Gesamtwert : ProduktionDatentypen.Feldproduktion;

end FeldproduktionLogik;

with ProduktionDatentypen;
with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;

private with KartengrundDatentypen;
private with KartenextraDatentypen;
private with KartenverbesserungDatentypen;

with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

private with Grenzpruefungen;

package FeldproduktionLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function Feldproduktion
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
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
   
   Gesamtgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
   
   RessourceVorhanden : KartenextraDatentypen.Ressourcen_Enum;
   
   VerbesserungVorhanden : KartenverbesserungDatentypen.Verbesserung_Enum;
   
   Gesamtwert : ProduktionDatentypen.Feldproduktion;
   
   Ressourcenbonus : ProduktionDatentypen.Produktionsbonus;
   Verbesserungsbonus : ProduktionDatentypen.Produktionsbonus;
   Flussbonus : ProduktionDatentypen.Produktionsbonus;
   Wegbonus : ProduktionDatentypen.Produktionsbonus;
   FeldeffektmalusZwischenspeicher : ProduktionDatentypen.Produktionsbonus;
   Feldeffektmalus : ProduktionDatentypen.Produktionsbonus;
   Gesamtbonus : ProduktionDatentypen.Produktionsbonus;
   
   FeldeffekteVorhanden : KartenRecords.FeldeffektArray;
   
   

   function FeldeffektemalusFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function MultiplikationPrüfen is new Grenzpruefungen.StandardKommamultiplikation (KommaZahl => ProduktionDatentypen.Produktionsbonus);

end FeldproduktionLogik;

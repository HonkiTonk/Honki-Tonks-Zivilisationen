with KartenDatentypen;
with SpeziesDatentypen;
with KartenRecords;
with ProduktionDatentypen;

private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with KartenextraDatentypen;

with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package NahrungsproduktionLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function NahrungsproduktionKartenfeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
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
   ZwischenspeicherMalus : ProduktionDatentypen.Produktionsbonus;
   Feldeffektmalus : ProduktionDatentypen.Produktionsbonus;
   Gesamtbonus : ProduktionDatentypen.Produktionsbonus;
   
   FeldeffekteVorhanden : KartenRecords.FeldeffektArray;
   
   
   
   function FeldeffektemalusFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Produktionsbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end NahrungsproduktionLogik;

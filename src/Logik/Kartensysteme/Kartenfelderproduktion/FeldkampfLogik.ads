with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;
with KampfDatentypen;

private with KartengrundDatentypen;
private with KartenextraDatentypen;
private with KartenverbesserungDatentypen;
private with ProduktionDatentypen;

with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

private with Grenzpruefungen;

package FeldkampfLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function Feldkampf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
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
   
   Gesamtwert : KampfDatentypen.KampfwerteAllgemein;
   
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
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
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

end FeldkampfLogik;

with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;
with KampfDatentypen;

private with KartengrundDatentypen;

with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

private with Grenzpruefungen;

package FeldkampfStadtLogik is
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

   function FeldeffektemalusFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
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
   
   Feldeffektmalus : KampfDatentypen.Kampfbonus;
   
   FeldeffekteVorhanden : KartenRecords.FeldeffektArray;
   
   function MultiplikationPrüfen is new Grenzpruefungen.StandardKommamultiplikation (KommaZahl => KampfDatentypen.Kampfbonus);

end FeldkampfStadtLogik;

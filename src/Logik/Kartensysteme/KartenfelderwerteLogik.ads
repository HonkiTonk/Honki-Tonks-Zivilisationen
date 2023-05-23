with KartenDatentypen;
with SpeziesDatentypen;
with KartenRecords;
with ProduktionDatentypen;
with KampfDatentypen;

private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with KartenextraDatentypen;
private with KartenKonstanten;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package KartenfelderwerteLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function FeldNahrung
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
   
   function FeldProduktion
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
     
   function FeldGeld
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
     
   function FeldWissen
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
   
   function FeldVerteidigung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KampfDatentypen.KampfwerteAllgemein
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function FeldAngriff
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
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
   
   Gesamtwert : ProduktionDatentypen.Feldproduktion;
   
   Gesamtgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
   
   type FeldeffektteilerArray is array (Boolean'Range) of ProduktionDatentypen.Feldproduktion;
   Feldeffektteiler : constant FeldeffektteilerArray := (
                                                         True  => 2,
                                                         False => 1
                                                        );
   
   LeerBonus : constant Float := 1.00;
   
   type RessourcenbonusArray is array (ProduktionDatentypen.Wirtschaft_Enum'Range, KartenextraDatentypen.Ressourcen_Enum'Range, KartenverbesserungDatentypen.Verbesserung_Enum'Range) of Float;
   Ressourcenbonus : constant RessourcenbonusArray := (
                                                       KartenKonstanten.WirtschaftNahrung =>
                                                         (
                                                          KartenextraDatentypen.Leer_Ressource_Enum =>
                                                            (
                                                             KartenverbesserungDatentypen.Leer_Verbesserung_Enum => LeerBonus,
                                                             others                                              => LeerBonus
                                                            ),
                                                          
                                                          others => (others => LeerBonus)),
                                                       
                                                       KartenKonstanten.WirtschaftMaterial =>
                                                         (
                                                          KartenextraDatentypen.Leer_Ressource_Enum =>
                                                            (
                                                             KartenverbesserungDatentypen.Leer_Verbesserung_Enum => LeerBonus,
                                                             others                                              => LeerBonus
                                                            ),
                                                          
                                                          others => (others => LeerBonus)),
                                                       
                                                       KartenKonstanten.WirtschaftGeld =>
                                                         (
                                                          KartenextraDatentypen.Leer_Ressource_Enum =>
                                                            (
                                                             KartenverbesserungDatentypen.Leer_Verbesserung_Enum => LeerBonus,
                                                             others                                              => LeerBonus
                                                            ),
                                                          
                                                          others => (others => LeerBonus)),
                                                       
                                                       KartenKonstanten.WirtschaftForschung =>
                                                         (
                                                          KartenextraDatentypen.Leer_Ressource_Enum =>
                                                            (
                                                             KartenverbesserungDatentypen.Leer_Verbesserung_Enum => LeerBonus,
                                                             others                                              => LeerBonus
                                                            ),
                                                          
                                                          others => (others => LeerBonus))
                                                      );
   
   
end KartenfelderwerteLogik;

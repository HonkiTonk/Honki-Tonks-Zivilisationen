with RassenDatentypen;
with KartenDatentypen;
with KartenRecords;

with LeseWeltkarteneinstellungen;
with LeseRassenbelegung;

package KIKartenfeldbewertungModifizierenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function BewertungStadtBauen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function StadtabstandVorhanden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
private
      
   GuteFelder : Float;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

   type KartenfeldBewertungStadtBauenMinimumArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Float;
   KartenfeldBewertungStadtBauenMinimum : constant KartenfeldBewertungStadtBauenMinimumArray := (
                                                                                                 RassenDatentypen.Menschen_Enum         => 10.00,
                                                                                                 RassenDatentypen.Kasrodiah_Enum        => 10.00,
                                                                                                 RassenDatentypen.Lasupin_Enum          => 10.00,
                                                                                                 RassenDatentypen.Lamustra_Enum         => 10.00,
                                                                                                 RassenDatentypen.Manuky_Enum           => 10.00,
                                                                                                 RassenDatentypen.Suroka_Enum           => 10.00,
                                                                                                 RassenDatentypen.Pryolon_Enum          => 10.00,
                                                                                                 RassenDatentypen.Talbidahr_Enum        => 10.00,
                                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => 10.00,
                                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => 10.00,
                                                                                                 RassenDatentypen.Carupex_Enum          => 10.00,
                                                                                                 RassenDatentypen.Alary_Enum            => 10.00,
                                                                                                 RassenDatentypen.Tesorahn_Enum         => 10.00,
                                                                                                 RassenDatentypen.Natries_Zermanis_Enum => 10.00,
                                                                                                 RassenDatentypen.Tridatus_Enum         => 10.00,
                                                                                                 RassenDatentypen.Senelari_Enum         => 10.00,
                                                                                                 RassenDatentypen.Aspari_2_Enum         => 10.00,
                                                                                                 RassenDatentypen.Ekropa_Enum           => 10.00
                                                                                                );
   
   
      
   function GutGenug
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end KIKartenfeldbewertungModifizierenLogik;

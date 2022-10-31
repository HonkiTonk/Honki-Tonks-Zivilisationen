pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with SpielVariablen;
with Weltkarte;

package KIKartenfeldbewertungModifizierenLogik is
   pragma Elaborate_Body;

   function BewertungStadtBauen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
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
   
   
   
   function StadtZuNahe
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function GutGenug
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

end KIKartenfeldbewertungModifizierenLogik;

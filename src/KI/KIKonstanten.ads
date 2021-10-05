pragma SPARK_Mode (On);

with KartenRecords, EinheitStadtDatentypen, SonstigeDatentypen;

with KIRecords;

package KIKonstanten is

   -- Nullwert für Koordinaten
   LeerKoordinate : constant KartenRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
   -- Nullwert für Koordinaten

   LeerEinheitIDBewertung : constant KIRecords.EinheitIDBewertungRecord := (0, 0);
   LeerGebäudeIDBewertung : constant KIRecords.GebäudeIDBewertungRecord := (0, 0);

   type KartenfeldBewertungStadtBauenMinimumArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.GesamtproduktionStadt;
   KartenfeldBewertungStadtBauenMinimum : constant KartenfeldBewertungStadtBauenMinimumArray := (
                                                                                                 SonstigeDatentypen.Menschen         => 10,
                                                                                                 SonstigeDatentypen.Kasrodiah        => 10,
                                                                                                 SonstigeDatentypen.Lasupin          => 10,
                                                                                                 SonstigeDatentypen.Lamustra         => 10,
                                                                                                 SonstigeDatentypen.Manuky           => 10,
                                                                                                 SonstigeDatentypen.Suroka           => 10,
                                                                                                 SonstigeDatentypen.Pryolon          => 10,
                                                                                                 SonstigeDatentypen.Talbidahr        => 10,
                                                                                                 SonstigeDatentypen.Moru_Phisihl     => 10,
                                                                                                 SonstigeDatentypen.Larinos_Lotaris  => 10,
                                                                                                 SonstigeDatentypen.Carupex          => 10,
                                                                                                 SonstigeDatentypen.Alary            => 10,
                                                                                                 SonstigeDatentypen.Tesorahn         => 10,
                                                                                                 SonstigeDatentypen.Natries_Zermanis => 10,
                                                                                                 SonstigeDatentypen.Tridatus         => 10,
                                                                                                 SonstigeDatentypen.Senelari         => 10,
                                                                                                 SonstigeDatentypen.Aspari_2         => 10,
                                                                                                 SonstigeDatentypen.Ekropa           => 10
                                                                                                );

end KIKonstanten;

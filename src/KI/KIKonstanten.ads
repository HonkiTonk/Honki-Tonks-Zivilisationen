pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;

package KIKonstanten is

   -- Nullwert für Koordinaten
   NullKoordinate : constant GlobaleRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
   -- Nullwert für Koordinaten

   type KartenfeldBewertungStadtBauenMinimumArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of GlobaleDatentypen.GesamtproduktionStadt;
   KartenfeldBewertungStadtBauenMinimum : constant KartenfeldBewertungStadtBauenMinimumArray := (
                                                                                                 GlobaleDatentypen.Menschen         => 10,
                                                                                                 GlobaleDatentypen.Kasrodiah        => 10,
                                                                                                 GlobaleDatentypen.Lasupin          => 10,
                                                                                                 GlobaleDatentypen.Lamustra         => 10,
                                                                                                 GlobaleDatentypen.Manuky           => 10,
                                                                                                 GlobaleDatentypen.Suroka           => 10,
                                                                                                 GlobaleDatentypen.Pryolon          => 10,
                                                                                                 GlobaleDatentypen.Talbidahr        => 10,
                                                                                                 GlobaleDatentypen.Moru_Phisihl     => 10,
                                                                                                 GlobaleDatentypen.Larinos_Lotaris  => 10,
                                                                                                 GlobaleDatentypen.Carupex          => 10,
                                                                                                 GlobaleDatentypen.Alary            => 10,
                                                                                                 GlobaleDatentypen.Tesorahn         => 10,
                                                                                                 GlobaleDatentypen.Natries_Zermanis => 10,
                                                                                                 GlobaleDatentypen.Tridatus         => 10,
                                                                                                 GlobaleDatentypen.Senelari         => 10,
                                                                                                 GlobaleDatentypen.Aspari_2         => 10,
                                                                                                 GlobaleDatentypen.Ekropa           => 10
                                                                                                );

end KIKonstanten;

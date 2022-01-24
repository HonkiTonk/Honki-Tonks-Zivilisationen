pragma SPARK_Mode (On);

with KartenRecords;
with SystemDatentypen;
with KartenDatentypen;

with KIDatentypen;
with KIRecords;

package KIKonstanten is

   -- Nullwert für Koordinaten
   LeerKoordinate : constant KartenRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
   -- Nullwert für Koordinaten

   LeerEinheitIDBewertung : constant KIRecords.EinheitIDBewertungRecord := (0, 0);
   LeerGebäudeIDBewertung : constant KIRecords.GebäudeIDBewertungRecord := (0, 0);

   type KartenfeldBewertungStadtBauenMinimumArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of KartenDatentypen.GesamtbewertungFeld;
   KartenfeldBewertungStadtBauenMinimum : constant KartenfeldBewertungStadtBauenMinimumArray := (
                                                                                                 SystemDatentypen.Menschen         => 10,
                                                                                                 SystemDatentypen.Kasrodiah        => 10,
                                                                                                 SystemDatentypen.Lasupin          => 10,
                                                                                                 SystemDatentypen.Lamustra         => 10,
                                                                                                 SystemDatentypen.Manuky           => 10,
                                                                                                 SystemDatentypen.Suroka           => 10,
                                                                                                 SystemDatentypen.Pryolon          => 10,
                                                                                                 SystemDatentypen.Talbidahr        => 10,
                                                                                                 SystemDatentypen.Moru_Phisihl     => 10,
                                                                                                 SystemDatentypen.Larinos_Lotaris  => 10,
                                                                                                 SystemDatentypen.Carupex          => 10,
                                                                                                 SystemDatentypen.Alary            => 10,
                                                                                                 SystemDatentypen.Tesorahn         => 10,
                                                                                                 SystemDatentypen.Natries_Zermanis => 10,
                                                                                                 SystemDatentypen.Tridatus         => 10,
                                                                                                 SystemDatentypen.Senelari         => 10,
                                                                                                 SystemDatentypen.Aspari_2         => 10,
                                                                                                 SystemDatentypen.Ekropa           => 10
                                                                                                );

   BewertungBewegungNullwert : constant KIDatentypen.BewegungBewertung := KIDatentypen.BewegungBewertung'First;
   BewertungBewegungZielpunkt : constant KIDatentypen.BewegungBewertung := KIDatentypen.BewegungBewertung'Last;

   BewegungAngriff : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Belegt_Angriff;
   BewegungNormal : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Unbelegt;
   KeineBewegung : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Belegt_Kein_Angriff;

end KIKonstanten;

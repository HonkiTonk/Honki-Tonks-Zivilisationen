pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with RassenDatentypen;
with KartenDatentypen;
with SpielDatentypen;

with KIDatentypen;
with KIRecords;

package KIKonstanten is

   LeerKoordinate : constant KartenRecords.AchsenKartenfeldNaturalRecord := (0, 0, 0);

   LeerEinheitIDBewertung : constant KIRecords.EinheitIDBewertungRecord := (0, 0);
   LeerGebäudeIDBewertung : constant KIRecords.GebäudeIDBewertungRecord := (0, 0);

   type KartenfeldBewertungStadtBauenMinimumArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenDatentypen.GesamteFeldbewertung;
   KartenfeldBewertungStadtBauenMinimum : constant KartenfeldBewertungStadtBauenMinimumArray := (
                                                                                                 RassenDatentypen.Menschen_Enum         => 10,
                                                                                                 RassenDatentypen.Kasrodiah_Enum        => 10,
                                                                                                 RassenDatentypen.Lasupin_Enum          => 10,
                                                                                                 RassenDatentypen.Lamustra_Enum         => 10,
                                                                                                 RassenDatentypen.Manuky_Enum           => 10,
                                                                                                 RassenDatentypen.Suroka_Enum           => 10,
                                                                                                 RassenDatentypen.Pryolon_Enum          => 10,
                                                                                                 RassenDatentypen.Talbidahr_Enum        => 10,
                                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => 10,
                                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => 10,
                                                                                                 RassenDatentypen.Carupex_Enum          => 10,
                                                                                                 RassenDatentypen.Alary_Enum            => 10,
                                                                                                 RassenDatentypen.Tesorahn_Enum         => 10,
                                                                                                 RassenDatentypen.Natries_Zermanis_Enum => 10,
                                                                                                 RassenDatentypen.Tridatus_Enum         => 10,
                                                                                                 RassenDatentypen.Senelari_Enum         => 10,
                                                                                                 RassenDatentypen.Aspari_2_Enum         => 10,
                                                                                                 RassenDatentypen.Ekropa_Enum           => 10
                                                                                                );

   BewertungBewegungNullwert : constant KIDatentypen.BewegungBewertung := KIDatentypen.BewegungBewertung'First;
   BewertungBewegungZielpunkt : constant KIDatentypen.BewegungBewertung := KIDatentypen.BewegungBewertung'Last;

   BewegungAngriff : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Belegt_Angriff_Enum;
   BewegungNormal : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Unbelegt_Enum;
   KeineBewegung : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Belegt_Kein_Angriff_Enum;

   type SchwierigkeitsgradArray is array (SpielDatentypen.Schwierigkeitsgrad_Enum'Range) of KIDatentypen.KINotAus;
   Schwierigkeitsgrad : constant SchwierigkeitsgradArray := (
                                                             SpielDatentypen.Schwierigkeitsgrad_Leicht_Enum => 10,
                                                             SpielDatentypen.Schwierigkeitsgrad_Mittel_Enum => 33,
                                                             SpielDatentypen.Schwierigkeitsgrad_Schwer_Enum => KIDatentypen.KINotAus'Last
                                                            );

end KIKonstanten;

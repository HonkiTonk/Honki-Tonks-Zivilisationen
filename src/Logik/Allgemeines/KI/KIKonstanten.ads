pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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
                                                                                                 SystemDatentypen.Menschen_Enum        => 10,
                                                                                                 SystemDatentypen.Kasrodiah_Enum       => 10,
                                                                                                 SystemDatentypen.Lasupin_Enum         => 10,
                                                                                                 SystemDatentypen.Lamustra_Enum        => 10,
                                                                                                 SystemDatentypen.Manuky_Enum          => 10,
                                                                                                 SystemDatentypen.Suroka_Enum          => 10,
                                                                                                 SystemDatentypen.Pryolon_Enum         => 10,
                                                                                                 SystemDatentypen.Talbidahr_Enum       => 10,
                                                                                                 SystemDatentypen.Moru_Phisihl_Enum     => 10,
                                                                                                 SystemDatentypen.Larinos_Lotaris_Enum  => 10,
                                                                                                 SystemDatentypen.Carupex_Enum         => 10,
                                                                                                 SystemDatentypen.Alary_Enum           => 10,
                                                                                                 SystemDatentypen.Tesorahn_Enum        => 10,
                                                                                                 SystemDatentypen.Natries_Zermanis_Enum => 10,
                                                                                                 SystemDatentypen.Tridatus_Enum        => 10,
                                                                                                 SystemDatentypen.Senelari_Enum        => 10,
                                                                                                 SystemDatentypen.Aspari_2_Enum         => 10,
                                                                                                 SystemDatentypen.Ekropa_Enum          => 10
                                                                                                );

   BewertungBewegungNullwert : constant KIDatentypen.BewegungBewertung := KIDatentypen.BewegungBewertung'First;
   BewertungBewegungZielpunkt : constant KIDatentypen.BewegungBewertung := KIDatentypen.BewegungBewertung'Last;

   BewegungAngriff : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Belegt_Angriff_Enum;
   BewegungNormal : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Unbelegt_Enum;
   KeineBewegung : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Belegt_Kein_Angriff_Enum;

end KIKonstanten;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with SystemDatentypen;
with KartenDatentypen;
with SystemKonstanten;

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
                                                                                                 SystemKonstanten.MenschenKonstante        => 10,
                                                                                                 SystemKonstanten.KasrodiahKonstante       => 10,
                                                                                                 SystemKonstanten.LasupinKonstante         => 10,
                                                                                                 SystemKonstanten.LamustraKonstante        => 10,
                                                                                                 SystemKonstanten.ManukyKonstante          => 10,
                                                                                                 SystemKonstanten.SurokaKonstante          => 10,
                                                                                                 SystemKonstanten.PryolonKonstante         => 10,
                                                                                                 SystemKonstanten.TalbidahrKonstante       => 10,
                                                                                                 SystemKonstanten.MoruPhisihlKonstante     => 10,
                                                                                                 SystemKonstanten.LarinosLotarisKonstante  => 10,
                                                                                                 SystemKonstanten.CarupexKonstante         => 10,
                                                                                                 SystemKonstanten.AlaryKonstante           => 10,
                                                                                                 SystemKonstanten.TesorahnKonstante        => 10,
                                                                                                 SystemKonstanten.NatriesZermanisKonstante => 10,
                                                                                                 SystemKonstanten.TridatusKonstante        => 10,
                                                                                                 SystemKonstanten.SenelariKonstante        => 10,
                                                                                                 SystemKonstanten.Aspari2Konstante         => 10,
                                                                                                 SystemKonstanten.EkropaKonstante          => 10
                                                                                                );

   BewertungBewegungNullwert : constant KIDatentypen.BewegungBewertung := KIDatentypen.BewegungBewertung'First;
   BewertungBewegungZielpunkt : constant KIDatentypen.BewegungBewertung := KIDatentypen.BewegungBewertung'Last;

   BewegungAngriff : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Belegt_Angriff;
   BewegungNormal : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Unbelegt;
   KeineBewegung : constant KIDatentypen.Bewegung_Enum := KIDatentypen.Belegt_Kein_Angriff;

end KIKonstanten;

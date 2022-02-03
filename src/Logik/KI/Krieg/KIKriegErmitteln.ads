pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with SystemKonstanten;

package KIKriegErmitteln is

   function IstImKrieg
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerKIKonstante);

   function KriegAnfangen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rassen_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerKIKonstante);

private

   RasseGewählt : SystemDatentypen.Rassen_Enum;
   Bewertung : EinheitStadtDatentypen.ProduktionFeld;

   type BewertungenArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   Bewertungen : BewertungenArray;

   NotwendigeBewertung : constant BewertungenArray := (
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
                                                       SystemKonstanten.EkropaKonstante          => 0
                                                      );

   function StärkeVerhältnisErmitteln
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rassen_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemKonstanten.SpielerKIKonstante
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            EigeneRasseExtern /= FremdeRasseExtern);

end KIKriegErmitteln;

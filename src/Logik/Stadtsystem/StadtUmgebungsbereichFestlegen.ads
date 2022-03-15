pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with KartenDatentypen;
with SystemKonstanten;

package StadtUmgebungsbereichFestlegen is
   
   type TechnologieUmgebungsgrößeArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of EinheitStadtDatentypen.ForschungID;
   TechnologieUmgebungsgröße : constant TechnologieUmgebungsgrößeArray := (
                                                                               SystemKonstanten.MenschenKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
                                                                                             
                                                                               SystemKonstanten.KasrodiahKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.LasupinKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
                                                                               
                                                                               SystemKonstanten.LamustraKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.ManukyKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.SurokaKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.PryolonKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.TalbidahrKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.MoruPhisihlKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.LarinosLotarisKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.CarupexKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.AlaryKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.TesorahnKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.NatriesZermanisKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.TridatusKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.SenelariKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.Aspari2Konstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemKonstanten.EkropaKonstante =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43)
                                                                              );

   procedure StadtUmgebungsbereichFestlegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
private
   
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   procedure StadtUmgebungErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end StadtUmgebungsbereichFestlegen;

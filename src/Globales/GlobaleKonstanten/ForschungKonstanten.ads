pragma SPARK_Mode (On);

with EinheitStadtDatentypen;
with SystemDatentypen;
with SystemKonstanten;

with DatenbankRecords;

package ForschungKonstanten is
   
   LeerPreisForschung : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerForschungAnforderung : constant EinheitStadtDatentypen.ForschungIDMitNullWert := EinheitStadtDatentypen.ForschungIDMitNullWert'First;
   ForschungUnmöglich : constant EinheitStadtDatentypen.ForschungIDNichtMöglich := EinheitStadtDatentypen.ForschungIDNichtMöglich'First;
   
   LeerForschungListe : constant DatenbankRecords.ForschungListeRecord := (
                                                                           PreisForschung       => LeerPreisForschung,
                                                                           AnforderungForschung => (others => ForschungUnmöglich)
                                                                          );
   
   type TechnologieVerbesserungArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Tastenbelegung_Befehle_Enum'Range) of EinheitStadtDatentypen.ForschungIDNichtMöglich;
   TechnologieVerbesserung : constant TechnologieVerbesserungArray := (
                                                                       SystemKonstanten.MenschenKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.KasrodiahKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.LasupinKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.LamustraKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.ManukyKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.SurokaKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.PryolonKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.TalbidahrKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.MoruPhisihlKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.LarinosLotarisKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.CarupexKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.AlaryKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.TesorahnKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.NatriesZermanisKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.TridatusKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.SenelariKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.Aspari2Konstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.EkropaKonstante =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                              => LeerForschungAnforderung
                                                                         )
                                                                      );

end ForschungKonstanten;

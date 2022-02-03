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
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.KasrodiahKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.LasupinKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.LamustraKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.ManukyKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.SurokaKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.PryolonKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.TalbidahrKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.MoruPhisihlKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.LarinosLotarisKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.CarupexKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.AlaryKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.TesorahnKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.NatriesZermanisKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.TridatusKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.SenelariKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.Aspari2Konstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.EkropaKonstante =>
                                                                         (
                                                                          SystemKonstanten.StraßeBauenKonstante       => 0,
                                                                          SystemKonstanten.WaldAufforstenKonstante    => 0,
                                                                          SystemKonstanten.MineBauenKonstante         => 6,
                                                                          SystemKonstanten.FarmBauenKonstante         => 2,
                                                                          SystemKonstanten.FestungBauenKonstante      => 11,
                                                                          SystemKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         )
                                                                      );

end ForschungKonstanten;

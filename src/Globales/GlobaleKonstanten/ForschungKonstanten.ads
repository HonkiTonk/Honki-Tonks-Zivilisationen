pragma SPARK_Mode (On);

with EinheitStadtDatentypen;
with SystemDatentypen;
with SystemKonstanten;
with TastenbelegungDatentypen;
with TastenbelegungKonstanten;

with DatenbankRecords;

package ForschungKonstanten is
   
   LeerPreisForschung : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerForschungAnforderung : constant EinheitStadtDatentypen.ForschungIDMitNullWert := EinheitStadtDatentypen.ForschungIDMitNullWert'First;
   ForschungUnmöglich : constant EinheitStadtDatentypen.ForschungIDNichtMöglich := EinheitStadtDatentypen.ForschungIDNichtMöglich'First;
   
   LeerForschungListe : constant DatenbankRecords.ForschungListeRecord := (
                                                                           PreisForschung       => LeerPreisForschung,
                                                                           AnforderungForschung => (others => ForschungUnmöglich)
                                                                          );
   
   type TechnologieVerbesserungArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum'Range) of EinheitStadtDatentypen.ForschungIDNichtMöglich;
   TechnologieVerbesserung : constant TechnologieVerbesserungArray := (
                                                                       SystemKonstanten.MenschenKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.KasrodiahKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.LasupinKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.LamustraKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.ManukyKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.SurokaKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.PryolonKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.TalbidahrKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.MoruPhisihlKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.LarinosLotarisKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.CarupexKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.AlaryKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.TesorahnKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.NatriesZermanisKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.TridatusKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.SenelariKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.Aspari2Konstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         ),

                                                                       SystemKonstanten.EkropaKonstante =>
                                                                         (
                                                                          TastenbelegungKonstanten.StraßeBauenKonstante       => 0,
                                                                          TastenbelegungKonstanten.WaldAufforstenKonstante    => 0,
                                                                          TastenbelegungKonstanten.MineBauenKonstante         => 6,
                                                                          TastenbelegungKonstanten.FarmBauenKonstante         => 2,
                                                                          TastenbelegungKonstanten.FestungBauenKonstante      => 11,
                                                                          TastenbelegungKonstanten.RodenTrockenlegenKonstante => 1,
                                                                          others                                      => LeerForschungAnforderung
                                                                         )
                                                                      );

end ForschungKonstanten;

pragma SPARK_Mode (On);

with GlobaleDatentypen;

with DatenbankRecords;

package ForschungKonstanten is
   
   LeerPreisForschung : constant GlobaleDatentypen.KostenLager := 0;
   LeerForschungAnforderung : constant GlobaleDatentypen.ForschungIDMitNullWert := GlobaleDatentypen.ForschungIDMitNullWert'First;
   
   LeerForschungListe : constant DatenbankRecords.ForschungListeRecord := (
                                                                           PreisForschung       => LeerPreisForschung,
                                                                           AnforderungForschung => (others => LeerForschungAnforderung)
                                                                          );
   
   type TechnologieVerbesserungArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.Tastenbelegung_Befehle_Enum'Range) of GlobaleDatentypen.ForschungIDNichtMöglich;
   TechnologieVerbesserung : constant TechnologieVerbesserungArray := (
                                                                       GlobaleDatentypen.Menschen =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Kasrodiah =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Lasupin =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Lamustra =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Manuky =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Suroka =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Pryolon =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Talbidahr =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Moru_Phisihl =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Larinos_Lotaris =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Carupex =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Alary =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Tesorahn =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Natries_Zermanis =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Tridatus =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Senelari =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Aspari_2 =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       GlobaleDatentypen.Ekropa =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         )
                                                                      );

end ForschungKonstanten;

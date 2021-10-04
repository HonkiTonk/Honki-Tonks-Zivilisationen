pragma SPARK_Mode (On);

with GlobaleDatentypen, EinheitStadtDatentypen, SonstigeDatentypen;

with DatenbankRecords;

package ForschungKonstanten is
   
   LeerPreisForschung : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerForschungAnforderung : constant EinheitStadtDatentypen.ForschungIDMitNullWert := EinheitStadtDatentypen.ForschungIDMitNullWert'First;
   
   LeerForschungListe : constant DatenbankRecords.ForschungListeRecord := (
                                                                           PreisForschung       => LeerPreisForschung,
                                                                           AnforderungForschung => (others => LeerForschungAnforderung)
                                                                          );
   
   type TechnologieVerbesserungArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.Tastenbelegung_Befehle_Enum'Range) of EinheitStadtDatentypen.ForschungIDNichtMöglich;
   TechnologieVerbesserung : constant TechnologieVerbesserungArray := (
                                                                       SonstigeDatentypen.Menschen =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Kasrodiah =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Lasupin =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Lamustra =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Manuky =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Suroka =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Pryolon =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Talbidahr =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Moru_Phisihl =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Larinos_Lotaris =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Carupex =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Alary =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Tesorahn =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Natries_Zermanis =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Tridatus =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Senelari =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Aspari_2 =>
                                                                         (
                                                                          GlobaleDatentypen.Straße_Bauen       => 0,
                                                                          GlobaleDatentypen.Wald_Aufforsten    => 0,
                                                                          GlobaleDatentypen.Mine_Bauen         => 6,
                                                                          GlobaleDatentypen.Farm_Bauen         => 2,
                                                                          GlobaleDatentypen.Festung_Bauen      => 11,
                                                                          GlobaleDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Ekropa =>
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

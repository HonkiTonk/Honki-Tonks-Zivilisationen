pragma SPARK_Mode (On);

with EinheitStadtDatentypen;
with SonstigeDatentypen;
with SystemDatentypen;

with DatenbankRecords;

package ForschungKonstanten is
   
   LeerPreisForschung : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerForschungAnforderung : constant EinheitStadtDatentypen.ForschungIDMitNullWert := EinheitStadtDatentypen.ForschungIDMitNullWert'First;
   
   LeerForschungListe : constant DatenbankRecords.ForschungListeRecord := (
                                                                           PreisForschung       => LeerPreisForschung,
                                                                           AnforderungForschung => (others => LeerForschungAnforderung)
                                                                          );
   
   type TechnologieVerbesserungArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Tastenbelegung_Befehle_Enum'Range) of EinheitStadtDatentypen.ForschungIDNichtMöglich;
   TechnologieVerbesserung : constant TechnologieVerbesserungArray := (
                                                                       SonstigeDatentypen.Menschen =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Kasrodiah =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Lasupin =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Lamustra =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Manuky =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Suroka =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Pryolon =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Talbidahr =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Moru_Phisihl =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Larinos_Lotaris =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Carupex =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Alary =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Tesorahn =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Natries_Zermanis =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Tridatus =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Senelari =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Aspari_2 =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SonstigeDatentypen.Ekropa =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         )
                                                                      );

end ForschungKonstanten;

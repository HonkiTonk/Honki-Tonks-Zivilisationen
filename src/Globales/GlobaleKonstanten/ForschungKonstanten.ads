pragma SPARK_Mode (On);

with EinheitStadtDatentypen;
with SystemDatentypen;

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
                                                                       SystemDatentypen.Menschen =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Kasrodiah =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Lasupin =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Lamustra =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Manuky =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Suroka =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Pryolon =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Talbidahr =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Moru_Phisihl =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Larinos_Lotaris =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Carupex =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Alary =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Tesorahn =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Natries_Zermanis =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Tridatus =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Senelari =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Aspari_2 =>
                                                                         (
                                                                          SystemDatentypen.Straße_Bauen       => 0,
                                                                          SystemDatentypen.Wald_Aufforsten    => 0,
                                                                          SystemDatentypen.Mine_Bauen         => 6,
                                                                          SystemDatentypen.Farm_Bauen         => 2,
                                                                          SystemDatentypen.Festung_Bauen      => 11,
                                                                          SystemDatentypen.Roden_Trockenlegen => 1,
                                                                          others                               => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Ekropa =>
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

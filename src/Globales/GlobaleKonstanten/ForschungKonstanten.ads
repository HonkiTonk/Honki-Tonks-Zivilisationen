pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen;
with SystemDatentypen;
with TastenbelegungDatentypen;

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
                                                                       SystemDatentypen.Menschen_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Kasrodiah_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Lasupin_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Lamustra_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Manuky_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Suroka_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Pryolon_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Talbidahr_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Moru_Phisihl_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Larinos_Lotaris_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Carupex_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Alary_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Tesorahn_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Natries_Zermanis_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Tridatus_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Senelari_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Aspari_2_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         ),

                                                                       SystemDatentypen.Ekropa_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1,
                                                                          others                                           => LeerForschungAnforderung
                                                                         )
                                                                      );

end ForschungKonstanten;

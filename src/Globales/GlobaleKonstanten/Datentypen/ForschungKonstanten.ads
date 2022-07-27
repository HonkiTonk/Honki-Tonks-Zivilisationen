pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with TastenbelegungDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with AufgabenDatentypen;

with DatenbankRecords;

package ForschungKonstanten is
   
   LeerPreisForschung : constant ProduktionDatentypen.Produktion := 0;
   LeerForschung : constant ForschungenDatentypen.ForschungIDMitNullWert := ForschungenDatentypen.ForschungIDMitNullWert'First;
   LeerForschungAnforderung : constant ForschungenDatentypen.ForschungIDMitNullWert := ForschungenDatentypen.ForschungIDMitNullWert'First;
   ForschungUnmöglich : constant ForschungenDatentypen.ForschungIDNichtMöglich := ForschungenDatentypen.ForschungIDNichtMöglich'First;
   
   LeerForschungListe : constant DatenbankRecords.ForschungslisteRecord := (
                                                                            PreisForschung       => LeerPreisForschung,
                                                                            AnforderungForschung => (others => ForschungUnmöglich)
                                                                           );
   
   -- Später so umbauen dass es auch veränderbar ist. äöü
   type TechnologieVerbesserungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range) of ForschungenDatentypen.ForschungIDNichtMöglich;
   TechnologieVerbesserung : constant TechnologieVerbesserungArray := (
                                                                       RassenDatentypen.Menschen_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Kasrodiah_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Lasupin_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Lamustra_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Manuky_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Suroka_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Pryolon_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Talbidahr_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Moru_Phisihl_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Larinos_Lotaris_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Carupex_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Alary_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Tesorahn_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Natries_Zermanis_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Tridatus_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Senelari_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Aspari_2_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         ),

                                                                       RassenDatentypen.Ekropa_Enum =>
                                                                         (
                                                                          TastenbelegungDatentypen.Straße_Bauen_Enum       => 0,
                                                                          TastenbelegungDatentypen.Wald_Aufforsten_Enum    => 0,
                                                                          TastenbelegungDatentypen.Mine_Bauen_Enum         => 6,
                                                                          TastenbelegungDatentypen.Farm_Bauen_Enum         => 2,
                                                                          TastenbelegungDatentypen.Festung_Bauen_Enum      => 11,
                                                                          TastenbelegungDatentypen.Roden_Trockenlegen_Enum => 1
                                                                         )
                                                                      );
      
   -- Später so umbauen dass es auch veränderbar ist. äöü
   type TechnologischeVoraussetzungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range) of ForschungenDatentypen.ForschungIDNichtMöglich;
   TechnologischeVoraussetzung : constant TechnologischeVoraussetzungArray := (
                                                                               RassenDatentypen.Menschen_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Kasrodiah_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Lasupin_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Lamustra_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Manuky_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Suroka_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Pryolon_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Moru_Phisihl_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Larinos_Lotaris_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Carupex_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Alary_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Natries_Zermanis_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Tridatus_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Senelari_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Aspari_2_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Ekropa_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Tesorahn_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 ),

                                                                               RassenDatentypen.Talbidahr_Enum =>
                                                                                 (
                                                                                  AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                                  AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                                  AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                                 )
                                                                              );

end ForschungKonstanten;

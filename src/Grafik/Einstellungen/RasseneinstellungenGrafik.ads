with Sf.Graphics.Color;

with RassenDatentypen;

package RasseneinstellungenGrafik is
   pragma Elaborate_Body;
   
   type RassenFarbenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Sf.Graphics.Color.sfColor;
   Rassenfarben : RassenFarbenArray;
   RassenfarbenRahmen : RassenFarbenArray;
   
   procedure StandardLaden;
   
private
   
   RassenfarbenStandard : constant RassenFarbenArray := (
                                                         RassenDatentypen.Menschen_Enum         => (255, 230, 200, 75),
                                                         RassenDatentypen.Kasrodiah_Enum        => (255, 100, 40, 75),
                                                         RassenDatentypen.Lasupin_Enum          => (65, 145, 140, 75),
                                                         RassenDatentypen.Lamustra_Enum         => (60, 255, 240, 75),
                                                         RassenDatentypen.Manuky_Enum           => (255, 255, 30, 75),
                                                         RassenDatentypen.Suroka_Enum           => (135, 10, 255, 75),
                                                         RassenDatentypen.Pryolon_Enum          => (65, 50, 15, 75),
                                                         RassenDatentypen.Talbidahr_Enum        => (255, 20, 255, 75),
                                                         RassenDatentypen.Moru_Phisihl_Enum     => (255, 255, 180, 75),
                                                         RassenDatentypen.Larinos_Lotaris_Enum  => (255, 210, 135, 75),
                                                         RassenDatentypen.Carupex_Enum          => (210, 210, 210, 75),
                                                         RassenDatentypen.Alary_Enum            => (165, 105, 0, 75),
                                                         RassenDatentypen.Tesorahn_Enum         => (10, 60, 240, 75),
                                                         RassenDatentypen.Natries_Zermanis_Enum => (170, 120, 130, 75),
                                                         RassenDatentypen.Tridatus_Enum         => (20, 95, 20, 75),
                                                         RassenDatentypen.Senelari_Enum         => (0, 210, 0, 75),
                                                         RassenDatentypen.Aspari_2_Enum         => (90, 90, 90, 75),
                                                         RassenDatentypen.Ekropa_Enum           => (255, 30, 30, 75)
                                                        );
   
   RassenfarbenRahmenStandard : constant RassenFarbenArray := (
                                                               RassenDatentypen.Menschen_Enum         => (255, 230, 200, 255),
                                                               RassenDatentypen.Kasrodiah_Enum        => (255, 100, 40, 255),
                                                               RassenDatentypen.Lasupin_Enum          => (65, 145, 140, 255),
                                                               RassenDatentypen.Lamustra_Enum         => (60, 255, 240, 255),
                                                               RassenDatentypen.Manuky_Enum           => (255, 255, 30, 255),
                                                               RassenDatentypen.Suroka_Enum           => (135, 10, 255, 255),
                                                               RassenDatentypen.Pryolon_Enum          => (65, 50, 15, 255),
                                                               RassenDatentypen.Talbidahr_Enum        => (255, 20, 255, 255),
                                                               RassenDatentypen.Moru_Phisihl_Enum     => (255, 255, 180, 255),
                                                               RassenDatentypen.Larinos_Lotaris_Enum  => (255, 210, 135, 255),
                                                               RassenDatentypen.Carupex_Enum          => (210, 210, 210, 255),
                                                               RassenDatentypen.Alary_Enum            => (165, 105, 0, 255),
                                                               RassenDatentypen.Tesorahn_Enum         => (10, 60, 240, 255),
                                                               RassenDatentypen.Natries_Zermanis_Enum => (170, 120, 130, 255),
                                                               RassenDatentypen.Tridatus_Enum         => (20, 95, 20, 255),
                                                               RassenDatentypen.Senelari_Enum         => (0, 210, 0, 255),
                                                               RassenDatentypen.Aspari_2_Enum         => (90, 90, 90, 255),
                                                               RassenDatentypen.Ekropa_Enum           => (255, 30, 30, 255)
                                                              );

end RasseneinstellungenGrafik;
